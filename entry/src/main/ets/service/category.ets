import { isSuccess, RequestUtil, EnvConfig } from "@ohos/common"
import { ToastUtil } from '@pura/harmony-utils'






export interface CategoryInfo {
  name: string
  code: string
}

export interface SecondCategoryInfo {
  categoryName: string
  categoryCode: string
  cateList: ThirdCategoryInfo[]
}

export interface ThirdCategoryInfo {
  iconUrl: string
  categoryName: string
  categoryCode: string
}