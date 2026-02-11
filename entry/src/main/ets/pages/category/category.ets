import { StyleConstants } from "@ohos/common"
import { AppUtil } from "@pura/harmony-utils"
import { CategoryInfo } from "../../service/category"

@Component
export struct Category {
  leftScroller: Scroller = new Scroller()

  @State selectedCategoryCode:string = "000"
  @State categoryList: CategoryInfo[] = [
    {
      "name": "推荐分类",
      "code": "000"
    },
    {
      "name": "运动户外",
      "code": "001"
    },
    {
      "name": "男装",
      "code": "002"
    },
    {
      "name": "手机",
      "code": "003"
    },
    {
      "name": "家电",
      "code": "004"
    },
    {
      "name": "电脑办公",
      "code": "005"
    },
    {
      "name": "母婴童装",
      "code": "006"
    },
    {
      "name": "食品酒饮",
      "code": "007"
    },
    {
      "name": "鞋靴",
      "code": "008"
    },
    {
      "name": "家具家装",
      "code": "009"
    },
    {
      "name": "个护清洁",
      "code": "010"
    },
    {
      "name": "家居厨具",
      "code": "011"
    },
    {
      "name": "内衣配饰",
      "code": "012"
    },
    {
      "name": "医疗保健",
      "code": "013"
    },
    {
      "name": "数码",
      "code": "014"
    },
    {
      "name": "女装",
      "code": "015"
    },
    {
      "name": "生鲜",
      "code": "016"
    },
    {
      "name": "美妆护肤",
      "code": "017"
    },
    {
      "name": "宠物鲜花",
      "code": "018"
    },
    {
      "name": "钟表珠宝",
      "code": "019"
    },
    {
      "name": "玩具乐器",
      "code": "020"
    },
    {
      "name": "箱包",
      "code": "021"
    },
    {
      "name": "奢侈品",
      "code": "022"
    },
    {
      "name": "医药",
      "code": "023"
    },
    {
      "name": "图书文娱",
      "code": "024"
    },
    {
      "name": "拍卖",
      "code": "025"
    }
  ]

  build() {
    Column() {
      this.CategoryHeader()
      Row() {
        this.LeftCategory()
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
}