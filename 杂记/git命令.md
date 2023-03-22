### 拉取一个本地没有的远程分支

获取所有远程分支到本地

```
git fetch origin 
```

本地知道有哪些分支了可以通过这个命令创建本地新分支

```
git checkout -b <本地分支名>  origin/<远程分支名>
```

### 撤销提交

git reset是用来删除本地仓库中的提交，它有三种模式：soft，mixed和hard。

soft模式只会重置HEAD指针，不会改变暂存区和工作区的内容。

mixed模式会重置HEAD指针和暂存区，但不会改变工作区的内容。

hard模式会重置HEAD指针，暂存区和工作区，删除所有的修改

git revert是用来撤销某个提交的修改，它不会删除提交历史，而是创建一个新的提交来反转之前的修改。这样可以保持提交历史的完整性，并且可以推送到远程仓库

如果你想撤销最近两次的提交，你可以使用以下命令

```
# 使用git reset
git reset HEAD~2 # 默认为mixed模式
# 或者
git reset --soft HEAD~2 # 保留工作区和暂存区
# 或者
git reset --hard HEAD~2 # 删除工作区和暂存区

# 使用git revert
git revert HEAD~1..HEAD # 创建两个新的提交来撤销之前两次的修改
```

