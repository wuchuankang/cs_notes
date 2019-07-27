 ## git基本使用教程
     学习新的知识，好的入门教程太有必要了  
     git是一个版本管理工具，可以使得本地的文件夹变成一个仓库便于文件的管理，还可以与github上的远程仓库进行连接，将本地仓库的文件托管到给github上，如果是代码，可以和别人分工协作，实现程序的共同开发。  
* 基本命令  
    命令 | 作用  
    ---- | -------
    git init | 将本地的文件初始化为仓库  
    git status | 查看当前仓库的状态，工作区(红色标识)和临时存储区的文件(绿色)
    git add . | 将所有工作区的文件加入到临时存储区  
    git add x | 将工作区的x文件加入到临时存储区  
    git commit -m "xxx" | 将临时存储区的文件加入到仓库区，xxx是对本次加入的说明
    git remote add origin git@github.com:wuchuankang/repo | 加入远程仓库，并命名为origin
    git remote -v | 查看远程仓库有哪些，本地仓库可以假如多个远程仓库
    git push -u origin master | 将本地master分支上仓库区中的文件提交到名为origin的远程仓库里，-u 参数的作用是：如果本地仓库有多个远程仓库进行追踪，那么添加-u就是进行默认远程仓库的设置，默认远程仓库就是origin，这样以后直接用git push进行提交，就是提交到名字为origin的远程仓库中，所以也只是在初次时候设置  
    git pull | 将与本仓库默认连接的远程仓库中的文件拉下新的改动，并与本地仓库进行merge，它等于git fetch + get merge  
    git colne URL | 将url地址上的仓库git到本地，本地的远程仓局就是clone的仓库，可以通过git remote -v 来查看，修改完成之后，可以在git push，但是要输入远程仓库的用户名和密码来验证
    git branch | 查看分支，git init后，只会有主分支master  
    git branch x | 新建分支x
    git checkout x | 将工作区切换到分支x上
    git merge x | 工作区在master分支的情况下，将分支x merge 到主分支上，否则merge到当前分区
    git diff | 查看在临时存储区和在工作区中的同名文件的差别进行显示，不同点用绿色显示
    
* .gitignore文件
    在使用git add . 的时候，会将所有在工作区的文件都提交到临时存储区，但是有些文件不必要提交，比如(假如有)本地的配置文件等，或者就是自己不想提交到github上的文件，想要忽略掉这些文件，git仓库提供了一个途径，就是在仓库中建立一个 .gitignore 文件，将不想add 的文件的名字都填进去，就可以了。有些时候，我们已经把文件提交到临时存储区，或者commit到仓库区，那么就是想将该文件不加入仓库，或者说是不追踪，直接在.gitignore假如该文件名是不够的，因为一旦add后，就会在临时存储区留下cache，以后还会追踪，必须将cache删除后，才可以：git rm -f --cached xxx,这里的删除仅仅是在临时存放区或者仓库区中一种逻辑删除，还是在这个文件中的。

* origin/master 和 master的关系  
    git clone 到本地的仓库，其远程仓库已经默认命名为origin(前面已经谈到了)，当我们在本地commit的时候，会出现"your branch is ahead of origin/master xx commit"，这里的origin/master就是远程仓库中的master分支，git clone url ，不加分支名，一般就是git 远程仓库中的master分支。
     
