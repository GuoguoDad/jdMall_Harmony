@Component
export struct Home {
  @State arr: number[] = []

  @State isRefreshing: boolean = false
  @State promptText: string = "下拉刷新"

  @StorageProp('safeTop') safeTop: number = 0
  @StorageProp('safeBottom') safeBottom: number = 0

  @Styles
  listCard() {
    .backgroundColor(Color.White)
    .height(72)
    .width("100%")
    .margin({top: 5, bottom: 5})
    .borderRadius(12)
  }

  aboutToAppear() {
    for (let i = 0; i < 30; i++) {
      this.arr.push(i)
    }
  }

  @Builder
  refreshComponent() {
    Stack() {
      Column() {
        LoadingProgress().height(32)
        Text(this.promptText).fontSize(16).margin({ top: 5 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .align(Alignment.Center)
    .clip(true)
    .padding({top: this.safeTop})
    .constraintSize({ minHeight: 42 + this.safeTop })
    .width("100%")
  }

  build() {
    Refresh({ refreshing: $$this.isRefreshing, builder: this.refreshComponent() }) {
      Scroll() {
        Column() {
          Text("Scroll Area")
            .width("100%")
            .height("40%")
            .backgroundColor(Color.White)
            .textAlign(TextAlign.Center)
          Tabs({ barPosition: BarPosition.Start }) {
            TabContent() {
              List() {
                ForEach(this.arr, (item: number) => {
                  ListItem() {
                    Text("item" + item)
                      .fontSize(16)
                  }.listCard()
                }, (item: string) => item)
              }.width("100%")
              .edgeEffect(EdgeEffect.Spring)
              .nestedScroll({
                scrollForward: NestedScrollMode.PARENT_FIRST,
                scrollBackward: NestedScrollMode.SELF_FIRST
              })
            }.tabBar("Tab1")

            TabContent() {
            }.tabBar("Tab2")
          }
          .backgroundColor('#F5F5F5')
          .vertical(false)
          .height("100%")
        }.width("100%")
      }
      .edgeEffect(EdgeEffect.Spring)
      .friction(0.6)
      .padding({top: this.safeTop})
      .backgroundColor(Color.White)
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .pullToRefresh(true)
    .refreshOffset(96)
    .onStateChange((refreshStatus: RefreshStatus) => {
      switch (refreshStatus) {
        case RefreshStatus.Drag:
          this.promptText = '下拉刷新'
          break
        case RefreshStatus.OverDrag:
          this.promptText = '松开立即刷新...'
          break
        case RefreshStatus.Refresh:
          this.promptText = '正在刷新'
          break
      }
    })
    .onRefreshing(() => {
      setTimeout(() => {
        this.promptText = '刷新成功'
        this.isRefreshing = false
      }, 2000)
    })

  }
}