import { ImageKnifeComponent } from '@ohos/imageknife'
import { LogUtil } from '@pura/harmony-utils'
import { StyleConstants } from '../../../../Index'
import { CommodityInfo, queryGoodsListByPage } from '../service/common'
import { DataSource } from '../utils/DataSource'
import { LoadMoreFooter } from './LoadMoreFooter'

@Component
export struct CommodityList {
  @Prop categoryCode: string = '01'
  @Prop itemWidth: number = 0

  @State currentPage: number = 1
  @State isLoading: boolean = true
  @State hasNext: boolean = true

  scrollController?: Scroller
  onScrollIndexCall?: (first: number) => void

  private dataSource = new DataSource<CommodityInfo>([])

  constructor(scrollController: Scroller, onScrollIndexCall: (first: number) => void) {
    super()
    this.scrollController = scrollController
    this.onScrollIndexCall = onScrollIndexCall
  }

  aboutToAppear() {
    this.queryGoodsList(1)
  }

  build() {
    WaterFlow({scroller: this.scrollController, footer: this.footer()}) {
      LazyForEach(this.dataSource, (item: CommodityInfo) => {
        FlowItem() {
         this.GoodsItem(item)
        }
        .width(StyleConstants.FULL_WIDTH)
      }, (item:CommodityInfo) => item.id)
    }
    .columnsTemplate('1fr 1fr')
    .rowsGap(10)
    .columnsGap(10)
    .padding({left: 10, right: 10})
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.SELF_FIRST
    })
    .onScrollIndex((first)=> {
      if(this.onScrollIndexCall) this.onScrollIndexCall(first)
    })
    .onReachEnd(() => {
      if(!this.isLoading && this.hasNext) {
        this.queryGoodsList(this.currentPage + 1)
      }
    })
  }

  @Builder
  footer() {
    LoadMoreFooter({isLoading: this.isLoading, hasNextPage: this.hasNext})
  }

  @Builder
  GoodsItem(item: CommodityInfo) {
    Column() {
      ImageKnifeComponent({
        imageKnifeOption: {
          loadSrc: item.imgUrl,
          placeholderSrc: $r('app.media.default'),
          errorholderSrc: $r('app.media.default'),
          objectFit: ImageFit.Fill,
          border: {radius: {topLeft: 8, topRight: 8}}
        }
      })
        .width(StyleConstants.FULL_WIDTH)
        .height(this.getUIContext().px2vp(this.itemWidth))

      Column(){
        Text(item.description)
          .maxLines(2)
          .textOverflow({overflow: TextOverflow.Ellipsis})
          .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
          .fontColor($r('app.color.goods_description'))

        Text(`￥${item.price}`)
          .fontSize(StyleConstants.FONT_SIZE_TWELVE)
          .fontColor($r('app.color.goods_price'))
          .margin({top: 8})
      }
      .padding({top: 10, left:6, right:6, bottom: 12})
      .width(StyleConstants.FULL_WIDTH)
      .alignItems(HorizontalAlign.Start)
      .visibility(item.type == '1' ? Visibility.Visible: Visibility.None)

      Column(){
        Text(item.tag)
          .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
          .fontColor(Color.White)
          .borderRadius(18)
          .padding({left: 8, right: 8, top: 2, bottom: 2})
          .linearGradient({
            direction: GradientDirection.Right,
            colors: [['#D2554F', 0.2],['#D47273', 0.6], ['#D79098', 0.2]]
          })
        Text(item.des1).fontSize(StyleConstants.FONT_SIZE_FOURTEEN).fontColor('#EC5F5A').margin({top: 4})
        Text(item.des2).fontSize(StyleConstants.FONT_SIZE_FOURTEEN).fontColor('#9E9F9E').margin({top: 4})
        Text('点击进入').fontSize(StyleConstants.FONT_SIZE_TWELVE).fontColor('#EC5F5A').margin({top: 4})
      }
      .width(StyleConstants.FULL_WIDTH)
      .padding({top: 10, left:6, right: 6, bottom: 12})
      .alignItems(HorizontalAlign.Start)
      .visibility(item.type == '2' ? Visibility.Visible: Visibility.None)
    }
    .width(StyleConstants.FULL_WIDTH)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(8)
  }


  queryGoodsList(pageNo: number) {
    this.isLoading = true
    queryGoodsListByPage(this.categoryCode, pageNo, 15).then(pageInfo => {
      this.isLoading = false
      if(pageNo == 1) {
        this.dataSource.setData(pageInfo.goodsList || [])
      } else {
        this.dataSource.addNewItems(pageInfo.goodsList || [])
      }
      // LogUtil.info(["queryGoodsListByPage hasNext:", pageNo, pageNo < pageInfo.totalPageCount])
      this.hasNext = pageNo < pageInfo.totalPageCount
      this.currentPage = pageNo
    })
  }
}