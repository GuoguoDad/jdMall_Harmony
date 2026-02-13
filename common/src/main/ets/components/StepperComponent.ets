/**
 * 步进器组件：左边减号，中间数字输入框，右边加号
 * 支持手动输入、步长调整、范围限制，值变化时通过onChange回调通知父组件
 */
@Component
export struct StepperComponent {
  // ---------- 对外暴露的属性 ----------
  /** 初始值（仅在组件首次加载时生效） */
  initialValue?: number;
  /** 最小值，默认0 */
  min: number = 0;
  /** 最大值，默认100 */
  max: number = 9999;
  /** 步长，默认1 */
  step: number = 1;
  /** 数值变化回调 */
  onChange?: (value: number) => void;

  // ---------- 内部状态 ----------
  /** 当前实际数值 */
  @State private currentValue: number = 0;
  /** 输入框显示文本（与currentValue同步，但允许临时输入） */
  @State private inputText: string = '0';

  aboutToAppear() {
    // 初始化：使用initialValue，若无效则使用min，并钳位到[min, max]
    let init = this.initialValue ?? this.min;
    if (init < this.min) init = this.min;
    if (init > this.max) init = this.max;
    this.currentValue = init;
    this.inputText = init.toString();
  }

  /**
   * 验证输入框文本并更新数值
   * 在输入框失焦或按下回车时调用
   */
  private validateAndSet(): void {
    let parsed = parseInt(this.inputText);
    // 处理空字符串或非数字：恢复为最小值
    if (isNaN(parsed) || this.inputText.trim() === '') {
      parsed = this.min;
    }
    // 范围钳位
    if (parsed < this.min) parsed = this.min;
    if (parsed > this.max) parsed = this.max;
    // 如果数值发生变化，更新状态并触发回调
    if (parsed !== this.currentValue) {
      this.currentValue = parsed;
      this.onChange?.(parsed);
    }
    // 同步输入框显示（去掉前导零等）
    this.inputText = parsed.toString();
  }

  build() {
    Row() {
      // ---------- 减号按钮 ----------
      Button() {
        Text('-')
          .fontSize(16)
      }
      .width(30)
      .height(26)
      .border({width: {top: 1, left: 1, bottom: 1}, color: '#e0e0e0' })
      .enabled(this.currentValue > this.min)          // 达到最小值时禁用
      .backgroundColor(this.currentValue > this.min ? '#f2f2f2' : '#fafafa')
      .borderRadius({ topLeft: 8, bottomLeft: 8, topRight: 0, bottomRight: 0 })
      .onClick(() => {
        let newVal = this.currentValue - this.step;
        if (newVal < this.min) newVal = this.min;
        this.currentValue = newVal;
        this.inputText = newVal.toString();
        this.onChange?.(newVal);
      })

      // ---------- 中间数字输入框 ----------
      TextInput({ text: this.inputText, placeholder: this.min.toString() })
        .width(45)
        .height(26)
        .fontSize(14)
        .backgroundColor(Color.White)
        .border({ width: 1, color: '#e0e0e0' })
        .borderRadius(0)
        .type(InputType.Number)
        .padding(0)
        .textAlign(TextAlign.Center)
        .inputFilter('[0-9]*', (e) => {})
        .onChange((value: string) => {
          this.inputText = value;
        })
        .onBlur(() => {
          this.validateAndSet();
        })
        .onSubmit(() => {
          this.validateAndSet();
        })

      // ---------- 加号按钮 ----------
      Button() {
        Text('+')
          .fontSize(16)
      }
      .width(30)
      .height(26)
      .border({ width: {top: 1, right: 1, bottom: 1}, color: '#e0e0e0' })
      .enabled(this.currentValue < this.max)         // 达到最大值时禁用
      .backgroundColor(this.currentValue < this.max ? '#f2f2f2' : '#fafafa')
      .borderRadius({ topRight: 8, bottomRight: 8, topLeft: 0, bottomLeft: 0 })
      .onClick(() => {
        let newVal = this.currentValue + this.step;
        if (newVal > this.max) newVal = this.max;
        this.currentValue = newVal;
        this.inputText = newVal.toString();
        this.onChange?.(newVal);
      })
    }
    .justifyContent(FlexAlign.Center)
  }
}