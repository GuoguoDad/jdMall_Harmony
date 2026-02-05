
@Component
export struct Category {
  private data: string[] = ['Header', 'Item1', 'Item2', 'Item3', 'Item4', 'Item5', 'Item6', 'Item7', 'Item8', 'Item9', 'Item10']

  build() {
    List({ space: 10 }) {
      ListItem() {
        Text('吸顶标题')
          .width('100%')
          .height(60)
          .backgroundColor(Color.White)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
      }
      .zIndex(1) // 确保在最上层

      // 其他列表项
      ForEach(this.data.slice(1), (item: string) => {
        ListItem() {
          Text(item)
            .width('100%')
            .height(100)
            .backgroundColor('#F5F5F5')
            .textAlign(TextAlign.Center)
            .borderRadius(10)
        }
      })
    }
    .sticky(StickyStyle.Header)
    .width('100%')
    .height('100%')
  }
}