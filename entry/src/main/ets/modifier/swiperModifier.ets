import { CommonDotIndicator } from '@ohos/common'

export type IType = 'goodsTopSliderImg' | 'menuSlier' | 'ImgSlider'

export class CommonSwiperModifier implements AttributeModifier<SwiperAttribute> {
  public type: IType

  constructor(type: IType) {
    this.type = type
  }

  applyNormalAttribute(instance: SwiperAttribute): void {
    if(this.type == 'goodsTopSliderImg') {
      instance
        .cachedCount(2)
        .index(0)
        .autoPlay(false)
        .interval(6000)
        .loop(true)
        .duration(500)
        .itemSpace(0)
        .indicator(CommonDotIndicator(8, 8, 8, 8))
        .curve(Curve.Linear)
    } else if(this.type == 'ImgSlider') {
      instance
        .cachedCount(2)
        .index(0)
        .autoPlay(true)
        .interval(6000)
        .loop(true)
        .duration(500)
        .itemSpace(0)
        .indicator(CommonDotIndicator())
        .curve(Curve.Linear)
    } else if(this.type == 'menuSlier'){
      instance
        .index(0)
        .autoPlay(false)
        .loop(false)
        .itemSpace(0)
        .indicator(CommonDotIndicator())
        .curve(Curve.Linear)
    }
  }
}