@rem echo off
setlocal enabledelayedexpansion

@title ポーションで薬草を育てるゲーム

set 薬草の種=1&set 薬草=1&set 薬草の花=1&set 薬草の実=1&set ポーション=1
@rem call :load

:main
echo 薬草の種=%薬草の種% 薬草=%薬草% 薬草の花=%薬草の花% 薬草の実=%薬草の実% ポーション=%ポーション%
choice /c:dgsl /n /m 調薬:d,育成:g,保存:s,復元:l

if %errorlevel%==1 ( call :doze )
if %errorlevel%==2 ( call :grow )
if %errorlevel%==3 ( call :save )
if %errorlevel%==4 ( call :load )
pause

call :main

exit /b

:save
echo 薬草の種=%薬草の種% > save.dat
echo 薬草=%薬草% >> save.dat
echo 薬草の花=%薬草の花% >> save.dat
echo 薬草の実=%薬草の実% >> save.dat
echo ポーション=%ポーション% >> save.dat
exit /b

:load
if exist save.dat for /f %%a in (save.dat) do (
  set %%a
)
exit /b

:doze
choice /c:gfb /n /m 何からポーションを作りますか？(草:g,花:f,実:b)
if %errorlevel%==1 (set 選択物=薬草& set 所持個数=%薬草%)
if %errorlevel%==2 (set 選択物=薬草の花& set 所持個数=%薬草の花%)
if %errorlevel%==3 (set 選択物=薬草の実& set 所持個数=%薬草の実%)
choice /c:1234567890 /n /m 個数を入力してください。あなたは%選択物%を%所持個数%個持っています。
if %errorlevel%==10 (
  echo キャンセルされました。 
) else if %所持個数% geq %errorlevel%(
  if %選択物%==薬草 (
    set /a ポーション+=errorlevel/2
    set /a 薬草-=errorlevel
  ) else if %選択物%==薬草の花 (
    set /a ポーション+=errorlevel
    set /a 薬草の花-=errorlevel
  ) else if %選択物%==薬草の実 (
    set /a ポーション+=errorlevel*3/2
    set /a 薬草の実-=errorlevel
    set /a 薬草の種+=errorlevel*3
  )
) else(
  echo 所持数が足りません。
)
pause
exit /b

:grow
choice /c:1234567890 /n /m ポーションをいくつ使いますか？所持数:%ポーション%個
if %errorlevel%==10 (
  echo キャンセルされました。 
) else if %ポーション% geq %errorlevel%(
  set 使用個数=%errorlevel%
  echo 薬草の種=%薬草の種% 薬草=%薬草% 薬草の花=%薬草の花%
  choice /c:sgf /n /m 何にポーションを使いますか？(種:s,草:g,花:f)
  if %errorlevel%==1 (
    set /a 薬草+=%使用個数%
    set /a 薬草の種-=%使用個数%
  ) else if %errorlevel%==2 (
    set /a 薬草の花+=%使用個数%
    set /a 薬草-=%使用個数%
  ) else if %errorlevel%==2 (
    set /a 薬草の実+=%使用個数%
    set /a 薬草の花-=%使用個数%
  )
) else(
  echo 所持数が足りません。
)
pause
exit /b


