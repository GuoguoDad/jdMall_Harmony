
export function CommonDotIndicator(width: number = 6, height: number = 6, activeWidth:number = 6, activeHeight:number = 6) {
  return new DotIndicator()
    .itemWidth(width)
    .itemHeight(height)
    .selectedItemWidth(activeWidth)
    .selectedItemHeight(activeHeight)
    .color($r('app.color.dot_color'))
    .selectedColor($r('app.color.dot_active_color'))
}