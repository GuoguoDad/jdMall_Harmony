import { CommonDotIndicator, DataSource, StyleConstants } from '@ohos/common'
import { ZRoute, ZRouter } from '@hzw/zrouter'
import { BannerInfo } from '../../../service/detail'
import { ImageKnifeComponent } from '@ohos/imageknife'
import { DisplayUtil } from '@pura/harmony-utils'

@Entry
@ZRoute({ name: 'GoodsDetail', useTemplate: true })
@Component
export struct GoodsDetail {
  @StorageProp('safeTop') safeTop: number = 0

  @State topTabCurrentIndex: number = 0
  @State fixedHeaderOpacity: number = 0

  private goodsImgList = new DataSource<string>([
    "https://ik.imagekit.io/guoguodad/mall/detail/f5c28554c39fee6d.jpg",
    "https://ik.imagekit.io/guoguodad/mall/detail/8dff30acead53213.jpg",
    "https://ik.imagekit.io/guoguodad/mall/detail/1c8f4ba0ccf38c9e.jpg",
    "https://ik.imagekit.io/guoguodad/mall/detail/44bdb9081eaec2be.jpg",
    "https://ik.imagekit.io/guoguodad/mall/detail/8ca83cf7694ebd07.jpg",
    "https://ik.imagekit.io/guoguodad/mall/detail/e71af88949e071ed.jpg",
    "https://ik.imagekit.io/guoguodad/mall/detail/4de912b7b8ae3bfe.jpg"
  ])

  private scrollScroller: Scroller = new Scroller()

  build() {
    Stack() {
      this.FixedHeader()
      Scroll(this.scrollScroller) {
        Column() {
          this.GoodsInfo()
        }
        .width(StyleConstants.FULL_WIDTH)
        .justifyContent(FlexAlign.Start)
      }
      .edgeEffect(EdgeEffect.Spring)
      .friction(0.6)
      .backgroundColor($r('app.color.page_background'))
      .scrollBar(BarState.Off)
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
      .onDidScroll(() => {
        let currentOffset = this.scrollScroller.currentOffset().yOffset
      })
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
  }

  @Builder
  FixedHeader() {
    Row() {
      Row() {
        Image($r('app.media.ic_back_black'))
          .width(26)
          .height(26)
      }
      .width(100)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .padding({left: 10})
      .height(StyleConstants.FULL_HEIGHT)
      .onClick(() => ZRouter.getInstance().navigateBack())

      Row() {
        List(){
          ForEach(['商品', '评价', '详情', '推荐'], (item: string, index: number) => {
            ListItem() {
              Column() {
                Text(item)
                  .fontSize(StyleConstants.FONT_SIZE_SIXTEEN)

                Column()
                  .width(26)
                  .height(4)
                  .border({radius: 20})
                  .margin({top: 6})
                  .backgroundColor(index == this.topTabCurrentIndex ? $r('app.color.indian_red') : Color.White)
              }
              .height(50)
              .width('25%')
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .onClick(()=> this.topTabCurrentIndex = index )
            }
          },(item: string) => item)
        }
        .listDirection(Axis.Horizontal)
        .width(StyleConstants.FULL_WIDTH)
        .height(StyleConstants.FULL_HEIGHT)
      }
      .width(`calc(100% - 200vp)`)
      .height(StyleConstants.FULL_HEIGHT)
      .opacity(this.fixedHeaderOpacity)

      Row() {
        Image($r('app.media.ic_share_black'))
          .width(20)
          .height(20)
          .margin({right: 16})
        Image($r('app.media.ic_ellipsis_black'))
          .width(20)
          .height(20)
      }
      .width(100)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.End)
      .padding({right: 16})
      .height(StyleConstants.FULL_HEIGHT)
    }
    .width(StyleConstants.FULL_WIDTH)
    .backgroundColor(`rgba(255, 255, 255, ${this.fixedHeaderOpacity})`)
    .height(50 + this.safeTop)
    .padding({top: this.safeTop + 4})
    .position({x: 0, y: 0})
    .zIndex(2)
  }

  @Builder
  GoodsInfo() {
    Column() {
      Swiper() {
        LazyForEach(this.goodsImgList, (url: string) => {
          ImageKnifeComponent({
            imageKnifeOption: {
              loadSrc: url,
              placeholderSrc: $r('app.media.default'),
              errorholderSrc: $r('app.media.default'),
              objectFit: ImageFit.Fill
            }
          })
            .width(StyleConstants.FULL_WIDTH)
            .height(this.getUIContext().px2vp(DisplayUtil.getHeight()) * 0.4 )
        }, (item: string) => item)
      }
      .cachedCount(2)
      .index(0)
      .autoPlay(false)
      .interval(6000)
      .loop(true)
      .duration(500)
      .itemSpace(0)
      .indicator(CommonDotIndicator(8,8,8,8))
      .curve(Curve.Linear)
      .width(StyleConstants.FULL_WIDTH)

      Column() {

      }
      .width('calc(100% - 20vp)')
      .height(200)
      .margin({ top: 10})
      .backgroundColor(Color.White)
      .borderRadius(8)

      Column() {

      }
      .width('calc(100% - 20vp)')
      .height(1400)
      .margin({ top: 10})
      .backgroundColor(Color.White)
      .borderRadius(8)
    }
    .width(StyleConstants.FULL_WIDTH)
    .justifyContent(FlexAlign.Start)
  }
}