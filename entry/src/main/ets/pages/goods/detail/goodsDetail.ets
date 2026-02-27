import { CommonDotIndicator, DataSource, StyleConstants, RouterConstants } from '@ohos/common'
import { ZRoute, ZRouter } from '@hzw/zrouter'
import { ImageKnifeComponent } from '@ohos/imageknife'
import { DisplayUtil, LogUtil } from '@pura/harmony-utils'
import { BannerInfo, GoodsDetailInfo, queryGoodsDetailInfo } from '../../../service/detailService'

@Entry
@ZRoute({ name:RouterConstants.goods_detail_page, useTemplate: true })
@Component
export struct GoodsDetail {
  @StorageProp('safeTop') safeTop: number = 0

  @State topTabCurrentIndex: number = 0
  @State fixedHeaderOpacity: number = 0
  @State currentSkuIndex: number = 0
  @State goodsDetailInfo: GoodsDetailInfo = {}

  private currentSkuImgList = new DataSource<string>([])
  private scrollScroller: Scroller = new Scroller()

  aboutToAppear() {
    // const param = ZRouter.getInstance().getParamByName(RouterConstants.goods_detail_page)
    const goodsId = ZRouter.getInstance().getParamByKey<string>('goodsId')
    this.queryGoodsInfo(goodsId)
  }

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
        let currentOffsetY = this.scrollScroller.currentOffset().yOffset
        if(Math.floor(currentOffsetY) >= 50) {
          this.fixedHeaderOpacity = 1
        } else {
          this.fixedHeaderOpacity = currentOffsetY / 50
        }
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
                  .backgroundColor(index == this.topTabCurrentIndex ? $r('app.color.indian_red') : Color.Transparent)
              }
              .height(50)
              .width('25%')
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .onClick(() => this.topTabCurrentIndex = index )
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
        LazyForEach(this.currentSkuImgList, (url: string) => {
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
      .backgroundColor(Color.White)

      Column() {
        Row() {
          Text(`${this.goodsDetailInfo?.bannerList?.length || ''} 色可选`)
            .fontSize(16)
            .fontColor('#545454')

          List(){
            ForEach(this.goodsDetailInfo?.bannerList || [], (item: BannerInfo, index: number) => {
              ListItem(){
                ImageKnifeComponent({
                  imageKnifeOption: {
                    loadSrc: item.thumb,
                    placeholderSrc: $r('app.media.default'),
                    errorholderSrc: $r('app.media.default'),
                    objectFit: ImageFit.Fill,
                  }
                })
                  .width(68)
                  .height(68)
              }
              .margin({left: 5, right: 5})
              .border({width:2, color: index == this.currentSkuIndex ? $r('app.color.fire_red') : Color.Transparent})
              .onClick(() => {
                this.currentSkuIndex = index
                const imgList = this.goodsDetailInfo?.bannerList?.length ? this.goodsDetailInfo?.bannerList[index]?.imgList || [] : []
                this.currentSkuImgList.setData(imgList)
              })

            },(item: BannerInfo) => item.colorId)
          }
          .layoutWeight(1)
          .listDirection(Axis.Horizontal)
          .height(StyleConstants.FULL_HEIGHT)
        }
        .height(80)
        .alignItems(VerticalAlign.Center)
        .padding({ right: 12, left: 12})

        Text(`￥${this.goodsDetailInfo.goodsInfo?.specialPrice || '-'}`)
          .fontSize(26)
          .fontColor($r('app.color.indian_red'))
          .fontWeight(FontWeight.Bold)
          .margin({left: 10})

        Text(this.goodsDetailInfo.goodsInfo?.goodsName || '')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({left: 10, top: 10})
      }
      .width('calc(100% - 20vp)')
      .margin({top: 10})
      .padding({top: 10, bottom:10})
      .alignItems(HorizontalAlign.Start)
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

  queryGoodsInfo(goodsId: string) {
    if(!goodsId) return

    queryGoodsDetailInfo(goodsId).then(res => {
      this.goodsDetailInfo = res
      const imgList = res?.bannerList?.length ? res?.bannerList[0]?.imgList || [] : []
      this.currentSkuImgList.setData(imgList)
    })
  }
}