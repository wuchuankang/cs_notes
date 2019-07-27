### 搭建shadowsocks

1. 先要购买vps(virtual private server)虚拟服务器；

2. ping 该服务器的地址，看是否该地址被墙；

3. 用ssh连接服务器：ssh root@服务器ip，比如当前就是 ssh root@155.138.147.226，意思是登录到服务器上，在服务器上身份是root用户。

   接下来要输入密码，填写服务器密码就行了，这个服务器密码就是服务器root用户的密码。

4. 初次登录需要在虚拟服务器（vps）上安装pip ss，用下面命令：
   sudo apt-get update  (先更新源)
   sudo apt-get install python
   sudo apt-get install python-pip
   sudo pip install shadowsocks

5. 在虚拟服务器上配置ss，
   mkdir ~/ss 
   cd ss
   vim shadowsocks.json
   配置文件内容：{
     "server": "0.0.0.0",  (不需要是服务器密码)
     "server_port": 12345,（可以自己设定，在本地ss客户端服务器端口填写该信息即可）
   “local_server": "127.0.0.1"（本地服务器）
     "local_port": 1080,
     "password": "your-password",(该密码不是服务器密码，而是自己随意设定的，在本地的ss客户端中的密码就是填写这个，这样可以链接，服务器密码是链接服务器用的)
     "timeout": 600,
     "method": "aes-256-cfb"
   }

6. 启动服务器：ssserver -c ~/ss/ss.json （读取配置文件启动）；

7. 在本地的网络设置中设置代理，在socks host行用手动设置（因为用的是socks5协议通信），将本地的服务器（就是自己电脑而已）的地址设置为上面配置文件中的ip：127.0.0.1，端口设置为1080。这样vps和本地server才能互通信息；

8. 设置ss客户端，对照着填写vps上服务器的ss填写即可，但是尤为重要的一点是，服务器ip不是填0.0.0.0，而是155.138.147.226（服务器的）
   然后就可以连接了

