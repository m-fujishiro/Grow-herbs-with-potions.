@echo off
setlocal enabledelayedexpansion

@title ポーションで薬草を育てるゲーム

set 薬草の種=1&set 薬草=1&set 薬草の花=1&set 薬草の実=1&set ポーション=1&set コマンド回数=0&set 金=100
call :load
call :save

:main
echo. & echo 薬草の種=%薬草の種% 薬草=%薬草% 薬草の花=%薬草の花% 薬草の実=%薬草の実% ポーション=%ポーション% 金=%金%
choice /c:dgbsl /n /m 調薬:d,育成:g,購入:b,保存:s,復元:l

if %errorlevel%==1 ( call :doze )
if %errorlevel%==2 ( call :grow )
if %errorlevel%==3 ( call :buy  )
if %errorlevel%==4 ( call :save )
if %errorlevel%==5 ( call :load )

if %コマンド回数% geq 3 (
  call :grow_all
  set コマンド回数=0
)

call :main

exit /b 0

:save
echo 薬草の種=%薬草の種% > save.dat
echo 薬草=%薬草% >> save.dat
echo 薬草の花=%薬草の花% >> save.dat
echo 薬草の実=%薬草の実% >> save.dat
echo ポーション=%ポーション% >> save.dat
echo 金=%金% >> save.dat
exit /b 0

:load
if exist save.dat for /f %%a in (save.dat) do (
  set %%a
)
exit /b 0

:doze
choice /c:gfb /n /m 何からポーションを作りますか？(草:g,花:f,実:b)

if %errorlevel%==1 (set 選択物=薬草& set 所持個数=%薬草%)
if %errorlevel%==2 (set 選択物=薬草の花& set 所持個数=%薬草の花%)
if %errorlevel%==3 (set 選択物=薬草の実& set 所持個数=%薬草の実%)

choice /c:1234567890 /n /m 個数を入力してください。あなたは%選択物%を%所持個数%個持っています。

if %errorlevel%==10 (
  echo キャンセルされました。 
  exit /b 0
)
if %所持個数% lss %errorlevel% (
  echo 所持数が足りません。
  exit /b 0
)
if %選択物%==薬草 (
  set /a ポーション+=%errorlevel%/2
  set /a 薬草-=%errorlevel%
) else if %選択物%==薬草の花 (
  set /a ポーション+=%errorlevel%
  set /a 薬草の花-=%errorlevel%
) else if %選択物%==薬草の実 (
  set /a ポーション+=%errorlevel%*3/2
  set /a 薬草の実-=%errorlevel%
  set /a 薬草の種+=%errorlevel%*3
)
set /a コマンド回数+=1
exit /b 0

:grow
choice /c:1234567890 /n /m ポーションをいくつ使いますか？所持数:%ポーション%個
set 使用個数=%errorlevel%
if %使用個数%==10 (
  echo キャンセルされました。 
  exit /b 0
)
if %ポーション% lss %使用個数% (
  echo 所持数が足りません。
  exit /b 0
)
echo 薬草の種=%薬草の種% 薬草=%薬草% 薬草の花=%薬草の花%
choice /c:sgf /n /m 何にポーションを使いますか？(種:s,草:g,花:f)
if %errorlevel%==1 (
  set /a 薬草+=%使用個数%
  set /a 薬草の種-=%使用個数%
  echo 薬草の種が薬草に成長しました。
) else if %errorlevel%==2 (
  set /a 薬草の花+=%使用個数%
  set /a 薬草-=%使用個数%
  echo 薬草が薬草の花に成長しました。
) else if %errorlevel%==3 (
  set /a 薬草の実+=%使用個数%
  set /a 薬草の花-=%使用個数%
  echo 薬草の花が薬草の実に成長しました。
)
set /a ポーション-=%使用個数%
set /a コマンド回数+=1
exit /b 0

:buy
@rem ポーションは100,実は80,花は50,葉は30,種は10で買える
@rem 売るときは半額になってしまう
@rem 売ったり買ったりすると１日が過ぎる(コマンド回数+3)
echo. & echo いらっしゃいませ。
:buy_again
echo. & echo 薬草の種=%薬草の種% 薬草=%薬草% 薬草の花=%薬草の花% 薬草の実=%薬草の実% ポーション=%ポーション% 金=%金%
choice /c:sbf /n /m 売る時はsを、買うときはbを、終了するときはfを押してください。
if %errorlevel%==3 (goto end)

@rem 売却処理
if %errorlevel%==1 (
choice /c:sgfbp /n /m 何を売りますか？(種:s,草:g,花:f,実:b,ポーション:p)
if %errorlevel%==1 (set 選択物=薬草の種&set 所持個数=%薬草の種%)
if %errorlevel%==2 (set 選択物=薬草&set 所持個数=%薬草%)
if %errorlevel%==3 (set 選択物=薬草の花&set 所持個数=%薬草の花%)
if %errorlevel%==4 (set 選択物=薬草の実&set 所持個数=%薬草の実%)
if %errorlevel%==5 (set 選択物=ポーション&set 所持個数=%ポーション%)
choice /c:1234567890 /n /m 個数を入力してください。あなたは%選択物%を%所持個数%個持っています。

if %errorlevel%==10 (
  echo キャンセルされました。
  goto goto_buy_again
)
if %所持個数% lss %errorlevel% (
  echo 所持数が足りません。
  goto goto_buy_again
)

if %選択物%==薬草の種 (
  set /a 金+=%errorlevel%*5
  set /a 薬草の種-=%errorlevel%
)
if %選択物%==薬草 (
  set /a 金+=%errorlevel%*15
  set /a 薬草-=%errorlevel%
)
if %選択物%==薬草の花 (
  set /a 金+=%errorlevel%*25
  set /a 薬草の花-=%errorlevel%
)
if %選択物%==薬草の実 (
  set /a 金+=%errorlevel%*40
  set /a 薬草の実-=%errorlevel%
)
if %選択物%==ポーション (
  set /a 金+=%errorlevel%*50
  set /a ポーション-=%errorlevel%
)
echo %選択物%を%errorlevel%個売却しました。
goto goto_buy_again
)
@rem 購入処理
if %errorlevel%==2 (
echo 薬草の種:10s 薬草:30s 薬草の花:50s 薬草の実:80s ポーション:100 (所持金:%金%)
choice /c:sgfbp /n /m 何を買いますか？(種:s,草:g,花:f,実:b,ポーション:p)
if %errorlevel%==1 (set 選択物=薬草の種)
if %errorlevel%==2 (set 選択物=薬草)
if %errorlevel%==3 (set 選択物=薬草の花)
if %errorlevel%==4 (set 選択物=薬草の実)
if %errorlevel%==5 (set 選択物=ポーション)
choice /c:1234567890 /n /m %選択物%をいくつ購入しますか？(所持金:%金%s)
if %errorlevel%==10 (
  echo キャンセルされました。
  goto goto_buy_again
)
@rem 選択物によって購入処理を変える
echo 未実装です。次回アップデートをお待ちください。
goto_buy_again
)
:goto_buy_again
echo 他にやりたいことはありますか？
goto buy_again

:end
set /a コマンド回数+=3
echo ご利用ありがとうございました。
goto main

:grow_all
echo 一日が終わり、すべての植物が成長しました。
set /a 薬草の実+=%薬草の花%
set 薬草の花=%薬草%
set 薬草=%薬草の種%
set 薬草の種=0
set /a 金-=100
if %金% lss 0 (
  echo あなたは破産しました。
  pause & exit
)
exit /b 0
