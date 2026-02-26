import { appTasks } from '@ohos/hvigor-ohos-plugin';
import { routerRegisterPlugin, OptionalPluginConfig } from 'router-register-plugin'

const config: OptionalPluginConfig = {
  scanDirs: ['src/main/ets/pages'], // 扫描的目录，如果不设置，默认是扫描src/main/ets目录
  logEnabled: true, // 查看日志
  viewNodeInfo: false, // 查看节点信息
  ignoredModules:['common'], // 忽略的参与构建的模块
  enableUiPreviewBuild: false, // 启用UI预览构建，不建议启动
}

export default {
  system: appTasks, /* Built-in plugin of Hvigor. It cannot be modified. */
  plugins: [routerRegisterPlugin(config)]       /* Custom plugin to extend the functionality of Hvigor. */
}