export class DataSource<T> implements IDataSource {
  private dataArray: T[] = []
  private listeners: DataChangeListener[] = []

  constructor(list: T[]) {
    this.dataArray = list
  }

  // 获取索引对应的数据
  public getData(index: number): T {
    return this.dataArray[index]
  }

  // 通知控制器数据重新加载
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded()
    })
  }

  // 通知控制器数据增加
  notifyDataAdd(index: number) {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index)
    })
  }

  // 通知控制器数据变化
  notifyDataChange(index: number) {
    this.listeners.forEach(listener => {
      listener.onDataChange(index)
    })
  }

  // 通知控制器数据删除
  notifyDataDelete(index: number) {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index)
    })
  }

  // 通知控制器数据位置变化
  notifyDataMove(from: number, to: number) {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to)
    })
  }

  // 通知控制器数据批量修改
  notifyDatasetChange(operations: DataOperation[]) {
    this.listeners.forEach(listener => {
      listener.onDatasetChange(operations)
    })
  }

  // 获取数据总数
  public totalCount(): number {
    return this.dataArray.length
  }

  // 注册改变数据的控制器
  registerDataChangeListener(listener: DataChangeListener) {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener)
    }
  }

  // 注销改变数据的控制器
  unregisterDataChangeListener(listener: DataChangeListener) {
    const pos = this.listeners.indexOf(listener)
    if (pos >= 0) {
      this.listeners.splice(pos, 1)
    }
  }

  public setData(list: T[]) {
    this.dataArray = list
    this.notifyDataReload()
  }


  public addNewItems(items: T[]) {
    this.dataArray.push(...items)

    const lastIndex = this.dataArray.length
    items.forEach((_, index) => {
      const newIndex = lastIndex + index
      this.notifyDataAdd(newIndex)
    })
  }
}