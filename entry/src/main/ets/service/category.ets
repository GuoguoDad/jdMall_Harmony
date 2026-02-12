import { isSuccess, RequestUtil, EnvConfig } from "@ohos/common"
import { ToastUtil } from '@pura/harmony-utils'

export const queryCategoryList = async() => {
  const res = await RequestUtil.post<CategoryInfo[]>(`${EnvConfig.baseUrl}/category/list`)
  if(isSuccess(res.code) && res.msg) {
    ToastUtil.showToast(res.msg)
  }
  return res.data
}

export interface CategoryInfo {
  name: string
  code: string
}

export const queryGroupCategoryList = async(code: string) => {
  const res = await RequestUtil.post<GroupCategoryListInfo>(`${EnvConfig.baseUrl}/category/list`, { code })
  if(isSuccess(res.code) && res.msg) {
    ToastUtil.showToast(res.msg)
  }
  return res.data
}

interface GroupCategoryListInfo {
  bannerUrl: string;
  secondCateList: SecondCategoryInfo[];
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