
@Component
export struct FloatingBackTop {
  @Prop location: Position | Edges | LocalizedEdges = { x: '85%', y: '90%' }
  @Prop display: Visibility = Visibility.None

  onClickFun?: () => void

  constructor(onClickFun: () => void) {
    super()
    this.onClickFun = onClickFun
  }

  build() {
    Button() {
      Image($r('app.media.ic_back_top'))
        .width(24)
        .height(24)
    }
    .width(50)
    .height(50)
    .borderRadius(25)
    .backgroundColor(Color.White)
    .shadow({ radius: 8, color: Color.Gray, offsetX: 2, offsetY: 2 })
    .position(this.location)
    .visibility(this.display)
    .onClick(this.onClickFun)
  }
}