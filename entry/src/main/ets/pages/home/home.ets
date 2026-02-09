import { ImageKnifeComponent } from '@ohos/imageknife'
import { StyleConstants, CommodityList } from '@ohos/common'
import { DisplayUtil, LogUtil } from '@pura/harmony-utils'
import { window } from '@kit.ArkUI'
import { BannerInfo, GridDataSource, MenuInfo, SwiperDataSource } from './source'

@Component
export struct Home {
  @State arr: number[] = []
  @State currentIndex: number = 0
  private controller = new TabsController()

  @State searchHeaderHeight: number = 80 //min-40, max 80

  @State isRefreshing: boolean = false
  @State promptText: string = "下拉刷新"

  @State tabsCurrentIndex: number = 0
  @State showBackTop: boolean[] = [false, false, false, false]

  @StorageProp('safeTop') safeTop: number = 0
  @StorageProp('safeBottom') safeBottom: number = 0

  private scroller: Scroller = new Scroller()
  private windowClass = AppStorage.get<window.Window>('windowClass') as window.Window

  private waterFlowControllers: Scroller[] = [new Scroller(), new Scroller(), new Scroller(), new Scroller()]

  private swiperData = new SwiperDataSource([
    {
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
    }
  ])
  private nineMenuList = new GridDataSource([
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/supermarket.png?updatedAt=1691716657143",
      "menuName": "超市",
      "menuCode": "m01",
      "h5url": "https://prodev.m.jd.com/mall/active/3xhqjGH1wMz5FaMgrfYhR22sFvqz/index.html"
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/electrical.gif?updatedAt=1691717470888",
      "menuName": "电器",
      "menuCode": "m02",
      "h5url": "https://prodev.m.jd.com/mall/active/8tHNdJLcqwqhkLNA8hqwNRaNu5f/index.html"
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/international.gif?updatedAt=1691717471164",
      "menuName": "国际",
      "menuCode": "m11",
      "h5url": "https://gmart.jd.com"
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/clothing.png?updatedAt=1691717469469",
      "menuName": "服饰",
      "menuCode": "m03",
      "h5url": "https://h5.m.jd.com/pb/014076750/48qPXkwvatBBCAhdeTXG5WQam4yq/index.html"
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/fruit.png?updatedAt=1691717469547",
      "menuName": "免费水果",
      "menuCode": "m04",
      "h5url": ""
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/member.png?updatedAt=1691717473002",
      "menuName": "会员",
      "menuCode": "m10",
      "h5url": "https://shop.m.jd.com/shop/home?shopId=1000343263&utm_source=iosapp&utm_medium=appshare&utm_campaign=t_335139774&utm_term=Wxfriends&ad_od=share&utm_user=plusmember&gx=RnAomTM2bjTfycsT-YNzCTmOd9y9Fa0&gxd=RnAokmcIOjONmssR_YNyCIMKIb4Xa5DwoYs6Qbze_4h9aUHPDecui7HTjqAWskU"
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/fresh.png?updatedAt=1691717469544",
      "menuName": "生鲜",
      "menuCode": "m13",
      "h5url": "https://pro.m.jd.com/mall/active/4P9a2T9osR9JvtzHVaYTPvsecRtg/index.html"
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/second-hand.png?updatedAt=1691717473251",
      "menuName": "拍拍二手",
      "menuCode": "m17",
      "h5url": "https://prodev.m.jd.com/mall/active/LHGZv1DrGkva1jNpUkKFuNFN6oo/index.html"
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/xixi.png?updatedAt=1691717474366",
      "menuName": "喜喜",
      "menuCode": "m05",
      "h5url": ""
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/livingExpenses.png?updatedAt=1691717469316",
      "menuName": "生活缴费",
      "menuCode": "m06"
    }
  ])
  private nineMenuList2 = new GridDataSource([
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/collarBean.png?updatedAt=1691717469626",
      "menuName": "领豆",
      "menuCode": "m07"
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/collectingVouchers.png?updatedAt=1691717469456",
      "menuName": "领券",
      "menuCode": "m08"
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/LingjinBrick.png?updatedAt=1691717469616",
      "menuName": "领金贴",
      "menuCode": "m09"
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/woerma.png?updatedAt=1691717473335",
      "menuName": "沃尔玛",
      "menuCode": "m14"
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/travel.png?updatedAt=1691717473295",
      "menuName": "旅行",
      "menuCode": "m15"
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/seeAdoctor.png?updatedAt=1691717473273",
      "menuName": "看病购药",
      "menuCode": "m16"
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/BeanSprout.png?updatedAt=1691717469473",
      "menuName": "种豆得豆",
      "menuCode": "m18"
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/pets.png?updatedAt=1691717473123",
      "menuName": "萌宠",
      "menuCode": "m19"
    },
    {
      "menuIcon": "https://ik.imagekit.io/guoguodad/mall/home/more.png?updatedAt=1691717472932",
      "menuName": "更多频道",
      "menuCode": "m20"
    }
  ])

  goodsItemWidth = (DisplayUtil.getWidth() - 30) / 2

  aboutToAppear() {
    for (let i = 0; i < 30; i++) {
      this.arr.push(i)
    }
  }

  build() {
    Refresh({ refreshing: $$this.isRefreshing, builder: this.refreshComponent() }) {
      Stack() {
        this.FoldableHeader()
        Scroll(this.scroller) {
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
        .onDidScroll((xOffset: number, yOffset: number, scrollState: ScrollState) => {
          LogUtil.info(`xOffset:${xOffset},yOffset:${yOffset},scrollState: ${scrollState}`)
        })
        .width(StyleConstants.FULL_WIDTH)
        .height(StyleConstants.FULL_HEIGHT)

        this.BackTop()
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
    .onOffsetChange(offset => {
      if(offset > this.safeTop) {
        this.windowClass.setWindowSystemBarProperties({ statusBarContentColor: '#000000' })
      } else {
        this.windowClass.setWindowSystemBarProperties({ statusBarContentColor: '#FFFFFF' })
      }
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
    Stack() {
      Column() {
        LoadingProgress().height(32)
        Text(this.promptText).fontSize(StyleConstants.FONT_SIZE_TWELVE).margin({ top: 2 }).fontColor(Color.Grey)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .align(Alignment.Center)
    .clip(true)
    .padding({top: this.safeTop, bottom: 5})
    .constraintSize({ minHeight: 54 + this.safeTop })
    .width(StyleConstants.FULL_WIDTH)
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
    .backgroundColor('#EA3931')
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
                objectFit: ImageFit.Cover
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
        .indicator( // 设置圆点导航点样式
          new DotIndicator()
            .itemWidth(8)
            .itemHeight(8)
            .selectedItemWidth(8)
            .selectedItemHeight(8)
            .color($r('app.color.dot_color'))
            .selectedColor($r('app.color.dot_active_color'))
            .maxDisplayCount(9)
        )
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
        loadSrc: 'https://ik.imagekit.io/guoguodad/mall/home/ad_img.png?updatedAt=1691716521394',
        objectFit: ImageFit.Fill
      }
    }).width(StyleConstants.FULL_WIDTH).height(78).backgroundColor(Color.White)
  }

  @Builder
  MenuSlider() {
    Swiper() {
      Grid() {
        LazyForEach(this.nineMenuList, (item: MenuInfo) => {
          GridItem() {
            Column() {
              ImageKnifeComponent({
                imageKnifeOption: {
                  loadSrc: item.menuIcon,
                  objectFit: ImageFit.Fill
                }
              }).width(40).height(40)
              Text(item.menuName)
                .margin({top: 4})
                .fontSize(12)
                .fontColor('#4B4B4B')
            }
          }
        }, (item: MenuInfo) => item.menuCode)
      }
      .padding({bottom: 26})
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr')

      Grid() {
        LazyForEach(this.nineMenuList2, (item: MenuInfo) => {
          GridItem() {
            Column() {
              ImageKnifeComponent({
                imageKnifeOption: {
                  loadSrc: item.menuIcon,
                  objectFit: ImageFit.Fill
                }
              }).width(40).height(40)
              Text(item.menuName)
                .margin({top: 4})
                .fontSize(12)
                .fontColor('#4B4B4B')
            }
          }
        }, (item: MenuInfo) => item.menuCode)
      }
      .padding({bottom: 26})
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr')
    }
    .height(168)
    .width(StyleConstants.FULL_WIDTH)
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
  TabBarBuilder(title:string, targetIndex:number){
    Column(){
      Text(title)
        .fontSize(StyleConstants.FONT_SIZE_SIXTEEN)
        .fontColor(this.currentIndex == targetIndex ? $r('app.color.tab_active_color') : $r('app.color.tab_txt_color'))
    }
    .justifyContent(FlexAlign.Center)
    .width(StyleConstants.FULL_WIDTH)
    .height(50)
    .onClick(()=>{
      this.currentIndex = targetIndex
      this.controller.changeIndex(this.currentIndex)
    })
  }

  @Builder
  TabsContentList() {
    Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
      TabContent() {
        CommodityList({
          scrollController: this.waterFlowControllers[0],
          itemWidth: this.goodsItemWidth,
          onScrollIndexCall: (first => { this.showBackTop[0] = first > 2 })
        })
      }.tabBar(this.TabBarBuilder("精选", 0))

      TabContent() {
        CommodityList({
          scrollController: this.waterFlowControllers[1],
          itemWidth: this.goodsItemWidth,
          onScrollIndexCall: (first => { this.showBackTop[1] = first > 2 })
        })
      }.tabBar(this.TabBarBuilder("新品", 1))

      TabContent() {
        CommodityList({
          scrollController: this.waterFlowControllers[2],
          itemWidth: this.goodsItemWidth,
          onScrollIndexCall: (first => { this.showBackTop[2] = first > 2 })
        })
      }.tabBar(this.TabBarBuilder("实惠", 2))

      TabContent() {
        CommodityList({
          scrollController: this.waterFlowControllers[3],
          itemWidth: this.goodsItemWidth,
          onScrollIndexCall: (first => { this.showBackTop[3] = first > 2 })
        })
      }.tabBar(this.TabBarBuilder("进口", 3))
    }
    .barHeight(50)
    .vertical(false)
    .height(StyleConstants.FULL_HEIGHT)
    .onChange(index => {
      // LogUtil.info(`onChange index:${index}`)
      this.tabsCurrentIndex = index
    })
  }


  @Builder
  BackTop() {
    Button() {
      Image($r('app.media.ic_back_top'))
        .width(24)
        .height(24)
    }
    .width(50)
    .height(50)
    .borderRadius(25)
    .backgroundColor(Color.White)
    .shadow({ radius: 8, color: Color.Gray, offsetX: 2, offsetY: 2 })
    .position({ x: '85%', y: '90%' })
    .visibility(this.showBackTop[this.tabsCurrentIndex] ? Visibility.Visible : Visibility.None)
    .onClick(()=> {
      this.waterFlowControllers.forEach((_, index) => {
        this.waterFlowControllers[index].scrollTo({xOffset: 0, yOffset: 0, animation: { duration: 200, curve: Curve.Friction }})
      })
      this.scroller.scrollTo({xOffset: 0, yOffset: 0, animation: { duration: 400, curve: Curve.Friction }})
    })
  }

  @Styles
  listCard() {
    .backgroundColor(Color.White)
    .height(72)
    .width("100%")
    .margin({top: 5, bottom: 5})
    .borderRadius(12)
  }
}

