@echo off
echo "-------Begin-------"
git status
set /p msg=�������ύע��:
git add .
git commit -m %msg%
git pull
git push
echo ���ͳɹ�����%msg%��
echo "--------End!--------"
pause