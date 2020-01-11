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
    git remote add origin git@github.com:wuchuankang/repo | 加入远程仓库，并将该仓库取别命为origin
    git remote -v | 查看远程仓库有哪些，本地仓库可以假如多个远程仓库
    git push -u origin master | 将本地master分支上仓库区中的文件提交到名为origin的远程仓库里，-u 参数的作用是：如果本地仓库有多个远程仓库进行追踪，那么添加-u就是进行默认远程仓库的设置，默认远程仓库就是origin，这样以后直接用git push进行提交，就是提交到名字为origin的远程仓库中，所以也只是在初次时候设置  
    git push origin xx | xxx 可以是master，也可以是分支
    git pull | 将与本仓库默认连接的远程仓库中的文件拉下新的改动，并与本地仓库进行merge，它等于git fetch + get merge  
    git colne URL | 将url地址上的仓库git到本地，本地的远程仓局就是clone的仓库，可以通过git remote -v 来查看，修改完成之后，可以在git push，但是要输入远程仓库的用户名和密码来验证
    git branch | 查看分支，git init后，只会有主分支master  
    git branch x | 新建分支x
    git checkout x | 将工作区切换到分支x上
    git merge x | 工作区在`master`分支的情况下，将分支`x merge`到主分支上，否则merge到当前分区
    git branch -d x | 删除分支x
    git branch -D x | 强制删除分支x
    git log --oneline | 以简洁的方式查看git仓库中的历史版本
    git reflog | 同样给出了以简洁的方式给出版本信息，并且给出了 head 指向各版本所需要的步数
    git diff | 查看在临时存储区和在工作区中的同名文件的差别进行显示，不同点用绿色显示
    git remote rm origin | 删除与远程仓库的连接，如果远程仓库的本地名是其他的，那么替换origin就可以了，我尝试将origin换成远程仓库真实的名字，没有成功

-  回退到某一个版本
```cpp
git reset --hard xxx  // xxx 是索引号，就是版本标记哈希值，只要后面的几位就可以了，因为后面几位(3,4,5)已经可以来辨识出该版本；
git reset --hard HEAD^ // ^ 表示上一个版本，所以只能回退
git reset --hard HEAD^^ //  表示上一个版本的上一个版本
git reset --hard HEAD~3 //  ～n，表示回退到从当前版本开始的之前的第n个版本
```

- 仓库中永久删除(rm -rf)文件的找回
  这里说的是 `仓库` 中的文件，所以使用 `rm -rf` 之前，要将文件 `add -> commit` 到仓库中，否则无法恢复。其实恢复的原理很简单，就是回退到删除该文件之前的版本中即可，这也是要删除的文件必须是在仓库中的原因；

- 分支的作用
  分支的作用:主分支保留一个本体，在副本(分支)中进行修改， 一般可以直接在主分支上进行修改，但是当准备有过大的改动时，最好在分支上进行操作，这样即使分支上功能的添加不能够成功，也可以不对原来的主题有丝毫的影响，如果成功了，直接进行合并就可以了。这在多人开发的时候尤其重要，因为如果每个人都在主分支上进行修改，势必造成主分支的混乱，可以每一个开发者都建立自己的分支，在自己的分支上进行修改，然后提交到项目管理者，让他进行将分支 `merge` 到主分支上。

* .gitignore文件
    在使用git add . 的时候，会将所有在工作区的文件都提交到临时存储区，但是有些文件不必要提交，比如(假如有)本地的配置文件等，或者就是自己不想提交到github上的文件，想要忽略掉这些文件，git仓库提供了一个途径，就是在仓库中建立一个 .gitignore 文件，将不想add 的文件的名字都填进去，就可以了。有些时候，我们已经把文件提交到临时存储区，或者commit到仓库区，那么就是想将该文件不加入仓库，或者说是不追踪，直接在.gitignore加入该文件名是不够的，因为一旦add后，就会在临时存储区留下cache，以后还会追踪，必须将cache删除后，才可以：
    ```cpp
    git rm -f --cached xxx
    ```
    这里的删除仅仅是在临时存放区或者仓库区中一种逻辑删除，还是在这个文件中的。  

    **要注意的是，在.gitignore 添加忽略文件的时候，不能够将当前路径加入进去，比如和 .gitignore 同一级的文件 a.cpp 要忽略，在 .gitignore 中要写成 a.cpp， 不可写成 ./a.cpp**

- merge 冲突
  在要合并的两个分支中的相同文件的相同位置进行了不同的修改，在 `merge` 的时候不知道该如何合并，就是出现 `conflict` 。解决的方法就是将其中一个文件修改，然后在 `add -> commit` 到对应的分支上，然后再合并。  

* origin/master 和 master的关系  
    git clone 到本地的仓库，其远程仓库已经默认命名为origin(前面已经谈到了)，当我们在本地commit的时候，会出现"your branch is ahead of origin/master xx commit"，这里的origin/master就是远程仓库中的master分支，git clone url ，不加分支名，一般就是git 远程仓库中的master分支。
     
