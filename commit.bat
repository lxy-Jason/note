@echo off
echo "-------Begin-------"
git status

:: 获取当前日期时间
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do (
    set "month=%%a"
    set "day=%%b"
    set "year=%%c"
)
for /f "tokens=1-2 delims=: " %%a in ('time /t') do (
    set "hour=%%a"
    set "minute=%%b"
)

:: 设置默认提交注释为当前日期时间
set "msg=%year%%month%%day%_%hour%%minute%"

:: 提示用户输入提交注释
set /p msg=请输入提交注释（默认为当前日期时间）:

git add .
git commit -m "%msg%"
git pull
git push

echo 推送成功：【%msg%】
echo "--------End!--------"
pause
