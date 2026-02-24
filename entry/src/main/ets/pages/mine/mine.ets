import { CommodityList, DataSource, FloatingBackTop, StyleConstants } from '@ohos/common'
import { ImageKnifeComponent } from '@ohos/imageknife'
import { DisplayUtil, LogUtil } from '@pura/harmony-utils'
import { FunctionInfo, queryMinePageInfo, TabInfo } from '../../service/mineService'

@Component
export struct Mine {
  @StorageProp('safeTop') safeTop: number = 0

  @State showFixedHeader: boolean = false
  @State fixedHeaderOpacity: number = 0
  @State showBackTop: boolean[] = []
  @State tabsCurrentIndex: number = 0
  @State tabList: TabInfo[] = []

  private fixedHeaderHeight: number = 40 + this.safeTop

  private nineMenuList = new DataSource<FunctionInfo>([])
  private nineMenuList2 = new DataSource<FunctionInfo>([])

  private scrollScroller: Scroller = new Scroller()
  private tabsController = new TabsController()
  private waterFlowScrollerList: Scroller[] = [new Scroller(),new Scroller(),new Scroller(),new Scroller(),new Scroller(),new Scroller(),new Scroller(),new Scroller()]

  goodsItemWidth = (DisplayUtil.getWidth() - 30) / 2

  aboutToAppear() {
    this.queryMineInfo()
  }

