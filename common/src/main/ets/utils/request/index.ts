import axios, { AxiosRequestConfig, AxiosResponse, FormData, InternalAxiosRequestConfig } from '@ohos/axios'
import { BaseResponse } from './types'

// 创建axios实例
const instance = axios.create({
  baseURL: 'https://your-api-domain.com/api', // 你的API地址
  timeout: 30000, // 30秒超时
  headers: {
    'Content-Type': 'application/json;charset=UTF-8',
    'Accept': 'application/json'
  }
})

instance.defaults.headers.post['Access-Control-Allow-Origin'] = '*'
instance.defaults.headers.post['Access-Control-Allow-Credentials'] = true

// 请求拦截器
instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
    const token = ''
    if (token && config.headers) {
      config.headers['Authorization'] = `Bearer ${token}`
    }

    // 添加设备信息
    if (config.headers) {
      config.headers['Platform'] = 'harmony'
    }

    // console.log(`axios [resquest] ${config.method?.toUpperCase()} ${config.url}`)
    return config;
  },
  (error: any) => {
    // console.log('=======axios error:', error)
    return Promise.reject(error)
  }
)

// 响应拦截器
instance.interceptors.response.use((response: AxiosResponse) => {
    const { data, config } = response

    // console.log(`axios [Response] ${config.method?.toUpperCase()} ${config.url}:`, JSON.stringify(data))

    // 业务成功处理
    if (isSuccess(data.code)) {
      return data
    }

    // 业务错误处理
    handleBusinessError(data.code, data.message)
    return Promise.reject(data)
  },
  (error: any) => {
    // console.log('=======axios error:', error)
    // 网络错误处理
    if (error.code) {
      handleNetworkError(error.code)
    }

    // HTTP状态码错误处理
    if (error.response?.status) {
      handleHttpError(error.response.status)
    }

    return Promise.reject(error)
  }
);

// 错误处理函数
function handleBusinessError(code: number, message: string) {
  switch (code) {
    case 401:
      // token过期，清除并跳转到登录页
      // router.push('/login'); // 需要根据实际路由实现
      break
    case 403:
      // 权限不足
      console.error('权限不足:', message)
      break
    default:
      console.error('业务错误:', message)
    // 可以在这里添加全局Toast提示
    // prompt.showToast({ message });
  }
}

function handleNetworkError(code: string) {
  const errorMap: Record<string, string> = {
    'ECONNABORTED': '请求超时，请检查网络连接',
    'ERR_NETWORK': '网络错误，请检查网络设置',
    'ERR_CANCEL': '请求已取消'
  };

  const message = errorMap[code] || `网络错误: ${code}`;
  console.error(message);
  // prompt.showToast({ message });
}

function handleHttpError(status: number) {
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

  const message = errorMap[status] || `HTTP错误: ${status}`
  console.error(message)

  if (status === 401) {
    // 跳转到登录页
  }
}

const isSuccess = (code: string) => ['0'].includes(code)

// 封装常用请求方法
class RequestUtil {
  // GET请求
  static get<T = any>(url: string, config?: AxiosRequestConfig) {
    return instance.get<BaseResponse<T>>(url, config).then(res => res as unknown as BaseResponse<T>)
  }

  // POST请求
  static post<T = any>(url: string, data?: any, config?: AxiosRequestConfig): Promise<BaseResponse<T>> {
    return instance.post(url, data, config).then(res => res as unknown as BaseResponse<T>)
  }

  // PUT请求
  static put<T = any>(url: string, data?: any, config?: AxiosRequestConfig) {
    return instance.put<BaseResponse<T>>(url, data, config).then(res => res as unknown as BaseResponse<T>)
  }

  // DELETE请求
  static delete<T = any>(url: string, config?: AxiosRequestConfig) {
    return instance.delete<BaseResponse<T>>(url, config).then(res => res as unknown as BaseResponse<T>)
  }

  // 文件上传
  static upload<T = any>(url: string, file: any, data?: any, config?: AxiosRequestConfig) {
    const formData = new FormData()
    formData.append('file', file)

    if (data) {
      Object.keys(data).forEach(key => {
        formData.append(key, data[key])
      })
    }

    return instance.post<BaseResponse<T>>(url, formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      },
      ...config
    }).then(res => res as unknown as BaseResponse<T>)
  }

  // 文件下载
  static download(url: string, config?: AxiosRequestConfig) {
    return instance.get(url, {
      responseType: 'array_buffer',
      ...config
    }).then(res => res)
  }

  static createCancelToken() {
    return new axios.CancelToken((cancel: any) => {
      // 可以在外部调用cancel('请求取消')
    })
  }
}

export { RequestUtil, isSuccess }
