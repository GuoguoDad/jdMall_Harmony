import { StyleConstants } from "@ohos/common"
import { ImageKnifeComponent } from "@ohos/imageknife"
import { AppUtil } from "@pura/harmony-utils"
import { CategoryInfo, SecondCategoryInfo, ThirdCategoryInfo } from "../../service/category"

@Component
export struct Category {
  leftScroller: Scroller = new Scroller()
  horizontalScroller: Scroller = new Scroller()
  groupScroller: Scroller = new Scroller()

  private isClick = false

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
  @State selectedSecondCategoryCode: string = '01'
  @State groupCategoryList: SecondCategoryInfo[] = [
    {
      "categoryName": "专场推荐",
      "categoryCode": "01",
      "cateList": [
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category11.jpg?updatedAt=1691720650082",
          "categoryName": "男装馆",
          "categoryCode": "0101"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category12.jpg?updatedAt=1691720649324",
          "categoryName": "玩潮立志",
          "categoryCode": "0102"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category13.jpg?updatedAt=1691720649936",
          "categoryName": "国际大牌",
          "categoryCode": "0103"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category14.jpg?updatedAt=1691720649824",
          "categoryName": "羽绒馆",
          "categoryCode": "0104"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category15.jpg?updatedAt=1691720649489",
          "categoryName": "咱爸衣橱",
          "categoryCode": "0105"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category11.jpg?updatedAt=1691720650082",
          "categoryName": "私人定制",
          "categoryCode": "0106"
        }
      ]
    },
    {
      "categoryName": "御寒外套",
      "categoryCode": "02",
      "cateList": [
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category21.jpg?updatedAt=1691720855070",
          "categoryName": "轻薄羽绒服",
          "categoryCode": "0201"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category22.jpg?updatedAt=1691720855230",
          "categoryName": "极寒羽绒服",
          "categoryCode": "0202"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category23.jpg?updatedAt=1691720855097",
          "categoryName": "工装羽绒服",
          "categoryCode": "0203"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category24.jpg?updatedAt=1691720855169",
          "categoryName": "亮面羽绒服",
          "categoryCode": "0204"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category25.jpg?updatedAt=1691720855178",
          "categoryName": "潮流棉服",
          "categoryCode": "0205"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category26.jpg?updatedAt=1691720855095",
          "categoryName": "双面昵大衣",
          "categoryCode": "0206"
        }
      ]
    },
    {
      "categoryName": "裤装",
      "categoryCode": "03",
      "cateList": [
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category31.jpg?updatedAt=1691721330822",
          "categoryName": "休闲卫裤",
          "categoryCode": "0301"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category32.jpg?updatedAt=1691721330919",
          "categoryName": "束脚裤",
          "categoryCode": "0302"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category33.jpg?updatedAt=1691721330841",
          "categoryName": "西裤",
          "categoryCode": "0303"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category34.jpg?updatedAt=1691721330911",
          "categoryName": "加绒裤",
          "categoryCode": "0304"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category35.jpg?updatedAt=1691721330967",
          "categoryName": "直筒裤",
          "categoryCode": "0305"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category36.jpg?updatedAt=1691721330825",
          "categoryName": "锥形裤",
          "categoryCode": "0306"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category37.jpg?updatedAt=1691721330890",
          "categoryName": "复古牛仔裤",
          "categoryCode": "0307"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category38.jpg?updatedAt=1691721330918",
          "categoryName": "休闲牛仔裤",
          "categoryCode": "0308"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category39.jpg?updatedAt=1691721330821",
          "categoryName": "直筒牛仔裤",
          "categoryCode": "0309"
        }
      ]
    },
    {
      "categoryName": "童装",
      "categoryCode": "04",
      "cateList": [
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category41.jpg?updatedAt=1691721668386",
          "categoryName": "童装馆",
          "categoryCode": "0401"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category42.jpg?updatedAt=1691721668438",
          "categoryName": "自选精选",
          "categoryCode": "0402"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category43.jpg?updatedAt=1691721668510",
          "categoryName": "萌宝婴童",
          "categoryCode": "0403"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category44.jpg?updatedAt=1691721668766",
          "categoryName": "羽绒服",
          "categoryCode": "0404"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category45.jpg?updatedAt=1691721669060",
          "categoryName": "外套大衣",
          "categoryCode": "0405"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category46.jpg?updatedAt=1691721668301",
          "categoryName": "棉服",
          "categoryCode": "0406"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category47.jpg?updatedAt=1691721668354",
          "categoryName": "套装",
          "categoryCode": "0407"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category48.jpg?updatedAt=1691721668950",
          "categoryName": "裤子",
          "categoryCode": "0408"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category49.jpg?updatedAt=1691721668542",
          "categoryName": "卫衣",
          "categoryCode": "0409"
        }
      ]
    },
    {
      "categoryName": "上衣",
      "categoryCode": "05",
      "cateList": [
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category51.jpg?updatedAt=1691721975919",
          "categoryName": "LOGO卫衣",
          "categoryCode": "0501"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category52.jpg?updatedAt=1691721976162",
          "categoryName": "男女同款卫衣",
          "categoryCode": "0502"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category53.jpg?updatedAt=1691721976071",
          "categoryName": "宽松卫衣",
          "categoryCode": "0503"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category54.jpg?updatedAt=1691721976241",
          "categoryName": "格纹衬衫",
          "categoryCode": "0504"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category55.jpg?updatedAt=1691721976286",
          "categoryName": "纯色衬衫",
          "categoryCode": "0505"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category56.jpg?updatedAt=1691721976386",
          "categoryName": "法兰绒衬衫",
          "categoryCode": "0506"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category57.jpg?updatedAt=1691721976145",
          "categoryName": "套头针织衫",
          "categoryCode": "0507"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category58.jpg?updatedAt=1691721976279",
          "categoryName": "针织开衫",
          "categoryCode": "0508"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category59.jpg?updatedAt=1691721976350",
          "categoryName": "羊毛衫",
          "categoryCode": "0509"
        }
      ]
    },
    {
      "categoryName": "夹克",
      "categoryCode": "06",
      "cateList": [
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category61.jpg?updatedAt=1691722256832",
          "categoryName": "棒球服",
          "categoryCode": "0601"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category62.jpg?updatedAt=1691722257151",
          "categoryName": "羊羔绒",
          "categoryCode": "0602"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category63.jpg?updatedAt=1691722256847",
          "categoryName": "牛仔夹克",
          "categoryCode": "0603"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category64.jpg?updatedAt=1691722256979",
          "categoryName": "工装夹克",
          "categoryCode": "0604"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category65.jpg?updatedAt=1691722257105",
          "categoryName": "飞行夹克",
          "categoryCode": "0605"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category66.jpg?updatedAt=1691722257115",
          "categoryName": "刺绣夹克",
          "categoryCode": "0606"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category67.jpg?updatedAt=1691722256966",
          "categoryName": "棒球服",
          "categoryCode": "0607"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category68.jpg?updatedAt=1691722257022",
          "categoryName": "羊羔绒",
          "categoryCode": "0608"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category69.jpg?updatedAt=1691722257053",
          "categoryName": "牛仔夹克",
          "categoryCode": "0609"
        }
      ]
    },
    {
      "categoryName": "潮流单品",
      "categoryCode": "07",
      "cateList": [
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category71.jpg?updatedAt=1691722522496",
          "categoryName": "军事风夹克",
          "categoryCode": "0701"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category72.jpg?updatedAt=1691722522483",
          "categoryName": "鬼脸卫衣",
          "categoryCode": "0702"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category73.jpg?updatedAt=1691722522642",
          "categoryName": "vibe风长裤",
          "categoryCode": "0703"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category74.jpg?updatedAt=1691722522578",
          "categoryName": "涂鸦卫衣",
          "categoryCode": "0704"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category75.jpg?updatedAt=1691722522700",
          "categoryName": "大码卫衣",
          "categoryCode": "0705"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category76.jpg?updatedAt=1691722522792",
          "categoryName": "pu皮羽绒服",
          "categoryCode": "0706"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category77.jpg?updatedAt=1691722522829",
          "categoryName": "军事风夹克",
          "categoryCode": "0707"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category78.jpg?updatedAt=1691722522745",
          "categoryName": "鬼脸卫衣",
          "categoryCode": "0708"
        },
        {
          "iconUrl": "https://ik.imagekit.io/guoguodad/mall/category/category79.jpg?updatedAt=1691722522806",
          "categoryName": "vibe风长裤",
          "categoryCode": "0709"
        }
      ]
    }
  ]

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
}