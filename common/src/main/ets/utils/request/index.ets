import axios, { AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import { AppUtil, LogUtil, ToastUtil } from '@pura/harmony-utils'
import { BaseResponse } from './types'

const instance = axios.create({
  timeout: 30000, // 30秒超时
  headers: {
    'Content-Type': 'application/json;charset=UTF-8',
    'Accept': 'application/json'
  }
});

instance.defaults.headers.post['Access-Control-Allow-Origin'] = '*';
instance.defaults.headers.post['Access-Control-Allow-Credentials'] = 'true';

instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  const token = ''
  if (token && config.headers) {
    config.headers['Authorization'] = `Bearer ${token}`
  }
  if (config.headers) {
    config.headers['Platform'] = 'harmony'
  }

  return config
},
  (error: ESObject) => {
    return Promise.reject(error)
  }
)

instance.interceptors.response.use((response: AxiosResponse) => {

  if (AppUtil.getAppProvisionType() == "debug" || AppUtil.debug()) {
    LogUtil.info([
      `--------- [axios] req url: ${response.config.url}`,
      `--------- [axios] req method: ${response.config.method}`,
      `--------- [axios] req data:${response.config.data}`,
      `--------- [axios] res data:`, response.data
    ])
  }

  // 业务成功处理
  if (isSuccess(response.data.code)) {
    return response.data
  }

  // 业务错误处理
  handleBusinessError(response.data.code, response.data.msg)
  return Promise.reject(response.data)
},
  (error: ESObject) => {
    if (error.code) {
      handleNetworkError(error.code)
    }
    if (error.response?.status) {
      handleHttpError(error.response.status)
    }
    return Promise.reject(error)
  }
)

// 错误处理函数
function handleBusinessError(code: number, message: string): void {
  switch (code) {
    case 401:
      // token过期，清除并跳转到登录页
      // router.push('/login'); // 需要根据实际路由实现
      break;
    case 403:
      // 权限不足
      console.error('权限不足:', message);
      break;
    default:
      console.error('业务错误:', message);
    ToastUtil.showShort(message)
  }
}

function handleNetworkError(code: string): void {
  const errorMap: Record<string, string> = {
    'ECONNABORTED': '请求超时，请检查网络连接',
    'ERR_NETWORK': '网络错误，请检查网络设置',
    'ERR_CANCEL': '请求已取消'
  };

  const message = errorMap[code] || `网络错误: ${code}`
  LogUtil.error('--------- [axios] network error:',message)
}

function handleHttpError(status: number): void {
  const errorMap: Record<number, string> = {
    400: '请求参数错误',
    401: '未授权，请重新登录',
    403: '拒绝访问',
    404: '请求资源不存在',
    500: '服务器内部错误',
    502: '网关错误',
    503: '服务不可用',
    504: '网关超时'
  };

  const message = errorMap[status] || `HTTP错误: ${status}`;
  LogUtil.error('--------- [axios] http error:',message)

  if (status === 401) {
    // 跳转到登录页
  }
}

function isSuccess(code: string | number): boolean {
  return ['0', 0, '200', 200].includes(code);
}

class RequestUtil {
  static get<T = ESObject>(url: string, config?: AxiosRequestConfig): Promise<BaseResponse<T>> {
    return instance.get<T, BaseResponse<T>>(url, config).then((res) => res);
  }

  static post<T = ESObject>(url: string, data?: ESObject, config?: AxiosRequestConfig): Promise<BaseResponse<T>> {
    return instance.post<T, BaseResponse<T>>(url, data, config).then(res => res);
  }

  static put<T = ESObject>(url: string, data?: ESObject, config?: AxiosRequestConfig): Promise<BaseResponse<T>> {
    return instance.put<T, BaseResponse<T>>(url, data, config).then(res => res);
  }

  static delete<T = ESObject>(url: string, config?: AxiosRequestConfig): Promise<BaseResponse<T>> {
    return instance.delete<T, BaseResponse<T>>(url, config).then(res => res)
  }
}

export { RequestUtil, isSuccess }