  build() {
    Stack() {
      this.FixedHeader()
      Scroll(this.scrollScroller) {
        Column() {
          this.MineHeader()
          this.OrderInfo()
          this.MenuSlider()
          this.TabsContentList()
        }
        .width(StyleConstants.FULL_WIDTH)
        .justifyContent(FlexAlign.Start)
      }
      .edgeEffect(EdgeEffect.Spring)
      .friction(0.6)
      .backgroundColor('#FAFAFA')
      .scrollBar(BarState.Off)
      .padding({ bottom: this.fixedHeaderHeight })
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
      .onDidScroll(() => {
        let currentOffset = this.scrollScroller.currentOffset().yOffset
        if(currentOffset > 5) {
          this.showFixedHeader = true
          let tempOpacity = currentOffset * 0.04
          if(tempOpacity > 1) tempOpacity = 1
          this.fixedHeaderOpacity = tempOpacity
        } else {
          this.showFixedHeader = false
          this.fixedHeaderOpacity = 0
        }
      })

      this.BackTop()
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
  }

  @Builder
  MineHeader() {
    Column() {
      Row() {
        Image($r('app.media.ic_friend'))
          .width(23)
          .height(23)
          .margin({right: 12})
        Image($r('app.media.ic_setting'))
          .width(26)
          .height(26)
          .margin({right: 12})
        Image($r('app.media.ic_message'))
          .width(26)
          .height(26)
          .margin({right: 12})
      }
      .height(40)
      .width(StyleConstants.FULL_WIDTH)
      .justifyContent(FlexAlign.End)
      .alignItems(VerticalAlign.Center)

      Row() {
        Image($r('app.media.header'))
          .width(70)
          .height(70)
          .margin({left: 12, right: 12})
          .border({radius: 35})

        Column() {
          Text('GuoguoDad')
            .fontSize(StyleConstants.FONT_SIZE_EIGHTEEN)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          Text('积分：200   信用值：1200')
            .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
            .fontColor(Color.Black)
            .margin({top: 6})
        }
        .width('calc(100% - 94vp)')
        .height(StyleConstants.FULL_HEIGHT)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
      }
      .height(80)
      .width(StyleConstants.FULL_WIDTH)
      .alignItems(VerticalAlign.Center)
    }
    .width(StyleConstants.FULL_WIDTH)
    .backgroundImage($r('app.media.mine_top_bg'))
    .backgroundImageSize(ImageSize.Cover)
    .height(120 + this.safeTop)
    .padding({top: this.safeTop})
  }

  @Builder
  FixedHeader() {
    Column() {
      Row() {
        Image($r('app.media.header'))
          .width(36)
          .height(36)
          .margin({left: 12, right: 12})
          .border({radius: 35})

        Row() {
          Image($r('app.media.ic_friend'))
            .width(23)
            .height(23)
            .margin({right: 12})
          Image($r('app.media.ic_setting'))
            .width(26)
            .height(26)
            .margin({right: 12})
          Image($r('app.media.ic_message'))
            .width(26)
            .height(26)
            .margin({right: 12})
        }
        .height(StyleConstants.FULL_HEIGHT)
        .alignItems(VerticalAlign.Center)
      }
      .height(StyleConstants.FULL_HEIGHT)
      .width(StyleConstants.FULL_WIDTH)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width(StyleConstants.FULL_WIDTH)
    .backgroundColor(Color.White)
    .visibility(this.showFixedHeader ? Visibility.Visible : Visibility.None)
    .opacity(this.fixedHeaderOpacity)
    .height(this.fixedHeaderHeight)
    .padding({top: this.safeTop})
    .position({x: 0, y: 0})
    .zIndex(2)
  }

  @Builder
  OrderInfo() {
    Column() {
      Row() {
        Row() {
          Image($r('app.media.ic_goods_star'))
            .width(18)
            .height(18)
          Text('商品收藏0')
            .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
            .margin({left: 4})
        }
        .width('calc(100% / 3)')
        .height(StyleConstants.FULL_WIDTH)
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Start)

        Row() {
          Image($r('app.media.ic_store_focus'))
            .width(18)
            .height(18)
          Text('店铺关注16')
            .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
            .margin({left: 4})
        }
        .width('calc(100% / 3)')
        .height(StyleConstants.FULL_WIDTH)
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)

        Row() {
          Image($r('app.media.ic_look_history'))
            .width(18)
            .height(18)
          Text('浏览记录20')
            .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
            .margin({left: 4})
        }
        .width('calc(100% / 3)')
        .height(StyleConstants.FULL_WIDTH)
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.End)
      }
      .height(42)
      .border({width: { bottom: 1}, style: {bottom: BorderStyle.Solid}, color: '#F2F2F2'})
      .width(StyleConstants.FULL_WIDTH)

      Row() {
        Column() {
          Image($r('app.media.ic_todo_pay'))
            .width(42)
            .height(42)
          Text('待付款')
            .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
            .margin({top: 2})
        }
        .width('calc(100% / 4)')
        .padding({bottom: 20})
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .height(StyleConstants.FULL_HEIGHT)

        Column() {
          Image($r('app.media.ic_todo_get'))
            .width(42)
            .height(42)
          Text('待收货')
            .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
            .margin({top: 2})
        }
        .width('calc(100% / 4)')
        .padding({bottom: 20})
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .height(StyleConstants.FULL_HEIGHT)

        Column() {
          Image($r('app.media.ic_todo_evaluate'))
            .width(42)
            .height(42)
          Text('待评价')
            .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
            .margin({top: 2})
        }
        .width('calc(100% / 4)')
        .padding({bottom: 20})
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .height(StyleConstants.FULL_HEIGHT)

        Column() {
          Image($r('app.media.ic_todo_exchange'))
            .width(42)
            .height(42)
          Text('退货/售后')
            .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
            .margin({top: 2})
        }
        .width('calc(100% / 4)')
        .padding({bottom: 20})
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .height(StyleConstants.FULL_HEIGHT)
      }
      .height(90)
      .width(StyleConstants.FULL_WIDTH)
    }
    .height(132)
    .width('calc(100% - 20vp)')
    .backgroundColor(Color.White)
    .border({radius: 10})
    .padding(12)
    .margin({left: 10, right: 10, top: 10})
  }

  @Builder
  MenuSlider() {
    Swiper() {
      Grid() {
        LazyForEach(this.nineMenuList, (item: FunctionInfo) => {
          GridItem() {
            Column() {
              ImageKnifeComponent({
                imageKnifeOption: {
                  loadSrc: item.menuIcon,
                  placeholderSrc: $r('app.media.default'),
                  errorholderSrc: $r('app.media.default'),
                  objectFit: ImageFit.Fill
                }
              }).width(40).height(40)
              Text(item.menuName)
                .margin({top: 4})
                .fontSize(12)
                .fontColor('#4B4B4B')
            }
          }
        }, (item: FunctionInfo) => item.menuCode)
      }
      .padding({bottom: 26})
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr')

      Grid() {
        LazyForEach(this.nineMenuList2, (item: FunctionInfo) => {
          GridItem() {
            Column() {
              ImageKnifeComponent({
                imageKnifeOption: {
                  loadSrc: item.menuIcon,
                  placeholderSrc: $r('app.media.default'),
                  errorholderSrc: $r('app.media.default'),
                  objectFit: ImageFit.Fill
                }
              }).width(40).height(40)
              Text(item.menuName)
                .margin({top: 4})
                .fontSize(12)
                .fontColor('#4B4B4B')
            }
          }
        }, (item: FunctionInfo) => item.menuCode)
      }
      .padding({bottom: 26})
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr')
    }
    .height(90)
    .width('calc(100% - 20vp)')
    .margin({left: 10, right: 10, top: 10})
    .border({radius: 10})
    .padding({top: 6})
    .index(0)
    .autoPlay(false)
    .loop(false)
    .backgroundColor(Color.White)
    .itemSpace(0)
    .indicator( // 设置圆点导航点样式
      new DotIndicator()
        .itemWidth(6)
        .itemHeight(6)
        .selectedItemWidth(6)
        .selectedItemHeight(6)
        .color($r('app.color.dot_color'))
        .selectedColor($r('app.color.dot_active_color'))
    )
    .curve(Curve.Linear)
  }

  @Builder
  TabBarBuilder(title:string, index:number){
    Column(){
      Text(title)
        .fontSize(StyleConstants.FONT_SIZE_SIXTEEN)
        .fontColor(this.tabsCurrentIndex == index ? $r('app.color.tab_active_color') : $r('app.color.tab_txt_color'))
    }
    .justifyContent(FlexAlign.Center)
    .width(100)
    .height(50)
    .onClick(()=>{
      this.tabsCurrentIndex = index
      this.tabsController.changeIndex(this.tabsCurrentIndex)
    })
  }

  @Builder
  TabsContentList() {
    Tabs({ barPosition: BarPosition.Start, controller: this.tabsController }) {
      ForEach(this.tabList, (item: TabInfo, index: number) => {
        TabContent() {
          CommodityList({
            categoryCode: item.code,
            scrollController: this.waterFlowScrollerList[index],
            itemWidth: this.goodsItemWidth,
            onScrollIndexCall: (first => { this.showBackTop[index] = first > 2 })
          })
        }.tabBar(this.TabBarBuilder(item.name, index))
      })
    }
    .barHeight(50)
    .vertical(false)
    .scrollable(false)
    .barMode(BarMode.Scrollable)
    .height(StyleConstants.FULL_HEIGHT)
    .margin({top: -(this.fixedHeaderHeight) })
    .offset({top: this.fixedHeaderHeight })
  }

  @Builder
  BackTop() {
    FloatingBackTop({
      location: ({ x: '85%', y: '90%' }),
      display: (this.showBackTop[this.tabsCurrentIndex] ? Visibility.Visible : Visibility.None),
      onClickFun: (() => {
        this.waterFlowScrollerList.forEach(scroller => {
          scroller.scrollTo({xOffset: 0, yOffset: 0, animation: { duration: 200, curve: Curve.Friction }})
        })
        this.scrollScroller.scrollTo({xOffset: 0, yOffset: 0, animation: { duration: 400, curve: Curve.Friction }})
      })
    })
  }

  queryMineInfo() {
    queryMinePageInfo().then(res => {
      this.nineMenuList.setData(res.functionList?.filter((_, index)=> index < 5))
      this.nineMenuList2.setData(res.functionList?.filter((_, index)=> index >= 5 && index < 10))
      this.tabList = res.tabList || []
    })
  }
}



