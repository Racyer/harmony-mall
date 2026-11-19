import { Product } from '../model/Product';
import { PRODUCTS } from '../data/MockData';

/**
 * 商品服务：目前读本地 MockData；接入后端时只改这一层。
 */
export class ProductService {
  static getAll(): Product[] {
    return PRODUCTS;
  }

  static getById(id: number): Product | undefined {
    return PRODUCTS.find((item: Product) => item.id === id);
  }

  static getByCategory(categoryId: number, offset: number, limit: number): Product[] {
    const source: Product[] = categoryId === 0
      ? PRODUCTS
      : PRODUCTS.filter((item: Product) => item.categoryId === categoryId);
    return source.slice(offset, offset + limit);
  }

  static search(keyword: string): Product[] {
    const key: string = keyword.trim().toLowerCase();
    if (key.length === 0) {
      return PRODUCTS;
    }
    return PRODUCTS.filter((item: Product) => {
      const hitName: boolean = item.name.toLowerCase().includes(key);
      const hitSubtitle: boolean = item.subtitle.toLowerCase().includes(key);
      const hitTag: boolean = item.tags.some((tag: string) => tag.toLowerCase().includes(key));
      return hitName || hitSubtitle || hitTag;
    });
  }

  static getHotProducts(): Product[] {
    return PRODUCTS.slice(0, 4);
  }

  static getTotalCount(categoryId: number): number {
    if (categoryId === 0) {
      return PRODUCTS.length;
    }
    return PRODUCTS.filter((item: Product) => item.categoryId === categoryId).length;
  }
}
