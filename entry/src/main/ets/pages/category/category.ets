import { StyleConstants } from "@ohos/common"
import { ImageKnifeComponent } from "@ohos/imageknife"
import { AppUtil } from "@pura/harmony-utils"
import {
  CategoryInfo,
  queryCategoryList,
  queryGroupCategoryList,
  SecondCategoryInfo, ThirdCategoryInfo
} from "../../service/category"

@Component
export struct Category {
  leftScroller: Scroller = new Scroller()
  horizontalScroller: Scroller = new Scroller()
  groupScroller: Scroller = new Scroller()

  private isClick = false

  @State selectedCategoryCode:string = ""
  @State categoryList: CategoryInfo[] = []
  @State selectedSecondCategoryCode: string = ''
  @State groupCategoryList: SecondCategoryInfo[] = []

  aboutToAppear() {
    this.queryLeftCategoryList()
  }

  build() {
    Column() {
      this.CategoryHeader()
      Row() {
        this.LeftCategory()
        this.GroupList()
      }
      .width(StyleConstants.FULL_WIDTH)
      .height(`calc(100% - (${50 + this.getUIContext().px2vp(AppUtil.getStatusBarHeight())}vp))`)
      .backgroundColor(Color.White)
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
  }

  @Builder
  CategoryHeader() {
    Row() {
      Column() {
        Image($r('app.media.scan'))
          .width(20).height(20)
        Text('扫描')
          .margin({top: 2})
          .fontSize(StyleConstants.FONT_SIZE_TWELVE)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
      }
      .alignItems(HorizontalAlign.Center)
      Row() {
        Image($r('app.media.ic_search'))
          .width(18).height(18)
          .margin({left: 8})
        Text('这是搜索框')
          .margin({
            left: 6,
            right: 6,
            top: 2
          })
          .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
          .fontColor('#8F9093')
          .textAlign(TextAlign.Center)
      }
      .alignItems(VerticalAlign.Center)
      .height(32)
      .width(`calc(100% - 68vp)`)
      .backgroundColor(Color.White)
      .borderRadius(12)

      Column() {
        Image($r('app.media.ic_message_white'))
          .width(20).height(20)
        Text('消息')
          .margin({top: 2})
          .fontSize(StyleConstants.FONT_SIZE_TWELVE)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(50 + this.getUIContext().px2vp(AppUtil.getStatusBarHeight()) )
    .padding({top: this.getUIContext().px2vp(AppUtil.getStatusBarHeight()), left: 10, right: 10})
    .backgroundColor($r('app.color.common_header_bg'))
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  LeftCategory() {
    List({scroller: this.leftScroller}) {
      ForEach(this.categoryList, (item: CategoryInfo, index: number) => {
        ListItem() {
          Row() {
            Text(item.name)
              .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
              .fontColor(item.code === this.selectedCategoryCode ? $r('app.color.tab_active_color') : Color.Black)
          }
          .height(62)
          .width(StyleConstants.FULL_WIDTH)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .backgroundColor('#EAEDEE')
          .onClick(() => {
            this.selectedCategoryCode = item.code
            this.leftScroller.scrollToIndex(index, true, ScrollAlign.CENTER)
          })
        }
      },(item: CategoryInfo) => item.code)
    }
    .scrollBar(BarState.Off)
    .friction(0.6)
    .width('calc(100%/3)')
    .height(StyleConstants.FULL_HEIGHT)
    .backgroundColor(Color.White)
  }

  @Builder
  GroupList() {
    Column() {
      List({scroller: this.horizontalScroller}) {
        ForEach(this.groupCategoryList, (item: SecondCategoryInfo, index: number) => {
          ListItem() {
            Row() {
              Text(item.categoryName)
                .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
                .fontColor(this.selectedSecondCategoryCode == item.categoryCode ? $r('app.color.tab_active_color') : Color.Black)
            }
            .height(32)
            .borderRadius(14)
            .padding({left: 15, right: 15})
            .margin({right: index + 1 != this.groupCategoryList.length ? 8 : 0})
            .backgroundColor(Color.White)
            .borderStyle(BorderStyle.Solid)
            .borderWidth(1)
            .borderColor(this.selectedSecondCategoryCode == item.categoryCode ? $r('app.color.tab_active_color') : Color.White)
            .onClick(() => {
              this.isClick = true
              this.selectedSecondCategoryCode = item.categoryCode
              this.horizontalScroller.scrollToIndex(index, true, ScrollAlign.CENTER)
              this.groupScroller.scrollToIndex(index, true, ScrollAlign.START)
            })
          }
          .height(32)
          .margin({top: 8})
        }, (item: SecondCategoryInfo) => item.categoryCode)
      }
      .listDirection(Axis.Horizontal)
      .scrollBar(BarState.Off)
      .friction(0.6)
      .height(48)
      .backgroundColor('#EAEDEE')
      .width(StyleConstants.FULL_WIDTH)

      List({scroller: this.groupScroller}) {
        ForEach(this.groupCategoryList, (item: SecondCategoryInfo, index: number) => {
          ListItemGroup({header: this.itemHead(item.categoryName)}) {
            ListItem() {
              List() {
                ForEach(item.cateList, (subItem: ThirdCategoryInfo, subIndex: number) => {
                  ListItem() {
                    Column() {
                      ImageKnifeComponent({
                        imageKnifeOption: {
                          loadSrc: subItem.iconUrl,
                          placeholderSrc: $r('app.media.default'),
                          errorholderSrc: $r('app.media.default'),
                          objectFit: ImageFit.Fill
                        }
                      })
                        .height(50)
                        .width(50)

                      Text(subItem.categoryName)
                        .fontSize(StyleConstants.FONT_SIZE_TWELVE)
                        .fontColor('#797979')
                        .margin({top: 6})
                    }
                  }
                  .margin({top: 10, bottom: 10})
                }, (subItem: ThirdCategoryInfo) => subItem.categoryCode)
              }
              .lanes(3)
              .width(StyleConstants.FULL_WIDTH)
              .scrollBar(BarState.Off)
              .friction(0.6)
              .alignListItem(ListItemAlign.Center)
            }
          }
        },(item: SecondCategoryInfo) => item.categoryCode)
      }
      .width(StyleConstants.FULL_WIDTH)
      .height('calc(100% - 48vp)')
      .scrollBar(BarState.Off)
      .friction(0.6)
      .onScrollIndex((first) => {
        if(this.isClick) return
        this.horizontalScroller.scrollToIndex(first, true, ScrollAlign.CENTER)
        this.selectedSecondCategoryCode = this.groupCategoryList[first].categoryCode
      })
      .onScrollStop(() => this.isClick = false)
    }
    .width('calc(100% * 2/3)')
    .height(StyleConstants.FULL_HEIGHT)
  }

  @Builder
  itemHead(text: string) {
    Text(text)
      .fontSize(StyleConstants.FONT_SIZE_EIGHTEEN)
      .padding(10)
  }

  queryLeftCategoryList() {
    queryCategoryList().then(res => {
      const list = res || []
      const defaultCategoryCode = list.length ? list[0].code : ''
      this.categoryList = list
      this.selectedCategoryCode = defaultCategoryCode

      this.queryGroupCategoryInfo(defaultCategoryCode)
    })
  }

  queryGroupCategoryInfo(code: string) {
    queryGroupCategoryList(code).then(info => {
      const groupList = info.secondCateList || []
      this.groupCategoryList = groupList
      this.selectedSecondCategoryCode = groupList.length ? groupList[0].categoryCode : ''
    })
  }
}