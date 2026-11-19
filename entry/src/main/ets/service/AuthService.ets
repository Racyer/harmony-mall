import { AppConstants } from '../common/constants/AppConstants';

/**
 * 模拟登录服务。课程演示账号 demo / 123456，其他账号只要密码不少于 6 位即可登录。
 * 接入真实后端时替换为 token 接口，页面无需改动。
 */
export class AuthService {
  static login(account: string, password: string): boolean {
    const name: string = account.trim();
    if (name.length === 0 || password.length < 6) {
      return false;
    }
    if (name === AppConstants.DEMO_ACCOUNT && password !== AppConstants.DEMO_PASSWORD) {
      return false;
    }
    const token: string = `mock-token-${Date.now()}`;
    const displayName: string = name === AppConstants.DEMO_ACCOUNT ? '鸿蒙体验官' : name;
    AppStorage.setOrCreate<string>(AppConstants.TOKEN_KEY, token);
    AppStorage.setOrCreate<string>(AppConstants.USER_NAME_KEY, displayName);
    return true;
  }

  static logout(): void {
    AppStorage.setOrCreate<string>(AppConstants.TOKEN_KEY, '');
    AppStorage.setOrCreate<string>(AppConstants.USER_NAME_KEY, '');
  }

  static isLoggedIn(): boolean {
    const token: string = AppStorage.get<string>(AppConstants.TOKEN_KEY) ?? '';
    return token.length > 0;
  }

  static getUserName(): string {
    return AppStorage.get<string>(AppConstants.USER_NAME_KEY) ?? '';
  }
}
