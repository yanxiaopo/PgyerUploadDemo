# PgyerUploadDemo
一键打包并上传蒲公英脚本

使用方法
./upload.sh -d "这里是更新说明"

没有更新说明默认取3条git log

参数说明
./upload.sh -h 
   -d 添加上传蒲公英是的版本描述
   -t release、test.
   -p 是否保存APK 只需调用即可 不需要传参数
   -u 是否是UAT包 只需调用即可 不需要传参数
   -i 控制是否输出打包日志 只需调用即可 不需要传参数
   -h 帮助
   -默认打Debug包

解决了windows平台上使用curl中文参数乱码问题
