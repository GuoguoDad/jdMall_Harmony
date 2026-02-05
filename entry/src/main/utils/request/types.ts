export interface BaseResponse<T = any> {
  code: number
  message: string
  data: T
  success: boolean
  timestamp?: number
}

export interface PageResponse<T = any> {
  list: T[]
  total: number
  page: number
  pageSize: number
  totalPages: number
}

export interface PageParams {
  page?: number
  pageSize?: number
  [key: string]: any
}

export interface ErrorResponse {
  code: number
  message: string
  path?: string
  timestamp?: number
}