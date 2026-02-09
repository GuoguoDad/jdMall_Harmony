import { LogUtil, ToastUtil } from '@pura/harmony-utils'
import { EnvConfig } from '../constants/EnvConstants'
import { sleep } from '../utils'
import { isSuccess, RequestUtil } from '../utils/request'
import { CommodityInfo } from '../viewmodel/CommodityModel'

export const queryGoodsListByPage = async(code: string, pageNo: number, pageSize: number) => {
  const res = await RequestUtil.post<GoodsPageInfo>(`${EnvConfig.baseUrl}/common/queryGoodsListByPage`, { code, pageNo, pageSize })
  if(isSuccess(res.code) && res.msg) {
    ToastUtil.showToast(res.msg)
  }
  await sleep(pageNo == 1 ? 0 : 2000)
  return res.data
}

export interface GoodsPageInfo {
  goodsList: CommodityInfo[]
  totalCount: number
  totalPageCount: number
}