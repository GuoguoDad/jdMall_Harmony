# 前言
 高仿某东商城harmony版本，个人学习harmony项目

1. 网络使用dio进行封装
2. 使用node项目mock服务端接口(mock_server目录)
3. 目前实现了首页、分类、购物车、我的

# 开发环境
DevEco Studio 6.0.2 Release  
HarmonyOS 6.0.2  
mock_server nodejs: v18.20.6

# 启动mock_server
1. cd mock_server
2. 执行 npm i 安装依赖
3. npm run mock

# 效果

| 首页                                     | 分类                                        | 购物车                                   |
|-----------------------------------------|---------------------------------------------|-----------------------------------------|
| <img src="images/home.gif" width="200"> | <img src="images/category.gif" width="200"> | <img src="images/cart.gif" width="200"> | 


| 我的                                     | 商品详情 | 登录 |
|-----------------------------------------|------|----|
| <img src="images/mine.gif" width="200"> |      |    | 


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


