import {
  DataSource,
  StyleConstants,
  RouterConstants,
  CommodityList,
  FloatingBackTop
} from '@ohos/common'
import { ZRoute, ZRouter } from '@hzw/zrouter'
import { ImageKnifeComponent } from '@ohos/imageknife'
import { DisplayUtil, LogUtil } from '@pura/harmony-utils'
import { LengthUnit } from '@kit.ArkUI'
import { AppraiseInfo, BannerInfo, GoodsDetailInfo, queryGoodsDetailInfo } from '../../../service/detailService'
import { CommonSwiperModifier } from '../../../modifier/swiperModifier'

@Entry
@ZRoute({ name:RouterConstants.goods_detail_page, useTemplate: true })
@Component
export struct GoodsDetail {
  @StorageProp('safeTop') safeTop: number = 0

  @State showBackTop: boolean = false
  @State topTabCurrentIndex: number = 0
  @State topTabOpacity: number = 0
  @State currentSkuIndex: number = 0
  @State currentColor: string = ''
  @State goodsDetailInfo: GoodsDetailInfo = {}
  @State isClick: boolean = false

  private tabHeaderHeight = 50 + this.safeTop
  private currentSkuImgList = new DataSource<string>([])
  private scrollScroller: Scroller = new Scroller()
  private introductionImgList = new DataSource<string>([])
  private storeGoodsScroller = new Scroller()

  goodsItemWidth = (DisplayUtil.getWidth() - 10) / 2

  aboutToAppear() {
    const goodsId = ZRouter.getInstance().getParamByKey<string>('goodsId')
    this.queryGoodsInfo(goodsId)
  }

