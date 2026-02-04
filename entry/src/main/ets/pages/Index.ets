@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  @StorageProp('safeTop') safeTop: number = 0;
  @StorageProp('safeBottom') safeBottom: number = 0;

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(30)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
        Button() {
          Text('下一页')
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

          router.pushUrl({ url: 'pages/second'})
        })
      }
      .width('100%')
      .backgroundColor(Color.Grey)
    }
    .height('100%')
    .alignItems(VerticalAlign.Bottom)
    .padding({bottom: this.safeBottom})
  }
}