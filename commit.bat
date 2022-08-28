@echo off
echo "-------Begin-------"
git status
set /p msg=请输入提交注释:
git add .
git commit -m %msg%
git pull
git push
echo 推送成功：【%msg%】
echo "--------End!--------"
pause