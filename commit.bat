@echo off
echo "-------Begin-------"
git status

:: ��ȡ��ǰ����ʱ��
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do (
    set "month=%%a"
    set "day=%%b"
    set "year=%%c"
)
for /f "tokens=1-2 delims=: " %%a in ('time /t') do (
    set "hour=%%a"
    set "minute=%%b"
)

:: ����Ĭ���ύע��Ϊ��ǰ����ʱ��
set "msg=%year%%month%%day%_%hour%%minute%"

:: ��ʾ�û������ύע��
set /p msg=�������ύע�ͣ�Ĭ��Ϊ��ǰ����ʱ�䣩:

git add .
git commit -m "%msg%"
git pull
git push

echo ���ͳɹ�����%msg%��
echo "--------End!--------"
pause
