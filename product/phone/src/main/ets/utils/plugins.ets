import { Log } from '@abner/log'
import dayjs from 'dayjs'
import 'dayjs/locale/zh-cn'

// 设置日期的语言为中文
dayjs.locale('zh-cn')

// 全局初始化日志打印配置
Log.init({
  tag: "YL",
  domain: 0x0000,
  close: false,
  isHilog: true,
  showLogLocation: true,
  logSize: 800
})
