/**
 * 商品与分类模型。字段变更需同步 ProductService、MockData 和详情页。
 */
export interface Category {
  id: number;
  name: string;
  icon: string;
  desc: string;
}

export interface Product {
  id: number;
  name: string;
  subtitle: string;
  price: number;
  originalPrice: number;
  image: ResourceStr;
  categoryId: number;
  tags: string[];
  sales: number;
  rating: number;
  description: string;
}

/** 商品详情页路由参数 */
export class ProductParams {
  id: number = 0;

  constructor(id: number) {
    this.id = id;
  }
}

/** 搜索页路由参数 */
export class SearchParams {
  keyword: string = '';

  constructor(keyword: string) {
    this.keyword = keyword;
  }
}
