/**
 * 视觉规范：颜色、圆角、间距。成员D负责维护，其他成员只引用不新增散落色值。
 */
export class AppTheme {
  static readonly PRIMARY: string = '#2F6BFF';
  static readonly PRIMARY_DARK: string = '#1B4FD8';
  static readonly PRIMARY_LIGHT: string = '#EEF3FF';
  static readonly BG_PAGE: string = '#F5F6FA';
  static readonly BG_PLACEHOLDER: string = '#EEF1F6';
  static readonly TEXT_PRIMARY: string = '#111827';
  static readonly TEXT_SECONDARY: string = '#6B7280';
  static readonly TEXT_TERTIARY: string = '#9CA3AF';
  static readonly DANGER: string = '#FF4D4F';
  static readonly SUCCESS: string = '#10B981';
  static readonly WARNING: string = '#F59E0B';
  static readonly BORDER: string = '#E5E7EB';
  static readonly WHITE: string = '#FFFFFF';

  static readonly RADIUS_CARD: number = 16;
  static readonly RADIUS_PILL: number = 999;
  static readonly PAGE_PADDING: number = 16;
}
