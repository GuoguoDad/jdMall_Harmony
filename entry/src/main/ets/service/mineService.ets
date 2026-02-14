import { isSuccess, RequestUtil, EnvConfig } from "@ohos/common"
import { ToastUtil } from '@pura/harmony-utils'

export const queryMinePageInfo = async() => {
  const res = await RequestUtil.post<MineInfo>(`${EnvConfig.baseUrl}/mine/queryMineInfo`)
  if(isSuccess(res.code) && res.msg) {
    ToastUtil.showToast(res.msg)
  }
  return res.data
}

export interface FunctionInfo {
  menuIcon: string
  menuName: string
  menuCode: string
  h5url: string
}

export interface TabInfo {
  name: string
  code: string
}

export interface MineInfo {
  functionList: FunctionInfo[]
  tabList: TabInfo[]
}