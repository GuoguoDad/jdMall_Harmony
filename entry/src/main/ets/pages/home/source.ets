
export interface BannerInfo {
  imgUrl: string, type: string
}

export class SwiperDataSource implements IDataSource {
  private list: BannerInfo[] = [];

  constructor(list: BannerInfo[]) {
    this.list = list;
  }

  totalCount(): number {
    return this.list.length;
  }

  getData(index: number): BannerInfo {
    return this.list[index];
  }

  registerDataChangeListener(listener: DataChangeListener): void {
  }

  unregisterDataChangeListener() {
  }
}


export interface MenuInfo {
  menuIcon: string
  menuName: string
  menuCode: string
  h5url?: string
}


export class GridDataSource implements IDataSource {
  private list: MenuInfo[] = [];
  private listeners: DataChangeListener[] = [];

  constructor(list: MenuInfo[]) {
    this.list = list;
  }

  totalCount(): number {
    return this.list.length;
  }

  getData(index: number): MenuInfo {
    return this.list[index];
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  // 通知控制器数据位置变化
  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
    })
  }

  // 交换元素位置
  public swapItem(from: number, to: number): void {
    let temp: MenuInfo = this.list[from];
    this.list[from] = this.list[to];
    this.list[to] = temp;
    this.notifyDataMove(from, to);
  }
}