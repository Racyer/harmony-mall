import { Product } from '../model/Product';

/**
 * LazyForEach 数据源：支持首屏重置与上拉追加。
 */
export class ProductDataSource implements IDataSource {
  private data: Product[] = [];
  private listeners: DataChangeListener[] = [];

  totalCount(): number {
    return this.data.length;
  }

  getData(index: number): Product {
    return this.data[index];
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const position: number = this.listeners.indexOf(listener);
    if (position >= 0) {
      this.listeners.splice(position, 1);
    }
  }

  reset(items: Product[]): void {
    this.data = items;
    for (let i = 0; i < this.listeners.length; i++) {
      this.listeners[i].onDataReloaded();
    }
  }

  pushData(items: Product[]): void {
    const start: number = this.data.length;
    for (let i = 0; i < items.length; i++) {
      this.data.push(items[i]);
    }
    for (let i = 0; i < this.listeners.length; i++) {
      for (let j = 0; j < items.length; j++) {
        this.listeners[i].onDataAdd(start + j);
      }
    }
  }
}
