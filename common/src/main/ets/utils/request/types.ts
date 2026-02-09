export interface BaseResponse<T = any> {
  code: string
  msg: string
  data: T
}