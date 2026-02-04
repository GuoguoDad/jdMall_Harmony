import { Home } from "./home";

@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private controller = new TabsController()

  @StorageProp('safeTop') safeTop: number = 0
  @StorageProp('safeBottom') safeBottom: number = 0

  @Builder
  TabBuilder(title:string,targetIndex:number,normalImg:Resource,selectedImg:Resource){
    Column(){
      Image(this.currentIndex==targetIndex?selectedImg:normalImg)
        .width(28)
        .height(28)
      Text(title)
        .fontSize(12)
        .margin({top:4})
        .fontColor(this.currentIndex == targetIndex ? '#FC302D' : '#999999')
    }
    .width('100%')
    .height(50)
    .margin({bottom: 15})
    .onClick(()=>{
      this.currentIndex = targetIndex
      this.controller.changeIndex(this.currentIndex)
    })
  }

  build() {
    Column() {
      Tabs({barPosition:BarPosition.End, controller:this.controller, index:0}){
        TabContent(){
          Column().width('100%').height('100%').backgroundColor(Color.Gray)
        }.tabBar(this.TabBuilder('首页', 0, $r("app.media.ic_home"), $r("app.media.ic_home_active")))
        TabContent(){
          Column().width('100%').height('100%').backgroundColor(Color.Blue)
        }.tabBar(this.TabBuilder('分类', 2, $r("app.media.ic_category"), $r("app.media.ic_category_active")))
        TabContent(){
          Column().width('100%').height('100%').backgroundColor(Color.Yellow)
        }.tabBar(this.TabBuilder('购物车', 1, $r("app.media.ic_cart"), $r("app.media.ic_cart_active")))
        TabContent(){
          Column().width('100%').height('100%').backgroundColor(Color.Green)
        }.tabBar(this.TabBuilder('我的', 3, $r("app.media.ic_mine"), $r("app.media.ic_mine_active")))
      }
      .barHeight(50 + this.safeBottom)
      .barBackgroundColor(Color.White)
      .barOverlap(true)
      .animationDuration(0)
      .animationMode(AnimationMode.ACTION_FIRST)
    }
    .backgroundColor("#eeeeee")
    .width('100%')
    .height('100%')
  }
}