import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { AppUtil } from '@pura/harmony-utils'
import { DialogHelper, Orientation } from '@pura/harmony-dialog';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    AppUtil.init(this.context);
    this.setDialogHelperDefaultConfig()
    try {
      this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    } catch (err) {
      hilog.error(DOMAIN, 'testTag', 'Failed to set colorMode. Cause: %{public}s', JSON.stringify(err));
    }
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    const win = windowStage.getMainWindowSync();
    win.setWindowLayoutFullScreen(true)
    win.setWindowSystemBarProperties({ statusBarContentColor: '#FFFFFF' })

    // 获取顶部状态栏高度
    const topArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
    AppStorage.setOrCreate('safeTop', px2vp(topArea.topRect.height));
    // 获取底部导航条高度
    const bottomArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
    AppStorage.setOrCreate('safeBottom', px2vp(bottomArea.bottomRect.height));

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }


  setDialogHelperDefaultConfig() {
    DialogHelper.setDefaultConfig((config) => {
      config.uiAbilityContext = this.context;
    })

    DialogHelper.setDefaultConfig((config) => {
      config.uiAbilityContext = this.context  //必须初始化上下文
      config.autoCancel = true; //点击遮障层时，是否关闭弹窗，true表示关闭弹窗。false表示不关闭弹窗。默认值：true
      config.backCancel = true; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。true表示关闭弹窗。false表示不关闭弹窗。默认值：true。
      config.actionCancel = true; //点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。默认值：true。
      config.alignment = DialogAlignment.Center; //弹窗的对齐方式。
      config.offset = { dx: 0, dy: 0 }; //弹窗相对alignment所在位置的偏移量。默认值：{ dx: 0, dy: 0 }
      config.maskColor = 0x33000000; //自定义蒙层颜色。默认值 0x33000000
      config.backgroundColor = Color.White; //弹窗背板颜色。默认值：Color.White
      config.backgroundBlurStyle = BlurStyle.COMPONENT_ULTRA_THICK; //弹窗背板模糊材质。默认值：BlurStyle.COMPONENT_ULTRA_THICK
      config.cornerRadius = 20; //设置背板的圆角半径。可分别设置4个圆角的半径。

      config.title = '温馨提示'; //弹框标题
      config.primaryButton = '取消'; //弹框左侧按钮。
      config.secondaryButton = '确定'; //弹框右侧按钮。
      config.imageRes = undefined; //TipsDialog用到，展示的图片。
      config.imageSize = { width: '64vp', height: '64vp' }; //TipsDialog用到，自定义图片尺寸。默认值：64*64vp

      config.loading_loadSize = 60; //加载动画或进度条的大小
      config.loading_loadColor = Color.White; //加载动画或进度条的颜色
      config.loading_content = ''; //加载动画的提示文字
      config.loading_fontSize = 16; //文字大小
      config.loading_fontColor = Color.White; //文字颜色
      config.loading_backgroundColor = '#CC000000'; //背景颜色，八位色值前两位为透明度
      config.loading_borderRadius = 10; //背景圆角

      config.toast_duration = 2000; //显示时长(1500ms-10000ms)
      config.toast_durationLong = 10000; //显示时长(10000ms)
      config.toast_fontSize = 16; //文字大小
      config.toast_fontColor = Color.White; //文字颜色
      config.toast_backgroundColor = '#CC000000'; //背景颜色，建议八位色值前两位为透明度
      config.toast_borderRadius = 8; //背景圆角
      config.toast_padding = { left: 16, right: 16, top: 12, bottom: 12 }; //Padding
      config.toast_orientation = Orientation.VERTICAL; //吐司布局方向，默认垂直。设置该值时，请重新设置imageSize和margin。
      config.toast_imageSize = { width: 45, height: 45 }; //Tip图片尺寸。垂直默认值：45*45vp，水平建议值：24*24vp。
      config.toast_margin = 10; //吐司的图片与文字间距。
    })
  }
}