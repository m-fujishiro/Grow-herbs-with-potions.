@rem echo off
setlocal enabledelayedexpansion

@title �|�[�V�����Ŗ򑐂���Ă�Q�[��

set �򑐂̎�=1&set ��=1&set �򑐂̉�=1&set �򑐂̎�=1&set �|�[�V����=1
@rem call :load

:main
echo �򑐂̎�=%�򑐂̎�% ��=%��% �򑐂̉�=%�򑐂̉�% �򑐂̎�=%�򑐂̎�% �|�[�V����=%�|�[�V����%
choice /c:dgsl /n /m ����:d,�琬:g,�ۑ�:s,����:l

if %errorlevel%==1 ( call :doze )
if %errorlevel%==2 ( call :grow )
if %errorlevel%==3 ( call :save )
if %errorlevel%==4 ( call :load )
pause

call :main

exit /b

:save
echo �򑐂̎�=%�򑐂̎�% > save.dat
echo ��=%��% >> save.dat
echo �򑐂̉�=%�򑐂̉�% >> save.dat
echo �򑐂̎�=%�򑐂̎�% >> save.dat
echo �|�[�V����=%�|�[�V����% >> save.dat
exit /b

:load
if exist save.dat for /f %%a in (save.dat) do (
  set %%a
)
exit /b

:doze
choice /c:gfb /n /m ������|�[�V���������܂����H(��:g,��:f,��:b)
if %errorlevel%==1 (set �I��=��& set ������=%��%)
if %errorlevel%==2 (set �I��=�򑐂̉�& set ������=%�򑐂̉�%)
if %errorlevel%==3 (set �I��=�򑐂̎�& set ������=%�򑐂̎�%)
choice /c:1234567890 /n /m ������͂��Ă��������B���Ȃ���%�I��%��%������%�����Ă��܂��B
if %errorlevel%==10 (
  echo �L�����Z������܂����B 
) else if %������% geq %errorlevel%(
  if %�I��%==�� (
    set /a �|�[�V����+=errorlevel/2
    set /a ��-=errorlevel
  ) else if %�I��%==�򑐂̉� (
    set /a �|�[�V����+=errorlevel
    set /a �򑐂̉�-=errorlevel
  ) else if %�I��%==�򑐂̎� (
    set /a �|�[�V����+=errorlevel*3/2
    set /a �򑐂̎�-=errorlevel
    set /a �򑐂̎�+=errorlevel*3
  )
) else(
  echo ������������܂���B
)
pause
exit /b

:grow
choice /c:1234567890 /n /m �|�[�V�����������g���܂����H������:%�|�[�V����%��
if %errorlevel%==10 (
  echo �L�����Z������܂����B 
) else if %�|�[�V����% geq %errorlevel%(
  set �g�p��=%errorlevel%
  echo �򑐂̎�=%�򑐂̎�% ��=%��% �򑐂̉�=%�򑐂̉�%
  choice /c:sgf /n /m ���Ƀ|�[�V�������g���܂����H(��:s,��:g,��:f)
  if %errorlevel%==1 (
    set /a ��+=%�g�p��%
    set /a �򑐂̎�-=%�g�p��%
  ) else if %errorlevel%==2 (
    set /a �򑐂̉�+=%�g�p��%
    set /a ��-=%�g�p��%
  ) else if %errorlevel%==2 (
    set /a �򑐂̎�+=%�g�p��%
    set /a �򑐂̉�-=%�g�p��%
  )
) else(
  echo ������������܂���B
)
pause
exit /b


