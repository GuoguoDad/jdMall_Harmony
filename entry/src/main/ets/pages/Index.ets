import { StyleConstants } from '@ohos/common'
import { WindowUtil } from '@pura/harmony-utils'
import { Home } from './home/home'
import { Category } from './category/category'
import { Cart } from './cart/cart'
import { Mine } from './mine/mine'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private controller = new TabsController()

  @StorageProp('safeTop') safeTop: number = 0
  @StorageProp('safeBottom') safeBottom: number = 0

  @Builder
  TabBuilder(title: string, targetIndex: number, icon: Resource, selectedIcon: Resource){
    Column(){
      Image(this.currentIndex == targetIndex ? selectedIcon : icon)
        .width(28)
        .height(28)
      Text(title)
        .fontSize(StyleConstants.FONT_SIZE_TWELVE)
        .margin({top:4})
        .fontColor(this.currentIndex == targetIndex ? $r('app.color.tab_active_color') : $r('app.color.tab_txt_color'))
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
      Tabs({barPosition:BarPosition.End, controller:this.controller, index: this.currentIndex}){
        TabContent(){
          Home()
        }.tabBar(this.TabBuilder('首页', 0, $r('app.media.ic_home'), $r('app.media.ic_home_active')))
        TabContent(){
          Category()
        }.tabBar(this.TabBuilder('分类', 1, $r('app.media.ic_category'), $r('app.media.ic_category_active')))
        TabContent(){
          Cart()
        }.tabBar(this.TabBuilder('购物车', 2, $r('app.media.ic_cart'), $r('app.media.ic_cart_active')))
        TabContent(){
          Mine()
        }.tabBar(this.TabBuilder('我的', 3, $r('app.media.ic_mine'), $r('app.media.ic_mine_active')))
      }
      .scrollable(false)
      .barHeight(50 + this.safeBottom)
      .barBackgroundColor(Color.White)
      .onChange((index: number) => {
        WindowUtil.setWindowSystemBarProperties({statusBarContentColor: [0, 1].includes(index) ? '#FFFFFF' : '#000000'})
      })
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
  }
}