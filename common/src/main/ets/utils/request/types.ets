export interface BaseResponse<T> {
  code: string
  msg: string
  data: T
}