// 1.导入axios （多baseURL封装方式）
import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import { promptAction } from '@kit.ArkUI'
import { Log } from '@abner/log'

// 2.创建axios实例对象
const instance = axios.create({
  baseURL: 'https://zhyl-harmony.itheima.net',
  timeout: 5000,
})

// 3.创建请求拦截器
instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  Log.info('1.请求参数', JSON.stringify(config))
  return config
}, (err: AxiosError) => {
  return Promise.reject(err)
})

// 4.创建响应拦截器
instance.interceptors.response.use((response: AxiosResponse) => {
  // 响应成功
  if (response.data.code === 200) {
    Log.info('2.响应结果：', response.data.data)
    return response.data.data
  }

  // token过期
  if (response.data.code === 401) {

    // TODO : token过期处理  (跳转到登录页 / 无感刷新)
    promptAction.showToast({
      message: '登陆超时'
    })
    Log.error(JSON.stringify(response.data.msg))
  }

  // 提示
  AlertDialog.show({
    message: response.data.msg
  })
}, (err: AxiosError) => {
  // 打印错误信息
  AlertDialog.show({
    message: err.message
  })

  Log.error('3.异常信息', JSON.stringify(err))
  return Promise.reject(err)
})

// 5.导出创建自定义请求
export class Http {
  static get<T>(url: string, params?: object) {
    return instance.get<null, T>(url, { params })
  }

  static post<T>(url: string, data?: object) {
    return instance.post<null, T>(url, data)
  }

  static put<T>(url: string, data?: object) {
    return instance.put<null, T>(url, data)
  }

  static delete<T>(url: string, data?: object) {
    return instance.delete<null, T>(url, data)
  }
}
