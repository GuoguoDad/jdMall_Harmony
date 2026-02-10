import { StyleConstants } from "../constants/StyleConstants"

@Component
export struct RefreshComponent {
  @Prop promptText: string = '下拉刷新'
  @Prop progressOffsetTop: number = 0

  build() {
    Stack() {
      Column() {
        LoadingProgress()
          .height(32)
        Text(this.promptText)
          .fontSize(StyleConstants.FONT_SIZE_TWELVE)
          .margin({ top: 2 })
          .fontColor(Color.Grey)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .align(Alignment.Center)
    .clip(true)
    .padding({top: this.progressOffsetTop, bottom: 5})
    .constraintSize({ minHeight: 54 + this.progressOffsetTop })
    .width(StyleConstants.FULL_WIDTH)
  }
}