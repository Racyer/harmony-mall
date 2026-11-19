import { Product } from '../model/Product';
import { AppConstants } from '../common/constants/AppConstants';
import { ProductService } from './ProductService';

/**
 * 收藏服务：只持久化商品 id 数组。
 */
export class FavoriteService {
  static getIds(): number[] {
    const raw: string = AppStorage.get<string>(AppConstants.FAVORITES_KEY) ?? '[]';
    try {
      return JSON.parse(raw) as number[];
    } catch (error) {
      return [];
    }
  }

  static isFavorite(productId: number): boolean {
    return FavoriteService.getIds().indexOf(productId) >= 0;
  }

  /** 返回切换后的收藏状态 */
  static toggle(productId: number): boolean {
    const ids: number[] = FavoriteService.getIds();
    const index: number = ids.indexOf(productId);
    if (index >= 0) {
      ids.splice(index, 1);
      AppStorage.setOrCreate(AppConstants.FAVORITES_KEY, JSON.stringify(ids));
      return false;
    }
    ids.push(productId);
    AppStorage.setOrCreate(AppConstants.FAVORITES_KEY, JSON.stringify(ids));
    return true;
  }

  static getProducts(): Product[] {
    const result: Product[] = [];
    const ids: number[] = FavoriteService.getIds();
    for (let i = 0; i < ids.length; i++) {
      const product: Product | undefined = ProductService.getById(ids[i]);
      if (product !== undefined) {
        result.push(product);
      }
    }
    return result;
  }

  static count(): number {
    return FavoriteService.getIds().length;
  }
}
