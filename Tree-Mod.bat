@echo off
title Tree Mod Whith Colors and Folder Sizes
:Settings
rem Set the following variable to enabled to set the color of the tree and the folders everytime you start the script. (If you just press ENTER, the colors will be randomized)
set "ChooseColor=disabled" & rem replace disabled with enabled
rem Set the following variable to enabled to set the start folder every time you start this script. (If you just press ENTER, the path will not be changed.)
set "ChoosePath=disabled" & rem replace disabled with enabled
rem Set the following variable to enabled if you want the names of the Folders and the size to be displayed in the same color
set "SameColorForSizeAndFolder=disabled" & rem replace disabled with enabled
rem Set the following variable to enabled if you want to have different colors for the tree and folders
set "SameColorForTreeAndFolders=disabled" & rem replace disabled with enabled
rem Set the following variable to enabled if you want to disable the color white for random colors
set "DisableColorWhiteForRandomColors=disabled" & rem replace disabled with enabled
rem Set the following variable to enabled if you want to choose how big the size of a folder has to be to display its subfolders. This script will always show the main folder and at least one subfolder
set "DisableLowSizes=disabled" & rem replace disabled with enabled
set "reachedend=                                                                                                                                                                     "
setlocal enableDelayedExpansion
FOR /F %%A in ('ECHO prompt $E^| cmd') DO SET "ESC=%%A"
rem If the script crashes at the end or it doesn't diplay a white line and you do not have Windows 10, delete the following line:
set "reachedend=%reachedend%%ESC%[K"
:MainScript
set "shownext=y"
if not "%ChoosePath%"=="enabled" goto MaxSize
echo Path:
set /p _path=
if not defined _path set _path=%cd%
cls
cd /d "!_path!"
:MaxSize
if not "%DisableLowSizes%"=="enabled" goto SetColors
cls
echo Folder size which is required to show a folders subfolders (^<value^> ^<unit: B/KB/MB/GB/TB^>, e.g. "100 MB"):
set /p LowestFolderSize=
set lownum=0
for %%z in (%LowestFolderSize%) do (
set /a lownum+=1
set low[!lownum!]=%%z
)
if not defined low[1] (set "DisableLowSizes=disabled" & goto SetColors)
if not defined low[2] (set "DisableLowSizes=disabled" & goto SetColors)
if defined low[3] (
for %%z in (%LowestFolderSize%) do (
set /a lownum+=1
set "low[!lownum!]=%%z"
)
echo Only enter a value and a unit!
timeout /t 2 /nobreak >nul
goto MaxSize
)
if %low[1]% geq 1000 (
if not "%low[2]%"=="TB" (
echo The value has to be smaller than 1000!
timeout /t 2 /nobreak >nul
goto MaxSize
)
)
if /i "%low[2]%"=="B" set "low[2]=1"
if /i "%low[2]%"=="KB" set "low[2]=2"
if /i "%low[2]%"=="MB" set "low[2]=3"
if /i "%low[2]%"=="GB" set "low[2]=4"
if /i "%low[2]%"=="TB" set "low[2]=5"
for %%z in (1,2,3,4,5) do (if "%low[2]%"=="%%z" set "low2def=y")
if not defined low2def (
echo Wrong unit!
timeout /t 2 /nobreak >nul
goto MaxSize
)
cls
title Path: %cd%; Size limit: %low[1]% %low[2]%
:SetColors
if "%SameColorForSizeAndFolder%"=="enabled" set "_namesizecolor=y"
title %cd%
Set _fRed=%ESC%[31m
Set _fGreen=%ESC%[32m
Set _fYellow=%ESC%[33m
Set _fBlue=%ESC%[34m
Set _fMag=%ESC%[35m
Set _fCyan=%ESC%[36m
Set _fLGray=%ESC%[37m
Set _fDGray=%ESC%[90m
Set _fBRed=%ESC%[91m
Set _fBGreen=%ESC%[92m
Set _fBYellow=%ESC%[93m
Set _fBBlue=%ESC%[94m
Set _fBMag=%ESC%[95m
Set _fBCyan=%ESC%[96m
Set _fBWhite=%ESC%[97m
Set _bBWhite=%ESC%[107m
Set _bRed=%ESC%[41m
Set _RESET=%ESC%[0m
if not "%ChooseColor%"=="enabled" goto RandomColors
echo Select the color of the tree:
echo %_RESET%1. %_fRed%Red
echo %_RESET%2. %_fBRed%Red
echo %_RESET%3. %_fGreen%Green
echo %_RESET%4. %_fBGreen%Green
echo %_RESET%5. %_fYellow%Yellow
echo %_RESET%6. %_fBYellow%Yellow
echo %_RESET%7. %_fBlue%Blue
echo %_RESET%8. %_fBBlue%Blue
echo %_RESET%9. %_fMag%Mag
echo %_RESET%10. %_fBMag%Mag
echo %_RESET%11. %_fCyan%Cyan
echo %_RESET%12. %_fBCyan%Cyan
echo %_RESET%13. %_fBWhite%White
echo %_RESET%14. %_fLGray%Gray
echo %_RESET%15. %_fDGray%Gray%_RESET%
set /p colorchoice=
cls
if "%colorchoice%"=="1" set tcolor=_fRed
if "%colorchoice%"=="2" set tcolor=_fBRed
if "%colorchoice%"=="3" set tcolor=_fGreen
if "%colorchoice%"=="4" set tcolor=_fBGreen
if "%colorchoice%"=="5" set tcolor=_fYellow
if "%colorchoice%"=="6" set tcolor=_fBYellow
if "%colorchoice%"=="7" set tcolor=_fBlue
if "%colorchoice%"=="8" set tcolor=_fBBlue
if "%colorchoice%"=="9" set tcolor=_fMag
if "%colorchoice%"=="10" set tcolor=_fBMag
if "%colorchoice%"=="11" set tcolor=_fCyan
if "%colorchoice%"=="12" set tcolor=_fBCyan
if "%colorchoice%"=="13" set tcolor=_fBWhite
if "%colorchoice%"=="14" set tcolor=_fLGray
if "%colorchoice%"=="15" set tcolor=_fDGray
if not defined tcolor goto RandomColors
if "%_namesizecolor%"=="y" goto nextaftersetcolor
echo %_RESET%Tree color: !%tcolor%!ÄÄÄÄÄ
echo %_RESET%Select the color of folders:
echo %_RESET%1. %_fRed%Red
echo %_RESET%2. %_fBRed%Red
echo %_RESET%3. %_fGreen%Green
echo %_RESET%4. %_fBGreen%Green
echo %_RESET%5. %_fYellow%Yellow
echo %_RESET%6. %_fBYellow%Yellow
echo %_RESET%7. %_fBlue%Blue
echo %_RESET%8. %_fBBlue%Blue
echo %_RESET%9. %_fMag%Mag
echo %_RESET%10. %_fBMag%Mag
echo %_RESET%11. %_fCyan%Cyan
echo %_RESET%12. %_fBCyan%Cyan
echo %_RESET%13. %_fBWhite%White
echo %_RESET%14. %_fLGray%Gray
echo %_RESET%15. %_fDGray%Gray%_RESET%
set /p colorchoice=
cls
if "%colorchoice%"=="1" set fcolor=_fRed
if "%colorchoice%"=="2" set fcolor=_fBRed
if "%colorchoice%"=="3" set fcolor=_fGreen
if "%colorchoice%"=="4" set fcolor=_fBGreen
if "%colorchoice%"=="5" set fcolor=_fYellow
if "%colorchoice%"=="6" set fcolor=_fBYellow
if "%colorchoice%"=="7" set fcolor=_fBlue
if "%colorchoice%"=="8" set fcolor=_fBBlue
if "%colorchoice%"=="9" set fcolor=_fMag
if "%colorchoice%"=="10" set fcolor=_fBMag
if "%colorchoice%"=="11" set fcolor=_fCyan
if "%colorchoice%"=="12" set fcolor=_fBCyan
if "%colorchoice%"=="13" set fcolor=_fBWhite
if "%colorchoice%"=="14" set fcolor=_fLGray
if "%colorchoice%"=="15" set fcolor=_fDGray
if not defined fcolor goto RandomColors
goto StartTree
:RandomColors
set "fcolor="
set "tcolor="
:SetGround
if "%ground%"=="f" (set ground=t) else (set ground=f)
:LoopColorSelector
set _Alphanumeric=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
set _Str=%_Alphanumeric%987654321
set _Len=0
:_LenLoop
if not "%_Str:~18%"=="" set _Str=%_Str:~9%& set /a _Len+=9& goto :_LenLoop
set _tmp=%_Str:~9,1%
set /a _Len+=_tmp
set _RND=%Random%
set /a _RND=_RND%%%_Len%
set _RND=!_Alphanumeric:~%_RND%,1!
if not defined _RND goto _LenLoop
if /i "%_RND%"=="b" set %ground%color=_fRed
if /i "%_RND%"=="c" set %ground%color=_fGreen
if /i "%_RND%"=="d" set %ground%color=_fYellow
if /i "%_RND%"=="e" set %ground%color=_fBlue
if /i "%_RND%"=="f" set %ground%color=_fMag
if /i "%_RND%"=="g" set %ground%color=_fCyan
if /i "%_RND%"=="h" set %ground%color=_fLGray
if /i "%_RND%"=="i" set %ground%color=_fDGray
if /i "%_RND%"=="j" set %ground%color=_fBRed
if /i "%_RND%"=="k" set %ground%color=_fBGreen
if /i "%_RND%"=="l" set %ground%color=_fBYellow
if /i "%_RND%"=="m" set %ground%color=_fBBlue
if /i "%_RND%"=="n" set %ground%color=_fBMag
if /i "%_RND%"=="o" set %ground%color=_fBCyan
if /i "%_RND%"=="p" set %ground%color=_fBWhite
if "%_RND%"=="r" set %ground%color=_fRed
if "%_RND%"=="s" set %ground%color=_fGreen
if "%_RND%"=="t" set %ground%color=_fYellow
if "%_RND%"=="u" set %ground%color=_fBlue
if "%_RND%"=="w" set %ground%color=_fMag
if "%_RND%"=="v" set %ground%color=_fCyan
if "%_RND%"=="x" set %ground%color=_fLGray
if "%_RND%"=="Q" set %ground%color=_fDGray
if "%_RND%"=="R" set %ground%color=_fBRed
if "%_RND%"=="S" set %ground%color=_fBGreen
if "%_RND%"=="T" set %ground%color=_fBYellow
if "%_RND%"=="U" set %ground%color=_fBBlue
if "%_RND%"=="V" set %ground%color=_fBMag
if "%_RND%"=="W" set %ground%color=_fBCyan
if "%_RND%"=="X" set %ground%color=_fBWhite
if not defined %ground%color goto LoopColorSelector
if "%ground%"=="f" goto SetGround

if not "%SameColorForTreeAndFolders%"=="enabled" (if "!fcolor!"=="%tcolor%" goto SetGround)
if "%DisableColorWhiteForRandomColors%"=="disabled" goto StartTree
if "!fcolor!"=="_fBWhite" goto SetGround
if "%tcolor%"=="_fBWhite" goto SetGround
:StartTree
set "fcolor=!%fcolor%!"
:nextaftersetcolor
set "tcolor=!%tcolor%!"
call :FolderSize
echo %maincol%%cd% !scolor!!size!
for /d %%a in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[a]=%%z"
set /a counter[a]=!counter[a]!+1
if "!counter[a]!"=="!count[a]!" (
set counter[a]=0
set "t[a]= "
set "kl=À"
) else (
set "t[a]=³"
set "kl=Ã"
)
cd "%%a" 2>nul
if !errorlevel!==0 (
set cd[a]=y
) else (
set cd[a]=n
)
call :FolderSize
echo %tcolor%!kl!ÄÄÄ!fcolor!%%a !scolor!!size!
if !cd[a]!==y (
if "!shownext!"=="y" (
for /d %%b in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[b]=%%z"
set /a counter[b]=!counter[b]!+1
if "!counter[b]!"=="!count[b]!" (
set counter[b]=0
set "t[b]= "
set "kl=À"
) else (
set "t[b]=³"
set "kl=Ã"
)
cd "%%b" 2>nul
if !errorlevel!==0 (
set cd[b]=y
) else (
set cd[b]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !kl!ÄÄÄ!fcolor!%%b !scolor!!size!
if !cd[b]!==y (
if "!shownext!"=="y" (
for /d %%c in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[c]=%%z"
set /a counter[c]=!counter[c]!+1
if "!counter[c]!"=="!count[c]!" (
set counter[c]=0
set "t[c]= "
set "kl=À"
) else (
set "t[c]=³"
set "kl=Ã"
)
cd "%%c" 2>nul
if !errorlevel!==0 (
set cd[c]=y
) else (
set cd[c]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !kl!ÄÄÄ!fcolor!%%c !scolor!!size!
if !cd[c]!==y (
if "!shownext!"=="y" (
for /d %%d in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[d]=%%z"
set /a counter[d]=!counter[d]!+1
if "!counter[d]!"=="!count[d]!" (
set counter[d]=0
set "t[d]= "
set "kl=À"
) else (
set "t[d]=³"
set "kl=Ã"
)
cd "%%d" 2>nul
if !errorlevel!==0 (
set cd[d]=y
) else (
set cd[d]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !kl!ÄÄÄ!fcolor!%%d !scolor!!size!
if !cd[d]!==y (
if "!shownext!"=="y" (
for /d %%e in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[e]=%%z"
set /a counter[e]=!counter[e]!+1
if "!counter[e]!"=="!count[e]!" (
set counter[e]=0
set "t[e]= "
set "kl=À"
) else (
set "t[e]=³"
set "kl=Ã"
)
cd "%%e" 2>nul
if !errorlevel!==0 (
set cd[e]=y
) else (
set cd[e]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !kl!ÄÄÄ!fcolor!%%e !scolor!!size!
if !cd[e]!==y (
if "!shownext!"=="y" (
for /d %%f in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[f]=%%z"
set /a counter[f]=!counter[f]!+1
if "!counter[f]!"=="!count[f]!" (
set counter[f]=0
set "t[f]= "
set "kl=À"
) else (
set "t[f]=³"
set "kl=Ã"
)
cd "%%f" 2>nul
if !errorlevel!==0 (
set cd[f]=y
) else (
set cd[f]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !kl!ÄÄÄ!fcolor!%%f !scolor!!size!
if !cd[f]!==y (
if "!shownext!"=="y" (
for /d %%g in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[g]=%%z"
set /a counter[g]=!counter[g]!+1
if "!counter[g]!"=="!count[g]!" (
set counter[g]=0
set "t[g]= "
set "kl=À"
) else (
set "t[g]=³"
set "kl=Ã"
)
cd "%%g" 2>nul
if !errorlevel!==0 (
set cd[g]=y
) else (
set cd[g]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !kl!ÄÄÄ!fcolor!%%g !scolor!!size!
if !cd[g]!==y (
if "!shownext!"=="y" (
for /d %%h in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[h]=%%z"
set /a counter[h]=!counter[h]!+1
if "!counter[h]!"=="!count[h]!" (
set counter[h]=0
set "t[h]= "
set "kl=À"
) else (
set "t[h]=³"
set "kl=Ã"
)
cd "%%h" 2>nul
if !errorlevel!==0 (
set cd[h]=y
) else (
set cd[h]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !kl!ÄÄÄ!fcolor!%%h !scolor!!size!
if !cd[h]!==y (
if "!shownext!"=="y" (
for /d %%i in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[i]=%%z"
set /a counter[i]=!counter[i]!+1
if "!counter[i]!"=="!count[i]!" (
set counter[i]=0
set "t[i]= "
set "kl=À"
) else (
set "t[i]=³"
set "kl=Ã"
)
cd "%%i" 2>nul
if !errorlevel!==0 (
set cd[i]=y
) else (
set cd[i]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !kl!ÄÄÄ!fcolor!%%i !scolor!!size!
if !cd[i]!==y (
if "!shownext!"=="y" (
for /d %%j in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[j]=%%z"
set /a counter[j]=!counter[j]!+1
if "!counter[j]!"=="!count[j]!" (
set counter[j]=0
set "t[j]= "
set "kl=À"
) else (
set "t[j]=³"
set "kl=Ã"
)
cd "%%j" 2>nul
if !errorlevel!==0 (
set cd[j]=y
) else (
set cd[j]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !kl!ÄÄÄ!fcolor!%%j !scolor!!size!
if !cd[j]!==y (
if "!shownext!"=="y" (
for /d %%k in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[k]=%%z"
set /a counter[k]=!counter[k]!+1
if "!counter[k]!"=="!count[k]!" (
set counter[k]=0
set "t[k]= "
set "kl=À"
) else (
set "t[k]=³"
set "kl=Ã"
)
cd "%%k" 2>nul
if !errorlevel!==0 (
set cd[k]=y
) else (
set cd[k]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !kl!ÄÄÄ!fcolor!%%k !scolor!!size!
if !cd[k]!==y (
if "!shownext!"=="y" (
for /d %%l in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[l]=%%z"
set /a counter[l]=!counter[l]!+1
if "!counter[l]!"=="!count[l]!" (
set counter[l]=0
set "t[l]= "
set "kl=À"
) else (
set "t[l]=³"
set "kl=Ã"
)
cd "%%l" 2>nul
if !errorlevel!==0 (
set cd[l]=y
) else (
set cd[l]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !kl!ÄÄÄ!fcolor!%%l !scolor!!size!
if !cd[l]!==y (
if "!shownext!"=="y" (
for /d %%m in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[m]=%%z"
set /a counter[m]=!counter[m]!+1
if "!counter[m]!"=="!count[m]!" (
set counter[m]=0
set "t[m]= "
set "kl=À"
) else (
set "t[m]=³"
set "kl=Ã"
)
cd "%%m" 2>nul
if !errorlevel!==0 (
set cd[m]=y
) else (
set cd[m]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !kl!ÄÄÄ!fcolor!%%m !scolor!!size!
if !cd[m]!==y (
if "!shownext!"=="y" (
for /d %%n in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[n]=%%z"
set /a counter[n]=!counter[n]!+1
if "!counter[n]!"=="!count[n]!" (
set counter[n]=0
set "t[n]= "
set "kl=À"
) else (
set "t[n]=³"
set "kl=Ã"
)
cd "%%n" 2>nul
if !errorlevel!==0 (
set cd[n]=y
) else (
set cd[n]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !t[m]!   !kl!ÄÄÄ!fcolor!%%n !scolor!!size!
if !cd[n]!==y (
if "!shownext!"=="y" (
for /d %%o in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[o]=%%z"
set /a counter[o]=!counter[o]!+1
if "!counter[o]!"=="!count[o]!" (
set counter[o]=0
set "t[o]= "
set "kl=À"
) else (
set "t[o]=³"
set "kl=Ã"
)
cd "%%o" 2>nul
if !errorlevel!==0 (
set cd[o]=y
) else (
set cd[o]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !t[m]!   !t[n]!   !kl!ÄÄÄ!fcolor!%%o !scolor!!size!
if !cd[o]!==y (
if "!shownext!"=="y" (
for /d %%p in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[p]=%%z"
set /a counter[p]=!counter[p]!+1
if "!counter[p]!"=="!count[p]!" (
set counter[p]=0
set "t[p]= "
set "kl=À"
) else (
set "t[p]=³"
set "kl=Ã"
)
cd "%%p" 2>nul
if !errorlevel!==0 (
set cd[p]=y
) else (
set cd[p]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !t[m]!   !t[n]!   !t[o]!   !kl!ÄÄÄ!fcolor!%%p !scolor!!size!
if !cd[p]!==y (
if "!shownext!"=="y" (
for /d %%q in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[q]=%%z"
set /a counter[q]=!counter[q]!+1
if "!counter[q]!"=="!count[q]!" (
set counter[q]=0
set "t[q]= "
set "kl=À"
) else (
set "t[q]=³"
set "kl=Ã"
)
cd "%%q" 2>nul
if !errorlevel!==0 (
set cd[q]=y
) else (
set cd[q]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !t[m]!   !t[n]!   !t[o]!   !t[p]!   !kl!ÄÄÄ!fcolor!%%q !scolor!!size!
if !cd[q]!==y (
if "!shownext!"=="y" (
for /d %%r in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[r]=%%z"
set /a counter[r]=!counter[r]!+1
if "!counter[r]!"=="!count[r]!" (
set counter[r]=0
set "t[r]= "
set "kl=À"
) else (
set "t[r]=³"
set "kl=Ã"
)
cd "%%r" 2>nul
if !errorlevel!==0 (
set cd[r]=y
) else (
set cd[r]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !t[m]!   !t[n]!   !t[o]!   !t[p]!   !t[q]!   !kl!ÄÄÄ!fcolor!%%r !scolor!!size!
if !cd[r]!==y (
if "!shownext!"=="y" (
for /d %%s in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[s]=%%z"
set /a counter[s]=!counter[s]!+1
if "!counter[s]!"=="!count[s]!" (
set counter[s]=0
set "t[s]= "
set "kl=À"
) else (
set "t[s]=³"
set "kl=Ã"
)
cd "%%s" 2>nul
if !errorlevel!==0 (
set cd[s]=y
) else (
set cd[s]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !t[m]!   !t[n]!   !t[o]!   !t[p]!   !t[q]!   !t[r]!   !kl!ÄÄÄ!fcolor!%%s !scolor!!size!
if !cd[s]!==y (
if "!shownext!"=="y" (
for /d %%t in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[t]=%%z"
set /a counter[t]=!counter[t]!+1
if "!counter[t]!"=="!count[t]!" (
set counter[t]=0
set "t[t]= "
set "kl=À"
) else (
set "t[t]=³"
set "kl=Ã"
)
cd "%%t" 2>nul
if !errorlevel!==0 (
set cd[t]=y
) else (
set cd[t]=n
)
call :FolderSize
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !t[m]!   !t[n]!   !t[o]!   !t[p]!   !t[q]!   !t[r]!   !t[s]!   !kl!ÄÄÄ!fcolor!%%t !scolor!!size!
if !cd[t]!==y (
if "!shownext!"=="y" (
for /d %%u in (*) do (
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[u]=%%z"
set /a counter[u]=!counter[u]!+1
if "!counter[u]!"=="!count[u]!" (
set counter[u]=0
set "t[u]= "
set "kl=À"
) else (
set "t[u]=³"
set "kl=Ã"
)
)
)
)
if !cd[t]!==y cd ..
)
)
)
if !cd[s]!==y cd ..
)
)
)
if !cd[r]!==y cd ..
)
)
)
if !cd[q]!==y cd ..
)
)
)
if !cd[p]!==y cd ..
)
)
)
if !cd[o]!==y cd ..
)
)
)
if !cd[n]!==y cd ..
)
)
)
if !cd[m]!==y cd ..
)
)
)
if !cd[l]!==y cd ..
)
)
)
if !cd[k]!==y cd ..
)
)
)
if !cd[j]!==y cd ..
)
)
)
if !cd[i]!==y cd ..
)
)
)
if !cd[h]!==y cd ..
)
)
)
if !cd[g]!==y cd ..
)
)
)
if !cd[f]!==y cd ..
)
)
)
if !cd[e]!==y cd ..
)
)
)
if !cd[d]!==y cd ..
)
)
)
if !cd[c]!==y cd ..
)
)
)
if !cd[b]!==y cd ..
)
)
)
if !cd[a]!==y cd ..
)
)
echo.
echo %_bBWhite%%reachedend%
echo %_RESET%
pause>nul
exit /b
:FolderSize
for /f "tokens=2-3 delims= " %%y in ('
robocopy "%CD%" "%TEMP%" /S /L /XJ /NFL /NDL /NJH /R:0 ^| findstr "Bytes"
') do ( 
set dim=%%z
set "dim=!dim:k=KB!" & set "dim=!dim:m=MB!" & set "dim=!dim:g=GB!" & set "dim=!dim:t=TB!"    
if !dim! EQU %%z set dim=B
set "size=%%y !dim!"
set "sizee=%%y"
)
if "!dim!"=="B" (set "scolor=%_fDGray%" & set "dimnum=1")
if "!dim!"=="KB" (set "scolor=%_fDGray%" & set "dimnum=2")
if "!dim!"=="MB" (set "scolor=%_fGreen%" & set "dimnum=3")
if "!dim!"=="GB" (set "scolor=%_fYellow%" & set "dimnum=4")
if "!dim!"=="TB" (set "scolor=%_fRed%" & set "dimnum=5")
if not "%DisableLowSizes%"=="enabled" goto FolderSizeNotEnabledNext
for /l %%z in (10,-1,1) do (if not "!sizee:.=!"=="!sizee!" set sizee=!sizee:~0,%%z!)
if !low[2]! gtr !dimnum! (
set "shownext=n"
) else (
if !low[1]! leq !sizee! (
set "shownext=y"
) else (
set "shownext=n"
)
)
:FolderSizeNotEnabledNext
if "%_namesizecolor%"=="y" (
set "fcolor=!scolor!"
set "maincol=!scolor!"
set "size=  %_RESET%^|^|^|   !scolor!%size%"
)
exit /b
