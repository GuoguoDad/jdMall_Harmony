import { StyleConstants } from "../constants/StyleConstants"

@Component
export struct LoadMoreFooter {
  @Prop isLoading: boolean = false
  @Prop hasNextPage: boolean = false
  @Prop safeBottom: number = 0

  build() {
    Row() {
      if (this.isLoading) {
        LoadingProgress()
          .height(28)
        Text(`加载中`)
          .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
          .fontColor(Color.Grey)
          .margin({left: 5})
      } else if (!this.isLoading && !this.hasNextPage) {
        Text(`到底啦...`)
          .fontSize(StyleConstants.FONT_SIZE_FOURTEEN)
          .fontColor(Color.Grey)
      }
    }
    .height(58 + this.safeBottom)
    .width(StyleConstants.FULL_WIDTH)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .padding({bottom: this.safeBottom})
  }
}