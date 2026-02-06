import { ImageKnifeComponent } from '@ohos/imageknife'

@Component
export struct Home {
  @State arr: number[] = []

  @State searchHeaderHeight: number = 80 //min-40, max 80

  @State isRefreshing: boolean = false
  @State promptText: string = "下拉刷新"

  @StorageProp('safeTop') safeTop: number = 0
  @StorageProp('safeBottom') safeBottom: number = 0

  private swiperController: SwiperController = new SwiperController()
  private swiperData = new SwiperDataSource([{
    "imgUrl": "https://ik.imagekit.io/guoguodad/mall/home/home_banner1.jpg?updatedAt=1691716405974",
    "type": "1"
    },
    {
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/home/home_banner3.jpg?updatedAt=1691716405821",
      "type": "2"
    },
    {
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/home/home_banner2.jpg?updatedAt=1691716405632",
      "type": "3"
    }])

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
    .constraintSize({ minHeight: 54 + this.safeTop })
    .width("100%")
  }

  @Builder
  FoldableHeader() {
    Stack() {
      Row() {
        Image($r('app.media.ic_pet'))
          .width(32).height(32)
          .margin({left: 16})
        Blank()
        Image($r('app.media.ic_scan'))
          .width(28).height(28)
          .margin({right: 16})
      }
      .width('100%')
      .position({x: 0, y: this.safeTop})
      Row() {
        Row() {
          Image($r('app.media.ic_search'))
            .width(20).height(20)
            .margin({left: 8})
          Text('跑步鞋')
            .margin({
              left: 6,
              right: 6
            })
            .fontSize(16)
            .fontColor('#8F9093')
            .textAlign(TextAlign.Center)
          Blank()
          Image($r('app.media.ic_camera'))
            .width(20).height(20)
            .margin({right: 8})
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .height(32)
        .backgroundColor(Color.White)
        .borderRadius(12)
      }
      .padding({left: 16, right: 16})
      .position({x: 0, y: 40 + this.safeTop})
    }
    .width('100%')
    .height(this.searchHeaderHeight + this.safeTop)
    .backgroundColor('#EA3931')
    .position({x: 0, y: 0})
    .zIndex(1)
  }

  @Builder
  SwiperComponent() {
    Column() {
      Column() {
        Swiper(this.swiperController) {
          LazyForEach(this.swiperData, (item: BannerInfo) => {
            ImageKnifeComponent({
              imageKnifeOption: {
                loadSrc: item.imgUrl,
                objectFit: ImageFit.Cover
              }
            }).width('100%').height(150)
          }, (item: string) => item)
        }
        .borderRadius(6)
        .cachedCount(2)
        .index(0)
        .autoPlay(true)
        .interval(6000)
        .loop(true)
        .duration(500)
        .itemSpace(0)
        .indicator( // 设置圆点导航点样式
          new DotIndicator()
            .itemWidth(8)
            .itemHeight(8)
            .selectedItemWidth(14)
            .selectedItemHeight(8)
            .color(Color.Gray)
            .selectedColor('#EA3931')
            .maxDisplayCount(9)
        )
        .curve(Curve.Linear)
      }
      .width('100%')
      .padding({left:12, top: 14, right: 12, bottom: 2})
      .backgroundColor(Color.White)
      .borderRadius({topLeft: 8, topRight: 8})
    }
    .width('100%')
    .backgroundColor('#EA3931')
  }

  @Builder
  AdvComponent() {
    ImageKnifeComponent({
      imageKnifeOption: {
        loadSrc: 'https://ik.imagekit.io/guoguodad/mall/home/ad_img.png?updatedAt=1691716521394',
        objectFit: ImageFit.Fill
      }
    }).width('100%').height(78)
  }

  @Builder
  TabsContentList() {
    Tabs({ barPosition: BarPosition.Start }) {
      TabContent() {
        List() {
          ForEach(this.arr, (item: number) => {
            ListItem() {
              Text("item" + item)
                .fontSize(16)
            }.listCard()
          }, (item: string) => item)
        }
        .width("100%")
        .scrollBar(BarState.Off)
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
  }

  build() {
    Refresh({ refreshing: $$this.isRefreshing, builder: this.refreshComponent() }) {
      Stack() {
        this.FoldableHeader()
        Scroll() {
          Column() {
            this.SwiperComponent()
            this.AdvComponent()
            this.TabsContentList()
          }
          .width("100%")
          .padding({top: this.searchHeaderHeight + this.safeTop})
        }
        .edgeEffect(EdgeEffect.Spring)
        .friction(0.6)
        .scrollBar(BarState.Off)
        .width('100%')
        .height('100%')
      }
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


interface BannerInfo {
  imgUrl: string, type: string
}

class SwiperDataSource implements IDataSource {
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