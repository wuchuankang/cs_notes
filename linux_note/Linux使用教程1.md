### Linux使用教程1

1. 创建文件夹：mkdir + filename

2. 删除文件： rm + filename
  删除文件夹： rm -rf + filename  也可以：rm -r filename

  复制文件到当前文件夹下： cp 要移动文件路径  ./
  复制文件到某一文件夹下： cp 要移动的文件路径 目的地文件路径
  复制文件夹到当前文件夹下： cp -r 要移动的文件夹路径  ./

3. 移动操作：mv file1 file2

4. 重命名： 用7的操作可以实现

5. 安装软件： sudo apt-get install  packagename

6. 删除软件 ： sudo apt-get remove 软件名 

   如果还要将配置文档删除： sudo apt-get remove --purge packagename

7. pwd：显示当前路径

8. 压缩文件： tar -zvf file.tar.gz  要压缩文件夹/*
   解压文件： tar -xzvf filename.tar.gz （解压到当前路径）
   		   taa -xzvf filename.tar.gz -C 指定路径
   解压文件： unzip file.zip -d 指定路径  （-d参数必须）

9. 下载文件工具：wget [url地址]   ，wget是：world wide web 和 get的结合


注：
+ 参数 -r 是递归的首字母，是递归的完成，对于文件夹来说，不论删除还是复制，都要-r；

+ 这些复杂，移动的文件都可以在移动的时候同时进行命名，比如 cp file1 file2

+ apt是：advanced package tool 高级包管理工具的缩写