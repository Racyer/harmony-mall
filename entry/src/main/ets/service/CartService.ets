import { CartItem, CartLine } from '../model/CartItem';
import { Product } from '../model/Product';
import { AppConstants } from '../common/constants/AppConstants';
import { ProductService } from './ProductService';

/**
 * 购物车服务：数据持久化在 AppStorage/PersistentStorage 的 JSON 字符串中。
 * 所有写操作统一走 save()，保证角标数量与列表同步刷新。
 */
export class CartService {
  static getItems(): CartItem[] {
    const raw: string = AppStorage.get<string>(AppConstants.CART_KEY) ?? '[]';
    try {
      return JSON.parse(raw) as CartItem[];
    } catch (error) {
      return [];
    }
  }

  static save(items: CartItem[]): void {
    AppStorage.setOrCreate<string>(AppConstants.CART_KEY, JSON.stringify(items));
    let count: number = 0;
    for (let i = 0; i < items.length; i++) {
      count += items[i].quantity;
    }
    AppStorage.setOrCreate<number>(AppConstants.CART_COUNT_KEY, count);
  }

  static add(productId: number, quantity: number = 1): void {
    const items: CartItem[] = CartService.getItems();
    let found: boolean = false;
    for (let i = 0; i < items.length; i++) {
      if (items[i].productId === productId) {
        items[i].quantity = Math.min(items[i].quantity + quantity, 99);
        items[i].selected = true;
        found = true;
        break;
      }
    }
    if (!found) {
      const item: CartItem = {
        productId: productId,
        quantity: quantity,
        selected: true
      };
      items.push(item);
    }
    CartService.save(items);
  }

  static remove(productId: number): void {
    const items: CartItem[] = CartService.getItems();
    const remain: CartItem[] = [];
    for (let i = 0; i < items.length; i++) {
      if (items[i].productId !== productId) {
        remain.push(items[i]);
      }
    }
    CartService.save(remain);
  }

  static updateQuantity(productId: number, delta: number): void {
    const items: CartItem[] = CartService.getItems();
    for (let i = 0; i < items.length; i++) {
      if (items[i].productId === productId) {
        items[i].quantity = Math.max(1, Math.min(items[i].quantity + delta, 99));
        break;
      }
    }
    CartService.save(items);
  }

  static toggleSelected(productId: number): void {
    const items: CartItem[] = CartService.getItems();
    for (let i = 0; i < items.length; i++) {
      if (items[i].productId === productId) {
        items[i].selected = !items[i].selected;
        break;
      }
    }
    CartService.save(items);
  }

  static toggleAll(selected: boolean): void {
    const items: CartItem[] = CartService.getItems();
    for (let i = 0; i < items.length; i++) {
      items[i].selected = selected;
    }
    CartService.save(items);
  }

  static getLines(): CartLine[] {
    const lines: CartLine[] = [];
    const items: CartItem[] = CartService.getItems();
    for (let i = 0; i < items.length; i++) {
      const product: Product | undefined = ProductService.getById(items[i].productId);
      if (product !== undefined) {
        const line: CartLine = {
          product: product,
          quantity: items[i].quantity,
          selected: items[i].selected
        };
        lines.push(line);
      }
    }
    return lines;
  }

  static getSelectedLines(): CartLine[] {
    const result: CartLine[] = [];
    const lines: CartLine[] = CartService.getLines();
    for (let i = 0; i < lines.length; i++) {
      if (lines[i].selected) {
        result.push(lines[i]);
      }
    }
    return result;
  }

  static getSelectedCount(): number {
    let count: number = 0;
    const lines: CartLine[] = CartService.getSelectedLines();
    for (let i = 0; i < lines.length; i++) {
      count += lines[i].quantity;
    }
    return count;
  }

  static getSelectedTotal(): number {
    let total: number = 0;
    const lines: CartLine[] = CartService.getSelectedLines();
    for (let i = 0; i < lines.length; i++) {
      total += lines[i].product.price * lines[i].quantity;
    }
    return total;
  }

  static removeSelected(): void {
    const items: CartItem[] = CartService.getItems();
    const remain: CartItem[] = [];
    for (let i = 0; i < items.length; i++) {
      if (!items[i].selected) {
        remain.push(items[i]);
      }
    }
    CartService.save(remain);
  }

  static count(): number {
    let count: number = 0;
    const items: CartItem[] = CartService.getItems();
    for (let i = 0; i < items.length; i++) {
      count += items[i].quantity;
    }
    return count;
  }

  static clear(): void {
    CartService.save([]);
  }
}
