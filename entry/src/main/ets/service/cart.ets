import { isSuccess, RequestUtil, EnvConfig } from "@ohos/common"
import { ToastUtil } from '@pura/harmony-utils'

export const queryCartGoodsList = async () => {
  const res = await RequestUtil.post<StoreGoodsInfo[]>(`${EnvConfig.baseUrl}/cart/queryCartGoodsList`)
  if (isSuccess(res.code) && res.msg) {
    ToastUtil.showToast(res.msg)
  }
  return res.data
}

export interface GoodsInfo {
  code: string
  imgUrl: string
  description: string
  price: string
  color: string
  size: string
  num: number
  select: boolean
}

export interface StoreGoodsInfo {
  storeName: string
  storeCode: string
  h5url: string
  select: boolean
  goodsList: GoodsInfo[]
}
