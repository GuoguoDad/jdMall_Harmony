# 前言
 高仿某东商城harmony版本，个人学习harmony项目

1. 鸿蒙官方状态管理
2. 网络使用@ohos/axios进行封装
3. 使用node项目mock服务端接口(mock_server目录)
4. 目前实现了首页、分类、购物车、我的

* ### 同款Android Kotlin版本（https://github.com/GuoguoDad/jd_mall）
* ### 同款Flutter版本（https://github.com/GuoguoDad/jd_mall_flutter）

# 鸿蒙简介
  鸿蒙系统（HarmonyOS）是华为公司自主研发的一款面向全场景的分布式操作系统。该系统基于微内核架构设计，其核心优势在于通过分布式软总线技术，打破单一设备局限，实现手机、平板、电脑、智能家居等多设备间的无缝协同和自由流转，为用户提供“万物互联”的智慧体验。纯血鸿蒙从底层内核到应用生态彻底摆脱对安卓的依赖，成为继苹果iOS和安卓之后的全球第三大移动操作系统。

# ArkTS
1. ArkTS是一种设计用于构建高性能应用的编程语言。它在继承TypeScript语法的基础上进行了优化，以提供更高的性能和开发效率。
2. TypeScript是在JavaScript基础上通过添加类型定义扩展而来的，ArkTS则是TypeScript的进一步扩展。
3. ArkTS的一大特性是它专注于低运行时开销(强类型语言)。
4. ArkTS提供与TypeScript和JavaScript的无缝互通。

# 开发环境
DevEco Studio 6.0.2 Release  
HarmonyOS 6.0.2  
mock_server nodejs: v18.20.6

# 关于运行
1. cd mock_server
2. npm i 安装依赖
3. npm run mock
4. 修改 common -> EnvConstants -> EnvConfig -> baseUrl 改为本机ip

# 效果

| 首页                                     | 分类                                        | 购物车                                   |
|-----------------------------------------|---------------------------------------------|-----------------------------------------|
| <img src="images/home.gif" width="200"> | <img src="images/category.gif" width="200"> | <img src="images/cart.gif" width="200"> | 


| 我的                                     | 
|-----------------------------------------|
| <img src="images/mine.gif" width="200"> | 


# 第三方框架

| 库                        | 功能         |
|--------------------------|------------|
| **@ohos/axios**          | **网络框架**   |
| **@pura/harmony-utils**  | **工具库**    |
| **@ohos/imageknife**     | **图片显示**   |
| **@pura/harmony-dialog** | **弹窗组件**   |

# 声明

⚠️本APP仅限于学习交流使用，请勿用于其它商业用途

⚠️项目中使用的图片及字体等资源如有侵权请联系作者删除

⚠️如使用本项目代码造成侵权与作者无关


