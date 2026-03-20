import { ZRoute, ZRouter } from '@hzw/zrouter'
import { DialogHelper } from '@pura/harmony-dialog'
import { RouterConstants, StyleConstants } from '@ohos/common'
import { webview } from '@kit.ArkWeb'

export interface IWebViewParam {
  url: string
  title: string
}

@Entry
@ZRoute({ name:RouterConstants.common_webview, useTemplate: true })
@Component
export struct WebView {
  @StorageProp('safeTop') safeTop: number = 0
  @StorageProp('safeBottom') safeBottom: number = 0

  @State fullUrl: string = ''
  @State headerTitle: string = ''
  @State showHeader: boolean = true

  private headerHeight = 50 + this.safeTop
  private webController = new webview.WebviewController()
  private loadingDialog: string = ''

  build() {
    Column() {
      this.Header()
      Web({ src: this.fullUrl, controller: this.webController })
        .width(StyleConstants.FULL_WIDTH)
        .height(this.showHeader ? `calc(100% - ${this.headerHeight}vp)` : StyleConstants.FULL_HEIGHT)
        .javaScriptAccess(true)
        .domStorageAccess(true)
        .databaseAccess(true)
        .fileAccess(true)
        .imageAccess(true)
        .onlineImageAccess(true)
        .onControllerAttached(() => {
          this.loadUrl()
        })
        .onLoadStarted(()=>{
          // this.loadingDialog = DialogHelper.showLoadingDialog()
        })
        .onLoadFinished(()=>{
          // DialogHelper.closeDialog(this.loadingDialog)
        })
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
  }

  @Builder
  Header() {
    Row() {
      Row() {
        Image($r('app.media.ic_back_black'))
          .width(26)
          .height(26)
      }
      .width(100)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .padding({left: 10})
      .height(StyleConstants.FULL_HEIGHT)
      .onClick(() => ZRouter.getInstance().navigateBack())

      Text(this.headerTitle)
        .fontSize(StyleConstants.FONT_SIZE_EIGHTEEN)
        .fontColor(Color.Black)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Row(){}.width(100).height(StyleConstants.FULL_HEIGHT)
    }
    .width(StyleConstants.FULL_WIDTH)
    .backgroundColor(Color.White)
    .height(this.headerHeight)
    .padding({top: this.safeTop + 4})
    .visibility(this.showHeader ? Visibility.Visible : Visibility.None)
  }

  loadUrl() {
    const params: IWebViewParam = ZRouter.getInstance().getParam() as IWebViewParam
    this.headerTitle = params?.title || ''

    if(!params?.url) return

    const newUrl = `${params.url}${params?.url?.includes("?") ? '&' : '?'}statusBarHeight=${this.safeTop}&safeBottom=${this.safeBottom}`
    this.fullUrl = newUrl
    this.webController.loadUrl(newUrl)
  }
}