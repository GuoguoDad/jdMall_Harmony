@Entry
@Component
struct Second {
  @State message: string = 'HI';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(30)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
        Button() {
          Text('返回')
            .fontSize(28)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({top: 20})
        .backgroundColor('#0D9FFB')
        .width('40%')
        .height('5%')
        .onClick(()=> {
          let uiContent = this.getUIContext()
          let router = uiContent.getRouter()

          router.back()
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}