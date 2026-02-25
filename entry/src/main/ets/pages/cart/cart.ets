import { CommodityList, FloatingBackTop, StepperComponent, StyleConstants } from "@ohos/common"
import { ImageKnifeComponent } from '@ohos/imageknife'
import { AppUtil, DisplayUtil, WindowUtil } from "@pura/harmony-utils"
import { GoodsInfo, queryCartGoodsList, StoreGoodsInfo } from '../../service/cartService'

@Component
export struct Cart {
  @State totalInfoHeight: number = 0 //58,0
  @State showBackTop: boolean = false
  @State cartStoreGoodsList: StoreGoodsInfo[] = []

  private scrollScroller: Scroller = new Scroller()
  private probablyLikeScroller = new Scroller()

  goodsItemWidth = (DisplayUtil.getWidth() - 30) / 2

  aboutToAppear() {
    this.queryCartGoods()
  }

  build() {
    Stack() {
      Column() {
        this.AddressHeader()
        Scroll(this.scrollScroller) {
          Column() {
            this.CartGoodsList()
            this.ProbablyLike()
          }
        }
        .edgeEffect(EdgeEffect.Spring)
        .friction(0.6)
        .scrollBar(BarState.Off)
        .width(StyleConstants.FULL_WIDTH)
        .height(`calc(100% - (${40 + this.totalInfoHeight + this.getUIContext().px2vp(AppUtil.getStatusBarHeight())}vp))`)

        // this.TotalInfo()
      }
      .backgroundColor('#F1F1F1')
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)

      this.BackTop()
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
  }

  @Builder
  AddressHeader() {
    Column() {
      Row() {
        Text('购物车')
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Medium)
          .fontSize(StyleConstants.FONT_SIZE_TWENTY)
      }
      .height(40)
      .width(StyleConstants.FULL_WIDTH)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .padding({left: 12})
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(40 + this.getUIContext().px2vp(AppUtil.getStatusBarHeight()))
    .padding({top: this.getUIContext().px2vp(AppUtil.getStatusBarHeight())})
  }

  @Builder
  StoreInfo(info: StoreGoodsInfo) {
    Row() {
      Column() {
        Image(info.select ? $r('app.media.selector_check_true') : $r('app.media.selector_check_false'))
          .width(18)
          .height(18)
      }
      .width(45)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.End)
      .height(StyleConstants.FULL_HEIGHT)

      Image($r('app.media.ic_store'))
        .width(20)
        .height(20)
      Text(info.storeName)
        .fontColor(Color.Black)
        .fontSize(StyleConstants.FONT_SIZE_SIXTEEN)
        .margin({left: 6})
      Image($r('app.media.ic_arrow_right'))
        .width(20)
        .height(20)
    }
    .backgroundColor(Color.White)
    .height(32)
    .alignItems(VerticalAlign.Bottom)
    .margin({left: 10, right: 10})
    .width(`calc(100% - 20vp)`)
    .border({radius: { topLeft: 10, topRight: 10 }})
  }

  @Builder
  CartGoodsList() {
    List() {
      ForEach(this.cartStoreGoodsList, (item: StoreGoodsInfo, parentIndex: number) => {
        ListItemGroup({header: this.StoreInfo(item)}) {
          ForEach(item.goodsList, (goodsItem: GoodsInfo, index: number) => {
            ListItem() {
              Row() {
                Column() {
                  Image(goodsItem.select ? $r('app.media.selector_check_true') : $r('app.media.selector_check_false'))
                    .width(18)
                    .height(18)
                }
                .width(45)
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.Center)
                .height(StyleConstants.FULL_HEIGHT)

                ImageKnifeComponent({
                  imageKnifeOption: {
                    loadSrc: goodsItem.imgUrl,
                    placeholderSrc: $r('app.media.default'),
                    errorholderSrc: $r('app.media.default'),
                    objectFit: ImageFit.Fill,
                    border: {radius: 8}
                  }
                })
                  .height(80)
                  .width(80)

                Column() {
                  Text(goodsItem.description)
                    .maxLines(2)
                    .wordBreak(WordBreak.BREAK_ALL)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .fontColor('#777677')
                    .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)

                  Text(`${goodsItem.color}，${goodsItem.size}，选服务`)
                    .backgroundColor('#F1F1F1')
                    .fontColor('#949596')
                    .fontSize(StyleConstants.FONT_SIZE_TWELVE)
                    .padding({left: 5, right: 5, top: 2, bottom: 2})
                    .border({radius: 12 })
                    .margin({top: 6})

                  Row() {
                    Text(`￥${goodsItem.price}`)
                      .fontWeight(FontWeight.Medium)
                      .fontColor($r('app.color.dot_active_color'))
                      .fontSize(StyleConstants.FONT_SIZE_EIGHTEEN)

                    StepperComponent({
                      initialValue: 1,
                      min: 1,
                      max: 9999,
                      step: 1,
                      onChange: (val: number) => {
                      }
                    })
                  }
                  .width(StyleConstants.FULL_WIDTH)
                  .justifyContent(FlexAlign.SpaceBetween)
                  .margin({top: 6})
                }
                .width(`calc(100% - 125vp)`)
                .padding({left: 6, right: 6})
                .alignItems(HorizontalAlign.Start)
                .justifyContent(FlexAlign.Start)
              }
              .height(108)
              .width(StyleConstants.FULL_WIDTH)
            }
            .backgroundColor(Color.White)
            .width(`calc(100% - 20vp)`)
            .border({radius: { bottomLeft: index + 1 == item.goodsList.length ? 10 : 0, bottomRight: index + 1 == item.goodsList.length ? 10 : 0 }})
            .margin({left: 10, right: 10, bottom: index + 1 != item.goodsList.length ? 0 : (parentIndex + 1 !=  this.cartStoreGoodsList.length ? 12 : 0)})

          },(goodsItem: GoodsInfo) => goodsItem.code)
        }
        .width(StyleConstants.FULL_WIDTH)
      },(item: StoreGoodsInfo) => item.storeCode)
    }
    .width(StyleConstants.FULL_WIDTH)
  }

  @Builder
  ProbablyLike() {
    Column() {
      Image($r('app.media.probably_like'))
        .objectFit(ImageFit.Fill)
        .height(42)
        .width(StyleConstants.FULL_WIDTH)

      CommodityList({
        categoryCode: "probablyLike",
        scrollController: this.probablyLikeScroller,
        itemWidth: this.goodsItemWidth,
        onScrollIndexCall: (first => {
          this.showBackTop = first > 5
        })
      })
    }
  }

  @Builder
  TotalInfo() {
    Row() {

    }
    .height(this.totalInfoHeight)
    .width(StyleConstants.FULL_WIDTH)
    .backgroundColor(Color.White)
    .border({width: { bottom: 1, top: 1 }, color: '#EAEAEA'})
  }

  @Builder
  BackTop() {
    FloatingBackTop({
      location: ({ x: '85%', y: '90%' }),
      display: (this.showBackTop ? Visibility.Visible : Visibility.None),
      onClickFun: (() => {
        this.probablyLikeScroller.scrollTo({ xOffset: 0, yOffset: 0, animation: { duration: 200, curve: Curve.Friction  } })
        this.scrollScroller.scrollTo({ xOffset: 0, yOffset: 0, animation: { duration: 400, curve: Curve.Friction  } })
      })
    })
  }

  queryCartGoods() {
    queryCartGoodsList().then(list => {
      this.cartStoreGoodsList = list || []
    })
  }
}