  build() {
    Stack() {
      this.TabHeader()
      List({scroller: this.scrollScroller}) {
        ListItem(){ this.GoodsInfo() }
        ListItem(){ this.EvaluateInfo() }
        ListItem(){ this.GraphicDetails() }
        ListItem(){ this.StoreOtherGoods() }
      }
      .friction(0.6)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
      .backgroundColor($r('app.color.page_background'))
      .onDidScroll((scrollOffset) => {
        const currentOffsetY = this.scrollScroller.currentOffset().yOffset

        this.showBackTop = Math.floor(currentOffsetY) >= this.getUIContext().px2vp(DisplayUtil.getHeight())
        this.topTabOpacity = Math.floor(currentOffsetY) >= 50 ? 1 : currentOffsetY / 50

        if(this.isClick) return
        const newOffsetY =  scrollOffset + this.tabHeaderHeight
        try {
          const firstVisibleIndex = this.scrollScroller.getItemIndex(0, newOffsetY)
          this.topTabCurrentIndex = firstVisibleIndex
        } catch (error) {}
      })
      .onScrollStop(() => {
        this.isClick = false
      })

      this.BackTop()
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
  }

  @Builder
  TabHeader() {
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
              .onClick(() => {
                this.isClick = true
                this.topTabCurrentIndex = index
                this.storeGoodsScroller.scrollToIndex(0)
                this.scrollScroller.scrollToIndex(index, true, ScrollAlign.START, { extraOffset: { value: -this.tabHeaderHeight, unit: LengthUnit.VP } })
              })
            }
          },(item: string) => item)
        }
        .listDirection(Axis.Horizontal)
        .width(StyleConstants.FULL_WIDTH)
        .height(StyleConstants.FULL_HEIGHT)
      }
      .width(`calc(100% - 200vp)`)
      .opacity(this.topTabOpacity)
      .height(StyleConstants.FULL_HEIGHT)

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
    .backgroundColor(`rgba(255, 255, 255, ${this.topTabOpacity})`)
    .height(this.tabHeaderHeight)
    .padding({top: this.safeTop + 4})
    .position({x: 0 , y: 0})
    .zIndex(99)
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
      .width(StyleConstants.FULL_WIDTH)
      .backgroundColor(Color.White)
      .attributeModifier(new CommonSwiperModifier('goodsTopSliderImg'))

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
                this.currentColor = this.goodsDetailInfo?.bannerList?.length ? this.goodsDetailInfo?.bannerList[index]?.colorName || '' : ''
              })

            },(item: BannerInfo) => item.colorId)
          }
          .layoutWeight(1)
          .listDirection(Axis.Horizontal)
          .height(StyleConstants.FULL_HEIGHT)
        }
        .height(80)
        .alignItems(VerticalAlign.Center)
        .padding({right: 12, left: 12})

        Text(`￥${this.goodsDetailInfo.goodsInfo?.specialPrice || '-'}`)
          .fontSize(26)
          .fontColor($r('app.color.indian_red'))
          .fontWeight(FontWeight.Bold)
          .margin({left: 10})

        Text(this.goodsDetailInfo.goodsInfo?.goodsName || '')
          .maxLines(2)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .textOverflow({overflow: TextOverflow.Ellipsis})
          .margin({left: 10, top: 10})
      }
      .width('calc(100% - 20vp)')
      .margin({top: 10})
      .padding({top: 10, bottom:10})
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(Color.White)
      .borderRadius(8)

      Column() {
        Row() {
          Text('选择')
            .fontColor('#8B8C8A')
            .fontSize(StyleConstants.FONT_SIZE_SIXTEEN)
          Row(){
            Text('已选')
              .maxLines(2)
              .fontSize(StyleConstants.FONT_SIZE_SIXTEEN)

            Text(this.currentColor)
              .maxLines(2)
              .fontSize(StyleConstants.FONT_SIZE_SIXTEEN)
              .margin({left: 5})
            Text('，42，1件')
              .maxLines(2)
              .fontSize(StyleConstants.FONT_SIZE_SIXTEEN)
          }
          .margin({left: 10,right: 10})
          .layoutWeight(1)

          Image($r('app.media.arrow_right_black'))
            .width(6)
            .height(20)
            .margin({top: -2})
        }
        .alignItems(VerticalAlign.Top)
        .padding({top: 10})
        this.RowItem('送至', `江苏省南京市江宁区东山街道幸福路18号招商花园`, true)
        this.RowItem('运费', `店铺单笔订单不满199元，收费5元(请以提交订单时为准)`, false)
        Row() {
          Text('买满300减40')
            .fontColor('#8B8C8A')
            .fontSize(StyleConstants.FONT_SIZE_SIXTEEN)
          Text('满199减20')
            .fontColor('#8B8C8A')
            .fontSize(StyleConstants.FONT_SIZE_SIXTEEN)
          Text('满49减1')
            .fontColor('#8B8C8A')
            .fontSize(StyleConstants.FONT_SIZE_SIXTEEN)
        }
        .margin({top: 20})
        .width(StyleConstants.FULL_WIDTH)
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('calc(100% - 20vp)')
      .margin({ top: 10})
      .padding(10)
      .backgroundColor(Color.White)
      .borderRadius(8)
    }
    .width(StyleConstants.FULL_WIDTH)
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  RowItem(label: string, value: string, showArrow: boolean) {
    Row() {
      Text(label)
        .fontColor('#8B8C8A')
        .fontSize(StyleConstants.FONT_SIZE_SIXTEEN)
      Text(value)
        .maxLines(2)
        .layoutWeight(1)
        .fontSize(StyleConstants.FONT_SIZE_SIXTEEN)
        .margin({left: 10, right: 10})
      Image($r('app.media.arrow_right_black'))
        .width(6)
        .height(20)
        .margin({top: -2})
        .visibility(showArrow ? Visibility.Visible : Visibility.None)
    }
    .alignItems(VerticalAlign.Top)
    .padding({top: 10})
  }

  @Builder
  appraiserInfo(headerImg: string, name: string, content: string) {
    Column() {
      Row() {
        ImageKnifeComponent({
          imageKnifeOption: {
            loadSrc: headerImg,
            placeholderSrc: $r('app.media.default'),
            errorholderSrc: $r('app.media.default'),
            objectFit: ImageFit.Fill,
            border: {radius: 15}
          }
        })
          .width(30)
          .height(30)
        Text(name)
          .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
          .padding(10)
      }
      .width(StyleConstants.FULL_WIDTH)
      Text(content)
        .maxLines(2)
        .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
    }
    .width(StyleConstants.FULL_WIDTH)

  }

  @Builder
  colorInfo(colorName: string) {
    Text(colorName)
      .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
  }

  @Builder
  EvaluateInfo() {
    Column() {
      Column(){
        Text('评价')
          .secondTitle()

        List(){
          ForEach(this.goodsDetailInfo.goodsInfo?.appraiseList || [], (item: AppraiseInfo, index: number) => {
            ListItemGroup({header: this.appraiserInfo(item.headerUrl, item.userName, item.content), footer: this.colorInfo(item.color)}) {
              ListItem() {
                List() {
                  ForEach(item.imgList || [], (subItem: string) => {
                    ImageKnifeComponent({
                      imageKnifeOption: {
                        loadSrc: subItem,
                        placeholderSrc: $r('app.media.default'),
                        errorholderSrc: $r('app.media.default'),
                        objectFit: ImageFit.Fill,
                        border: {radius: 8}
                      }
                    })
                      .width(80)
                      .height(80)
                  }, (subItem: string) => subItem)
                }
                .lanes(4)
                .width(StyleConstants.FULL_WIDTH)
                .scrollBar(BarState.Off)
                .friction(0.6)
                .margin({top: 5, bottom: 5})
              }
            }
            .margin({top: 10, bottom: 10})
          }, (item: AppraiseInfo, index: number) => item.appraiseId)
        }

        Row(){
          Button('查看全部评论', { type: ButtonType.ROUNDED_RECTANGLE})
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Normal)
            .border({width: 2, style: BorderStyle.Solid, color: Color.Grey})
            .backgroundColor(Color.White)
        }
        .width(StyleConstants.FULL_WIDTH)
        .justifyContent(FlexAlign.Center)
      }
      .WhiteCard()

      Column() {
        Text('活动专区')
          .secondTitle()

        ImageKnifeComponent({
          imageKnifeOption: {
            loadSrc: this.goodsDetailInfo?.detailInfo?.hdzq || '',
            placeholderSrc: $r('app.media.default'),
            errorholderSrc: $r('app.media.default'),
            objectFit: ImageFit.Auto,
          }
        })
          .width(StyleConstants.FULL_WIDTH)
      }
      .WhiteCard()

      Column() {
        Text('店内优选')
          .secondTitle()

        ImageKnifeComponent({
          imageKnifeOption: {
            loadSrc: this.goodsDetailInfo?.detailInfo?.dnyx || '',
            placeholderSrc: $r('app.media.default'),
            errorholderSrc: $r('app.media.default'),
            objectFit: ImageFit.Auto,
          }
        })
          .width(StyleConstants.FULL_WIDTH)
      }
      .WhiteCard()
    }
  }

  @Builder
  GraphicDetails() {
    Column() {
      Text('详情')
        .secondTitle()

      List() {
        LazyForEach(this.introductionImgList, (imgUrl: string) => {
          ListItem(){
            ImageKnifeComponent({
              imageKnifeOption: {
                loadSrc: imgUrl|| '',
                placeholderSrc: $r('app.media.default'),
                errorholderSrc: $r('app.media.default'),
                objectFit: ImageFit.Auto,
              }
            })
              .width(StyleConstants.FULL_WIDTH)
          }
          .width(StyleConstants.FULL_WIDTH)
        },(imgUrl: string) => imgUrl)
      }
      .width(StyleConstants.FULL_WIDTH)
    }
    .WhiteCard()
  }

  @Builder
  StoreOtherGoods() {
    Column() {
      CommodityList({
        categoryCode: "storeOtherGoods",
        scrollController: this.storeGoodsScroller,
        itemWidth: this.goodsItemWidth
      })
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .margin({ top: 10, bottom: 10})
    .borderRadius(8)
  }

  @Builder
  BackTop() {
    FloatingBackTop({
      location: ({ x: '85%', y: '85%' }),
      display: (this.showBackTop ? Visibility.Visible : Visibility.None),
      onClickFun: (() => {
        this.storeGoodsScroller.scrollToIndex(0)
        this.scrollScroller.scrollTo({ xOffset: 0, yOffset: 0, animation: { duration: 200, curve: Curve.Friction  } })
      })
    })
  }

  queryGoodsInfo(goodsId: string) {
    if(!goodsId) return

    queryGoodsDetailInfo(goodsId).then(res => {
      this.goodsDetailInfo = res
      const imgList = res?.bannerList?.length ? res?.bannerList[0]?.imgList || [] : []
      const colorName = res?.bannerList?.length ? res?.bannerList[0]?.colorName || '' : ''
      const detailImgList = res?.detailInfo?.introductionList?.length ? res?.detailInfo?.introductionList || [] : []

      this.currentSkuImgList.setData(imgList)
      this.introductionImgList.setData(detailImgList)
      this.currentColor = colorName
    })
  }
}

@Extend(Text)
function secondTitle() {
  .fontSize(StyleConstants.FONT_SIZE_SIXTEEN)
  .fontColor('#828181')
  .margin({bottom: 5})
  .fontWeight(FontWeight.Normal)
}

@Extend(Column)
function WhiteCard() {
  .alignItems(HorizontalAlign.Start)
  .justifyContent(FlexAlign.Start)
  .width('calc(100% - 20vp)')
  .margin({ left: 10, top: 10})
  .padding(10)
  .backgroundColor(Color.White)
  .borderRadius(8)
}