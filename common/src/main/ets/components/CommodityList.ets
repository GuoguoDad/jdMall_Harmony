import { ImageKnifeComponent } from '@ohos/imageknife'
import { StyleConstants } from '../../../../Index'
import { WaterFlowDataSource } from '../utils/WaterFlowDataSource'
import { CommodityInfo } from '../viewmodel/CommodityModel'

@Component
export struct CommodityList {
  @Prop itemWidth: number = 0;

  private dataSource = new WaterFlowDataSource<CommodityInfo>([
    {
      "id": "goods01",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods1.jpg?updatedAt=1691718084842",
      "tag": "时尚运动",
      "des1": "活动惊爆价",
      "des2": "实惠好货等你抢",
      "type": "2",
      "h5url": "https://shop.m.jd.com/shop/home?shopId=17529"
    },
    {
      "id": "goods02",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods2.jpeg?updatedAt=1691718084893",
      "description": "帅电乔1男休闲运动篮球鞋倒钩TS 女鞋深棕鬼脸",
      "price": "799.00",
      "type": "1"
    },
    {
      "id": "goods03",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods3.jpg?updatedAt=1691718084932",
      "tag": "好物集市",
      "des1": "专业运动装备",
      "des2": "运动与你相伴",
      "type": "2",
      "h5url": "https://shop.m.jd.com/shop/home?shopId=17529"
    },
    {
      "id": "goods04",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods4.jpeg?updatedAt=1691718085548",
      "description": "ASICS 亚瑟士 男鞋运动鞋 GEL-VENTURE 7 MX 抓地缓冲越野跑鞋 黑色",
      "price": "590.00",
      "type": "1"
    },
    {
      "id": "goods05",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods5.jpeg?updatedAt=1691718214230",
      "description": "塞洛蒙（Salomon）男款 户外运动轻便舒适网布透气排水浅滩涉水溯溪鞋 AMPHIB BOLD",
      "price": "798.00",
      "type": "1"
    },
    {
      "id": "goods06",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods6.jpeg?updatedAt=1691718214230",
      "description": "蝴蝶乒乓球鞋 男比赛专业训练鞋防滑透气轻便耐磨鞋",
      "price": "268.60",
      "type": "1"
    },
    {
      "id": "goods07",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods7.webp?updatedAt=1691718214122",
      "description": "乔丹官方旗舰板鞋春新款网透气休闲运动鞋高帮轻便搭扣滑板鞋",
      "price": "205.10",
      "type": "1"
    },
    {
      "id": "goods08",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods4.jpeg?updatedAt=1691718085548",
      "description": "yysports 阿迪达斯adidas男鞋女鞋 三叶草 OZWE",
      "price": "809.00",
      "type": "1"
    },
    {
      "id": "goods09",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods9.jpg?updatedAt=1691718368682",
      "description": "帅电乔1男休闲运动篮球鞋倒钩TS 女鞋深棕鬼脸",
      "price": "799.00",
      "type": "1"
    },
    {
      "id": "goods10",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods10.jpg?updatedAt=1691718475914",
      "description": "ASICS 亚瑟士 男鞋运动鞋 GEL-VENTURE 7 MX 抓地缓冲越野跑鞋 黑色",
      "price": "590.00",
      "type": "1"
    },
    {
      "id": "goods11",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods11.jpg?updatedAt=1691718475860",
      "description": "帅电乔1男休闲运动篮球鞋倒钩TS 女鞋深棕鬼脸",
      "price": "799.00",
      "type": "1"
    },
    {
      "id": "goods12",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods12.jpg?updatedAt=1691718549427",
      "description": "ASICS 亚瑟士 男鞋运动鞋 GEL-VENTURE 7 MX 抓地缓冲越野跑鞋 黑色",
      "price": "590.00",
      "type": "1"
    },
    {
      "id": "goods12",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods11.jpg?updatedAt=1691718475860",
      "description": "ASICS亚瑟士 女鞋运动鞋稳定旗舰跑鞋耐磨 GE",
      "price": "1399.00",
      "type": "1"
    },
    {
      "id": "goods13",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods14.jpg?updatedAt=1691718615856",
      "description": "ASICS 亚瑟士 男鞋运动鞋 GEL-VENTURE 7 MX 抓地缓冲越野跑鞋 黑色",
      "price": "590.00",
      "type": "1"
    },
    {
      "id": "goods14",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods15.jpg?updatedAt=1691718711216",
      "description": "帅电乔1男休闲运动篮球鞋倒钩TS 女鞋深棕鬼脸",
      "price": "799.00",
      "type": "1"
    },
    {
      "id": "goods15",
      "imgUrl": "https://ik.imagekit.io/guoguodad/mall/common/goods10.jpg?updatedAt=1691718475914",
      "description": "ASICS 亚瑟士 休闲鞋低帮运动鞋舒适透气 COO",
      "price": "792.00",
      "type": "1"
    }
  ])

  @Builder
  GoodsItem(item: CommodityInfo) {
    Column() {
      ImageKnifeComponent({
        imageKnifeOption: {
          loadSrc: item.imgUrl,
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
        Row() {
          Text(item.tag).fontSize(StyleConstants.FONT_SIZE_FOURTEEN).fontColor(Color.White)
        }
        .borderRadius(18)
        .padding({left: 8, right: 8, top: 2, bottom: 2})
        .linearGradient({
          angle: 0,
          colors: [['#DD1A1E', 1.0],['#DD1A1E', 0.5], ['#DD1A1E', 0.1]]
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
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(8)
  }

  build() {
    WaterFlow() {
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
    .padding({left: 5, right: 5})
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.SELF_FIRST
    })
  }
}