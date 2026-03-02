import { isSuccess, RequestUtil, EnvConfig } from "@ohos/common"
import { ToastUtil } from '@pura/harmony-utils'

export const queryGoodsDetailInfo = async(goodsId: string) => {
  const res = await RequestUtil.post<GoodsDetailInfo>(`${EnvConfig.baseUrl}/detail/queryGoodsDetail`, { goodsId })
  if (isSuccess(res.code) && res.msg) {
    ToastUtil.showToast(res.msg)
  }
  return res.data
}


export interface GoodsDetailInfo {
  bannerList?: BannerInfo[]
  goodsInfo?: GoodsInfo
  detailInfo?: DetailInfo
}

export interface BannerInfo {
  colorId?: string
  colorName?: string
  thumb?: string
  imgList?: string[]
}

export interface AppraiseInfo {
  appraiseId: string
  headerUrl: string
  userName: string
  content: string
  type: number
  color: string
  size: string
  imgList: string[]
}

export interface GoodsInfo {
  originalPrice?: string
  specialPrice?: string
  tagList?: string[]
  goodsName?: string
  appraiseList?: AppraiseInfo[]
}

export interface DetailInfo {
  hdzq?: string
  dnyx?: string
  introductionList?: string[]
  serviceList?: string[]
}
