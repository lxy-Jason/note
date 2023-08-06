首先git上的都是LF,如果不是,应该是其他人上传了CRLF

git配置

```
# 提交时转换为LF，检出时不转换
git config --global core.autocrlf input

# 拒绝提交包含混合换行符的文件
git config --global core.safecrlf true
```

VScode配置

设置中搜索`files:eol`,改成`\n`

设置好之后,重写clone项目

