@echo off
setlocal enabledelayedexpansion

@title �|�[�V�����Ŗ򑐂���Ă�Q�[��

set �򑐂̎�=1&set ��=1&set �򑐂̉�=1&set �򑐂̎�=1&set �|�[�V����=1&set �R�}���h��=0&set ��=100
call :load
call :save

:main
echo. & echo �򑐂̎�=%�򑐂̎�% ��=%��% �򑐂̉�=%�򑐂̉�% �򑐂̎�=%�򑐂̎�% �|�[�V����=%�|�[�V����% ��=%��%
choice /c:dgbsl /n /m ����:d,�琬:g,�w��:b,�ۑ�:s,����:l

if %errorlevel%==1 ( call :doze )
if %errorlevel%==2 ( call :grow )
if %errorlevel%==3 ( call :buy  )
if %errorlevel%==4 ( call :save )
if %errorlevel%==5 ( call :load )

if %�R�}���h��% geq 3 (
  call :grow_all
  set �R�}���h��=0
)

call :main

exit /b 0

:save
echo �򑐂̎�=%�򑐂̎�% > save.dat
echo ��=%��% >> save.dat
echo �򑐂̉�=%�򑐂̉�% >> save.dat
echo �򑐂̎�=%�򑐂̎�% >> save.dat
echo �|�[�V����=%�|�[�V����% >> save.dat
echo ��=%��% >> save.dat
exit /b 0

:load
if exist save.dat for /f %%a in (save.dat) do (
  set %%a
)
exit /b 0

:doze
choice /c:gfb /n /m ������|�[�V���������܂����H(��:g,��:f,��:b)

if %errorlevel%==1 (set �I��=��& set ������=%��%)
if %errorlevel%==2 (set �I��=�򑐂̉�& set ������=%�򑐂̉�%)
if %errorlevel%==3 (set �I��=�򑐂̎�& set ������=%�򑐂̎�%)

choice /c:1234567890 /n /m ������͂��Ă��������B���Ȃ���%�I��%��%������%�����Ă��܂��B

if %errorlevel%==10 (
  echo �L�����Z������܂����B 
  exit /b 0
)
if %������% lss %errorlevel% (
  echo ������������܂���B
  exit /b 0
)
if %�I��%==�� (
  set /a �|�[�V����+=%errorlevel%/2
  set /a ��-=%errorlevel%
) else if %�I��%==�򑐂̉� (
  set /a �|�[�V����+=%errorlevel%
  set /a �򑐂̉�-=%errorlevel%
) else if %�I��%==�򑐂̎� (
  set /a �|�[�V����+=%errorlevel%*3/2
  set /a �򑐂̎�-=%errorlevel%
  set /a �򑐂̎�+=%errorlevel%*3
)
set /a �R�}���h��+=1
exit /b 0

:grow
choice /c:1234567890 /n /m �|�[�V�����������g���܂����H������:%�|�[�V����%��
set �g�p��=%errorlevel%
if %�g�p��%==10 (
  echo �L�����Z������܂����B 
  exit /b 0
)
if %�|�[�V����% lss %�g�p��% (
  echo ������������܂���B
  exit /b 0
)
echo �򑐂̎�=%�򑐂̎�% ��=%��% �򑐂̉�=%�򑐂̉�%
choice /c:sgf /n /m ���Ƀ|�[�V�������g���܂����H(��:s,��:g,��:f)
if %errorlevel%==1 (
  set /a ��+=%�g�p��%
  set /a �򑐂̎�-=%�g�p��%
  echo �򑐂̎킪�򑐂ɐ������܂����B
) else if %errorlevel%==2 (
  set /a �򑐂̉�+=%�g�p��%
  set /a ��-=%�g�p��%
  echo �򑐂��򑐂̉Ԃɐ������܂����B
) else if %errorlevel%==3 (
  set /a �򑐂̎�+=%�g�p��%
  set /a �򑐂̉�-=%�g�p��%
  echo �򑐂̉Ԃ��򑐂̎��ɐ������܂����B
)
set /a �|�[�V����-=%�g�p��%
set /a �R�}���h��+=1
exit /b 0

:buy
@rem �|�[�V������100,����80,�Ԃ�50,�t��30,���10�Ŕ�����
@rem ����Ƃ��͔��z�ɂȂ��Ă��܂�
@rem �������蔃�����肷��ƂP�����߂���(�R�}���h��+3)
echo. & echo ��������Ⴂ�܂��B
:buy_again
echo. & echo �򑐂̎�=%�򑐂̎�% ��=%��% �򑐂̉�=%�򑐂̉�% �򑐂̎�=%�򑐂̎�% �|�[�V����=%�|�[�V����% ��=%��%
choice /c:sbf /n /m ���鎞��s���A�����Ƃ���b���A�I������Ƃ���f�������Ă��������B
if %errorlevel%==3 (goto end)

@rem ���p����
if %errorlevel%==1 (
choice /c:sgfbp /n /m ���𔄂�܂����H(��:s,��:g,��:f,��:b,�|�[�V����:p)
if %errorlevel%==1 (set �I��=�򑐂̎�&set ������=%�򑐂̎�%)
if %errorlevel%==2 (set �I��=��&set ������=%��%)
if %errorlevel%==3 (set �I��=�򑐂̉�&set ������=%�򑐂̉�%)
if %errorlevel%==4 (set �I��=�򑐂̎�&set ������=%�򑐂̎�%)
if %errorlevel%==5 (set �I��=�|�[�V����&set ������=%�|�[�V����%)
choice /c:1234567890 /n /m ������͂��Ă��������B���Ȃ���%�I��%��%������%�����Ă��܂��B

if %errorlevel%==10 (
  echo �L�����Z������܂����B
  goto goto_buy_again
)
if %������% lss %errorlevel% (
  echo ������������܂���B
  goto goto_buy_again
)

if %�I��%==�򑐂̎� (
  set /a ��+=%errorlevel%*5
  set /a �򑐂̎�-=%errorlevel%
)
if %�I��%==�� (
  set /a ��+=%errorlevel%*15
  set /a ��-=%errorlevel%
)
if %�I��%==�򑐂̉� (
  set /a ��+=%errorlevel%*25
  set /a �򑐂̉�-=%errorlevel%
)
if %�I��%==�򑐂̎� (
  set /a ��+=%errorlevel%*40
  set /a �򑐂̎�-=%errorlevel%
)
if %�I��%==�|�[�V���� (
  set /a ��+=%errorlevel%*50
  set /a �|�[�V����-=%errorlevel%
)
echo %�I��%��%errorlevel%���p���܂����B
goto goto_buy_again
)
@rem �w������
if %errorlevel%==2 (
echo �򑐂̎�:10s ��:30s �򑐂̉�:50s �򑐂̎�:80s �|�[�V����:100 (������:%��%)
choice /c:sgfbp /n /m ���𔃂��܂����H(��:s,��:g,��:f,��:b,�|�[�V����:p)
if %errorlevel%==1 (set �I��=�򑐂̎�)
if %errorlevel%==2 (set �I��=��)
if %errorlevel%==3 (set �I��=�򑐂̉�)
if %errorlevel%==4 (set �I��=�򑐂̎�)
if %errorlevel%==5 (set �I��=�|�[�V����)
choice /c:1234567890 /n /m %�I��%�������w�����܂����H(������:%��%s)
if %errorlevel%==10 (
  echo �L�����Z������܂����B
  goto goto_buy_again
)
@rem �I�𕨂ɂ���čw��������ς���
echo �������ł��B����A�b�v�f�[�g�����҂����������B
goto_buy_again
)
:goto_buy_again
echo ���ɂ�肽�����Ƃ͂���܂����H
goto buy_again

:end
set /a �R�}���h��+=3
echo �����p���肪�Ƃ��������܂����B
goto main

:grow_all
echo ������I���A���ׂĂ̐A�����������܂����B
set /a �򑐂̎�+=%�򑐂̉�%
set �򑐂̉�=%��%
set ��=%�򑐂̎�%
set �򑐂̎�=0
set /a ��-=100
if %��% lss 0 (
  echo ���Ȃ��͔j�Y���܂����B
  pause & exit
)
exit /b 0
