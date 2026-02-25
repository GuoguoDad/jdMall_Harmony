import { isSuccess, RequestUtil, EnvConfig, sleep } from "@ohos/common"
import { ToastUtil } from '@pura/harmony-utils'

export const queryHomePageInfo = async() => {
  const res = await RequestUtil.post<HomePageInfo>(`${EnvConfig.baseUrl}/home/queryHomePageInfo`)
  if(isSuccess(res.code) && res.msg) {
    ToastUtil.showToast(res.msg)
  }
  await sleep(500)
  return res.data
}

export interface BannerInfo{
  imgUrl: string
  type: string
}

export interface NineMenuInfo {
  menuIcon: string
  menuName: string
  menuCode: string
  h5url: string
}

export interface TabInfo {
  name: string
  code: string
}

export interface HomePageInfo {
  bannerList: BannerInfo[]
  adUrl: string
  nineMenuList: NineMenuInfo[]
  tabList: TabInfo[]
}