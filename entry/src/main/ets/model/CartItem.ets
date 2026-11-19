import { Product } from './Product';

/** 购物车持久化条目，只存商品 id，避免把 Resource 写进 JSON。 */
export interface CartItem {
  productId: number;
  quantity: number;
  selected: boolean;
}

/** 购物车视图行，商品信息由 ProductService 实时补齐。 */
export interface CartLine {
  product: Product;
  quantity: number;
  selected: boolean;
}
