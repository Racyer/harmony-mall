import { CartLine } from '../model/CartItem';
import { Order, OrderItem } from '../model/Order';
import { AppConstants } from '../common/constants/AppConstants';

/**
 * 订单服务：下单时生成商品快照，随后清空购物车中已选条目。
 */
export class OrderService {
  static getOrders(): Order[] {
    const raw: string = AppStorage.get<string>(AppConstants.ORDERS_KEY) ?? '[]';
    try {
      return JSON.parse(raw) as Order[];
    } catch (error) {
      return [];
    }
  }

  static create(lines: CartLine[], address: string): Order {
    const items: OrderItem[] = [];
    let total: number = 0;
    for (let i = 0; i < lines.length; i++) {
      const item: OrderItem = {
        productId: lines[i].product.id,
        name: lines[i].product.name,
        price: lines[i].product.price,
        quantity: lines[i].quantity
      };
      items.push(item);
      total += lines[i].product.price * lines[i].quantity;
    }
    const order: Order = {
      id: `HM${Date.now()}`,
      items: items,
      total: total,
      status: '待发货',
      createdAt: new Date().toLocaleString(),
      address: address
    };
    const orders: Order[] = OrderService.getOrders();
    orders.unshift(order);
    AppStorage.setOrCreate<string>(AppConstants.ORDERS_KEY, JSON.stringify(orders));
    return order;
  }
}
