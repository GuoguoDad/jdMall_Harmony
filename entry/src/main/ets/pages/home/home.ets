import { ImageKnifeComponent } from '@ohos/imageknife'
import {
  RefreshComponent,
  getRefreshStatusText,
  StyleConstants,
  CommodityList,
  FloatingBackTop,
  DataSource,
  CommonDotIndicator
} from '@ohos/common'
import { DisplayUtil, LogUtil, WindowUtil } from '@pura/harmony-utils'
import { queryHomePageInfo, TabInfo, BannerInfo, NineMenuInfo } from '../../service/homeService'

@Component
export struct Home {
  @State searchHeaderHeight: number = 80 //min-40, max 80
  @State isRefreshing: boolean = false
  @State promptText: string = "下拉刷新"

  @State adUrl: string = ''
  @State tabsCurrentIndex: number = 0
  @State tabList: TabInfo[] = []
  @State showBackTop: boolean[] = []

  @StorageProp('safeTop') safeTop: number = 0
  @StorageProp('safeBottom') safeBottom: number = 0

  private tabsController: TabsController = new TabsController()
  private scrollScroller: Scroller = new Scroller()

  private waterFlowScrollerList: Scroller[] = [new Scroller(),new Scroller(),new Scroller(),new Scroller(),new Scroller()]

  private swiperData = new DataSource<BannerInfo>([])
  private nineMenuList = new DataSource<NineMenuInfo>([])
  private nineMenuList2 = new DataSource<NineMenuInfo>([])

  goodsItemWidth = (DisplayUtil.getWidth() - 30) / 2

  aboutToAppear() {
    this.queryInfo()
  }


  build() {
    Refresh({ refreshing: $$this.isRefreshing, builder: this.refreshComponent() }) {
      Stack() {
        this.FoldableHeader()
        Scroll(this.scrollScroller) {
          Column() {
            this.SwiperComponent()
            this.AdvComponent()
            this.MenuSlider()
            this.TabsContentList()
          }
          .width(StyleConstants.FULL_WIDTH)
          .padding({top: this.searchHeaderHeight + this.safeTop})
        }
        .edgeEffect(EdgeEffect.Spring)
        .friction(0.6)
        .scrollBar(BarState.Off)
        .backgroundColor('#F6F0F7')
        .width(StyleConstants.FULL_WIDTH)
        .height(StyleConstants.FULL_HEIGHT)

        this.BackTop()
      }
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
    }
    .pullToRefresh(true)
    .refreshOffset(96)
    .onStateChange((refreshStatus: RefreshStatus) => {this.promptText = getRefreshStatusText(refreshStatus)})
    .onOffsetChange(offset => {
      WindowUtil.setWindowSystemBarProperties({statusBarContentColor: offset > this.safeTop ? '#000000':'#FFFFFF'})
    })
    .onRefreshing(() => {
      setTimeout(() => {
        this.promptText = '刷新成功'
        this.isRefreshing = false
      }, 2000)
    })
  }

  @Builder
  refreshComponent() {
    RefreshComponent({promptText: this.promptText, progressOffsetTop: this.safeTop})
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
            .fontSize(StyleConstants.FONT_SIZE_SIXTEEN)
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
    .width(StyleConstants.FULL_WIDTH)
    .height(this.searchHeaderHeight + this.safeTop)
    .backgroundColor($r('app.color.common_header_bg'))
    .position({x: 0, y: 0})
    .zIndex(1)
  }

  @Builder
  SwiperComponent() {
    Column() {
      Column() {
        Swiper() {
          LazyForEach(this.swiperData, (item: BannerInfo) => {
            ImageKnifeComponent({
              imageKnifeOption: {
                loadSrc: item.imgUrl,
                placeholderSrc: $r('app.media.default'),
                errorholderSrc: $r('app.media.default'),
                objectFit: ImageFit.Fill
              }
            }).width(StyleConstants.FULL_WIDTH).height(150)
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
        .indicator(CommonDotIndicator(8,8,8,8))
        .curve(Curve.Linear)
      }
      .width(StyleConstants.FULL_WIDTH)
      .padding({left:12, top: 14, right: 12, bottom: 2})
      .backgroundColor(Color.White)
      .borderRadius({topLeft: 8, topRight: 8})
    }
    .width(StyleConstants.FULL_WIDTH)
    .backgroundColor('#EA3931')
  }

  @Builder
  AdvComponent() {
    ImageKnifeComponent({
      imageKnifeOption: {
        loadSrc: this.adUrl,
        placeholderSrc: $r('app.media.default'),
        errorholderSrc: $r('app.media.default'),
        objectFit: ImageFit.Fill
      }
    })
      .height(78)
      .width(StyleConstants.FULL_WIDTH)
      .backgroundColor(Color.White)
  }


  @Builder
  MenuSliderGrid(list: DataSource<NineMenuInfo>) {
    Grid() {
      LazyForEach(list, (item: NineMenuInfo) => {
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
      }, (item: NineMenuInfo) => item.menuCode)
    }
    .padding({bottom: 26})
    .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr')
  }

  @Builder
  MenuSlider() {
    Swiper() {
      this.MenuSliderGrid(this.nineMenuList)
      this.MenuSliderGrid(this.nineMenuList2)
    }
    .height(168)
    .width(StyleConstants.FULL_WIDTH)
    .index(0)
    .autoPlay(false)
    .loop(false)
    .backgroundColor(Color.White)
    .itemSpace(0)
    .indicator(CommonDotIndicator())
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
    .width(StyleConstants.FULL_WIDTH)
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
    .scrollable(false)
    .vertical(false)
    .height(StyleConstants.FULL_HEIGHT)
  }

  @Builder
  BackTop() {
    FloatingBackTop({
      location: ({ x: '85%', y: '90%' }),
      display: (this.showBackTop[this.tabsCurrentIndex] ? Visibility.Visible : Visibility.None),
      onClickFun: (() => {
        // LogUtil.info([
        //   'waterFlowScrollerList',
        //   this.waterFlowScrollerList
        // ])
        this.waterFlowScrollerList.forEach(scroller => {
          scroller.scrollTo({xOffset: 0, yOffset: 0, animation: { duration: 200, curve: Curve.Friction }})
        })
        this.scrollScroller.scrollTo({xOffset: 0, yOffset: 0, animation: { duration: 400, curve: Curve.Friction }})
      })
    })
  }

  queryInfo() {
    queryHomePageInfo().then(info => {
      this.adUrl = info.adUrl
      this.swiperData.setData(info.bannerList || [])
      this.nineMenuList.setData(info.nineMenuList?.filter((_, index)=> index < 10))
      this.nineMenuList2.setData(info.nineMenuList?.filter((_, index)=> index >= 10))

      const tabLen = (info.tabList || []).length
      this.showBackTop = new Array(tabLen).fill(false)
      // this.waterFlowScrollerList = new Array(tabLen).fill(new Scroller())
      this.tabList = info.tabList || []
    })
  }
}

