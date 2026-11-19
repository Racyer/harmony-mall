#!/usr/bin/env python3
"""Static checks for the HarmonyOS project: pages, routes, imports and resources."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ETS = ROOT / "entry" / "src" / "main" / "ets"
RES = ROOT / "entry" / "src" / "main" / "resources" / "base"
APP_RES = ROOT / "AppScope" / "resources" / "base"
errors = []


def load_names(path, key):
    if not path.exists():
        return set()
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except Exception as exc:  # noqa: BLE001
        errors.append(f"无法解析 {path.relative_to(ROOT)}: {exc}")
        return set()
    return {item.get("name") for item in data.get(key, [])}


required = [
    "build-profile.json5",
    "oh-package.json5",
    "hvigorfile.ts",
    "hvigor/hvigor-config.json5",
    "AppScope/app.json5",
    "entry/build-profile.json5",
    "entry/oh-package.json5",
    "entry/hvigorfile.ts",
    "entry/src/main/module.json5",
    "entry/src/main/ets/entryability/EntryAbility.ets",
    "entry/src/main/ets/pages/Index.ets",
    "entry/src/main/resources/base/profile/main_pages.json",
]
for rel in required:
    if not (ROOT / rel).exists():
        errors.append(f"缺少必要文件: {rel}")

pages_file = RES / "profile" / "main_pages.json"
pages = []
if pages_file.exists():
    try:
        pages = json.loads(pages_file.read_text(encoding="utf-8")).get("src", [])
    except Exception as exc:  # noqa: BLE001
        errors.append(f"main_pages.json 解析失败: {exc}")

for page in pages:
    if not (ETS / f"{page}.ets").exists():
        errors.append(f"main_pages 注册的页面不存在: {page}.ets")

ets_files = sorted(ETS.rglob("*.ets"))
for file in ets_files:
    text = file.read_text(encoding="utf-8")
    rel = file.relative_to(ETS).with_suffix("").as_posix()
    if "@Entry" in text and rel not in pages:
        errors.append(f"@Entry 页面未注册到 main_pages.json: {rel}")
    for imp in re.findall(r"from\s+['\"](\.[^'\"]+)['\"]", text):
        target = (file.parent / imp).resolve()
        if not target.exists() and not target.with_suffix(".ets").exists():
            errors.append(f"{file.relative_to(ROOT)}: 找不到导入 {imp}")

media_dirs = [RES / "media", APP_RES / "media"]
colors = load_names(RES / "element" / "color.json", "color") | load_names(
    APP_RES / "element" / "color.json", "color"
)
strings = load_names(RES / "element" / "string.json", "string") | load_names(
    APP_RES / "element" / "string.json", "string"
)
exts = (".png", ".svg", ".jpg", ".jpeg", ".webp", ".gif")


def has_media(name):
    return any((d / f"{name}{ext}").exists() for d in media_dirs for ext in exts)


for file in ets_files:
    text = file.read_text(encoding="utf-8")
    for name in re.findall(r"\$r\(['\"]app\.media\.([A-Za-z0-9_]+)['\"]\)", text):
        if not has_media(name):
            errors.append(f"{file.relative_to(ROOT)}: 缺少媒体资源 $media:{name}")
    for name in re.findall(r"\$r\(['\"]app\.color\.([A-Za-z0-9_]+)['\"]\)", text):
        if name not in colors:
            errors.append(f"{file.relative_to(ROOT)}: 缺少颜色资源 $color:{name}")
    for name in re.findall(r"\$r\(['\"]app\.string\.([A-Za-z0-9_]+)['\"]\)", text):
        if name not in strings:
            errors.append(f"{file.relative_to(ROOT)}: 缺少字符串资源 $string:{name}")

for cfg in [ROOT / "AppScope" / "app.json5", ROOT / "entry" / "src" / "main" / "module.json5"]:
    if not cfg.exists():
        continue
    text = cfg.read_text(encoding="utf-8")
    for name in re.findall(r"\$media:([A-Za-z0-9_]+)", text):
        if not has_media(name):
            errors.append(f"{cfg.relative_to(ROOT)}: 缺少媒体资源 $media:{name}")
    for name in re.findall(r"\$color:([A-Za-z0-9_]+)", text):
        if name not in colors:
            errors.append(f"{cfg.relative_to(ROOT)}: 缺少颜色资源 $color:{name}")
    for name in re.findall(r"\$string:([A-Za-z0-9_]+)", text):
        if name not in strings:
            errors.append(f"{cfg.relative_to(ROOT)}: 缺少字符串资源 $string:{name}")

route_file = ETS / "common" / "constants" / "RouteConstants.ets"
if route_file.exists():
    for url in re.findall(r"'(pages/[A-Za-z0-9_]+)'", route_file.read_text(encoding="utf-8")):
        if url not in pages:
            errors.append(f"RouteConstants 中的路由未注册: {url}")

if errors:
    print(f"[repo-check] FAILED with {len(errors)} issue(s):")
    for item in errors:
        print(f"  - {item}")
    sys.exit(1)

print(
    f"[repo-check] OK: {len(ets_files)} ArkTS files, {len(pages)} pages, "
    f"{len(colors)} colors, {len(strings)} strings checked."
)
