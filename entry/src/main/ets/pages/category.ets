@Component
export struct Category {
  @State isRefreshing: boolean = false
  @State promptText: string = "下拉刷新"
  @State arr: String[] = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10']

  @StorageProp('safeTop') safeTop: number = 0
  @StorageProp('safeBottom') safeBottom: number = 0

  build() {
    Column() {
      Refresh({ refreshing: $$this.isRefreshing, promptText: this.promptText }) {
        List() {
          ForEach(this.arr, (item: string) => {
            ListItem() {
              Text('' + item)
                .width('70%')
                .height(80)
                .fontSize(16)
                .margin(10)
                .textAlign(TextAlign.Center)
                .borderRadius(10)
                .backgroundColor(0xFFFFFF)
            }
          }, (item: string) => item)
        }
        .onScrollIndex((first: number) => {
          console.info(first.toString())
        })
        .width('100%')
        .height('100%')
        .alignListItem(ListItemAlign.Center)
        .scrollBar(BarState.Off)
      }
      .backgroundColor(0x89CFF0)
      .pullToRefresh(true)
      .refreshOffset(96)
      .onStateChange((refreshStatus: RefreshStatus) => {
        switch (refreshStatus) {
          case RefreshStatus.Inactive:
            this.promptText = '下拉刷新'
            break
          case RefreshStatus.Drag:
            this.promptText = '下拉刷新'
            break
          case RefreshStatus.OverDrag:
            this.promptText = '松开立即刷新...'
            break
          case RefreshStatus.Refresh:
            this.promptText = '正在刷新'
            break
          case RefreshStatus.Done:
            this.promptText = '刷新成功'
            break
        }
      })
      .offset({top: this.safeTop})
      .onOffsetChange((value: number) => {
        console.info('Refresh onOffsetChange offset:' + value)
      })
      .onRefreshing(() => {
        setTimeout(() => {
          this.promptText = '刷新成功'
          this.isRefreshing = false
        }, 2000)
        console.log('onRefreshing test')
      })
    }
    .width('100%')
    .height('100%')
  }
}