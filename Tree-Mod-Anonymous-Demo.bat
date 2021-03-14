@echo off
for %%z in (q w e r t z u i o p a s d f g h j k l y x c v b n m) do (set folder%%z=0)
setlocal enableDelayedExpansion
title Tree Mod Whith Colors and Folder Sizes
if not "%1"=="" goto SkipSettings
::set ChooseColor=%2
::set ChoosePath=%3
::set SameColorForSizeAndFolder=%4
::set SameColorForTreeAndFolders=%5
::set DisableColorWhiteForRandomColors=%6
::set DisableLowSizes=%7
::set DisableReachedEnd=%8
::set errortime=%9
:Settings
rem Set the following variable to enabled to set the color of the tree and the folders everytime you start the script. (If you just press ENTER, the colors will be randomized)
set "ChooseColor=disabled"
rem Set the following variable to enabled to set the start folder every time you start this script. (If you just press ENTER, the path will not be changed.)
set "ChoosePath=disabled"
rem Set the following variable to enabled if you want the names of the Folders and the size to be displayed in the same color
set "SameColorForSizeAndFolder=disabled"
rem Set the following variable to enabled if you want to have different colors for the tree and folders
set "SameColorForTreeAndFolders=disabled"
rem Set the following variable to enabled if you want to disable the color white for random colors
set "DisableColorWhiteForRandomColors=disabled"
rem Set the following variable to enabled if you want to choose how big the size of a folder has to be to display its subfolders. This script will always show the main folder and at least one subfolder
set "DisableLowSizes=disabled"
rem Set the following variable to enabled if the script crashes at the end or it doesn't diplay a white line and you do not have Windows 10
set "DisableReachedEnd=disabled"
rem Set the time in seconds, error messages are displayed:
set "errortime=2"
:SkipSettings
set "reachedend=                                                                                                                                                                     "
FOR /F %%A in ('ECHO prompt $E^| cmd') DO SET "ESC=%%A"
if "%DisableReachedEnd%"=="enabled" goto MainScript
set "reachedend=%reachedend%%ESC%[K"
:MainScript
set "shownext=y"
if not "%ChoosePath%"=="enabled" goto MaxSize
echo Path:
set /p _path=
if not defined _path set _path=%cd%
cls
cd /d "%_path%"
if not "%errorlevel%"=="0" (for /l %%z in (%errortime%,0,-1) do (echo The path "%_path%" could not be found. Make sure to spell it correctly.& title %%zs& timeout /t 1 /nobreak >nul)& title Tree Mod Whith Colors and Folder Sizes& set "_path="& goto MainScript)
:MaxSize
title Path: %cd%
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
for /l %%z in (%errortime%,0,-1) do (echo Only enter a value and a unit!& title %%zs& timeout /t 1 /nobreak >nul)
goto MaxSize
)
if %low[1]% geq 1000 (if not "%low[2]%"=="TB" (for /l %%z in (%errortime%,0,-1) do (echo The value has to be smaller than 1000!& title %%zs& timeout /t 1 /nobreak >nul)& goto MaxSize))
if /i "%low[2]%"=="B" set "low[2]=1"
if /i "%low[2]%"=="KB" set "low[2]=2"
if /i "%low[2]%"=="MB" set "low[2]=3"
if /i "%low[2]%"=="GB" set "low[2]=4"
if /i "%low[2]%"=="TB" set "low[2]=5"
for %%z in (1,2,3,4,5) do (if "%low[2]%"=="%%z" set "low2def=y")
if not defined low2def (for /l %%z in (%errortime%,0,-1) do (echo Wrong unit!& title %%zs& timeout /t 1 /nobreak >nul)& goto MaxSize)
title Path: %cd%; Size limit: %low[1]% %low[2]%
:SetColors
cls
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
call :CountFolders a
for /d %%a in (*) do (
cd "%%a" 2>nul
if !errorlevel!==0 (
set cd[a]=y
) else (
set cd[a]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[a]=!counter[a]!+1
if "!counter[a]!"=="!count[a]!" (
set "counter[a]="& set "count[a]="
set "t[a]= "
set "kl=À"
) else (
set "t[a]=³"
set "kl=Ã"
)
set /a foldera=!foldera!+1
echo %tcolor%!kl!ÄÄÄ!fcolor!Folder!foldera! !scolor!!size!
if !cd[a]!==y (
call :CountFolders b
for /d %%b in (*) do (
cd "%%b" 2>nul
if !errorlevel!==0 (
set cd[b]=y
) else (
set cd[b]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[b]=!counter[b]!+1
if "!counter[b]!"=="!count[b]!" (
set "counter[b]="& set "count[b]="
set "t[b]= "
set "kl=À"
) else (
set "t[b]=³"
set "kl=Ã"
)
set /a folderb=!folderb!+1
echo %tcolor%!t[a]!   !kl!ÄÄÄ!fcolor!Folder!foldera!.!folderb! !scolor!!size!
if !cd[b]!==y (
call :CountFolders c
for /d %%c in (*) do (
cd "%%c" 2>nul
if !errorlevel!==0 (
set cd[c]=y
) else (
set cd[c]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[c]=!counter[c]!+1
if "!counter[c]!"=="!count[c]!" (
set "counter[c]="& set "count[c]="
set "t[c]= "
set "kl=À"
) else (
set "t[c]=³"
set "kl=Ã"
)
set /a folderc=!folderc!+1
echo %tcolor%!t[a]!   !t[b]!   !kl!ÄÄÄ!fcolor!Folder!foldera!.!folderb!.!folderc! !scolor!!size!
if !cd[c]!==y (
call :CountFolders d
for /d %%d in (*) do (
cd "%%d" 2>nul
if !errorlevel!==0 (
set cd[d]=y
) else (
set cd[d]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[d]=!counter[d]!+1
if "!counter[d]!"=="!count[d]!" (
set "counter[d]="& set "count[d]="
set "t[d]= "
set "kl=À"
) else (
set "t[d]=³"
set "kl=Ã"
)
set /a folderd=!folderd!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !kl!ÄÄÄ!fcolor!Folder!foldera!.!folderb!.!folderc!.!folderd! !scolor!!size!
if !cd[d]!==y (
call :CountFolders e
for /d %%e in (*) do (
cd "%%e" 2>nul
if !errorlevel!==0 (
set cd[e]=y
) else (
set cd[e]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[e]=!counter[e]!+1
if "!counter[e]!"=="!count[e]!" (
set "counter[e]="& set "count[e]="
set "t[e]= "
set "kl=À"
) else (
set "t[e]=³"
set "kl=Ã"
)
set /a foldere=!foldere!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !kl!ÄÄÄ!fcolor!Folder!foldera!.!folderb!.!folderc!.!folderd!.!foldere! !scolor!!size!
if !cd[e]!==y (
call :CountFolders f
for /d %%f in (*) do (
cd "%%f" 2>nul
if !errorlevel!==0 (
set cd[f]=y
) else (
set cd[f]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[f]=!counter[f]!+1
if "!counter[f]!"=="!count[f]!" (
set "counter[f]="& set "count[f]="
set "t[f]= "
set "kl=À"
) else (
set "t[f]=³"
set "kl=Ã"
)
set /a folderf=!folderf!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !kl!ÄÄÄ!fcolor!Folder!foldera!.!folderb!.!folderc!.!folderd!.!foldere!.!folderf! !scolor!!size!
if !cd[f]!==y (
call :CountFolders g
for /d %%g in (*) do (
cd "%%g" 2>nul
if !errorlevel!==0 (
set cd[g]=y
) else (
set cd[g]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[g]=!counter[g]!+1
if "!counter[g]!"=="!count[g]!" (
set "counter[g]="& set "count[g]="
set "t[g]= "
set "kl=À"
) else (
set "t[g]=³"
set "kl=Ã"
)
set /a folderg=!folderg!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !kl!ÄÄÄ!fcolor!Folder!foldera!.!folderb!.!folderc!.!folderd!.!foldere!.!folderf!.!folderg! !scolor!!size!
if !cd[g]!==y (
call :CountFolders h
for /d %%h in (*) do (
cd "%%h" 2>nul
if !errorlevel!==0 (
set cd[h]=y
) else (
set cd[h]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[h]=!counter[h]!+1
if "!counter[h]!"=="!count[h]!" (
set "counter[h]="& set "count[h]="
set "t[h]= "
set "kl=À"
) else (
set "t[h]=³"
set "kl=Ã"
)
set /a folderh=!folderh!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !kl!ÄÄÄ!fcolor!Folder!foldera!.!folderb!.!folderc!.!folderd!.!foldere!.!folderf!.!folderg!.!folderh! !scolor!!size!
if !cd[h]!==y (
call :CountFolders i
for /d %%i in (*) do (
cd "%%i" 2>nul
if !errorlevel!==0 (
set cd[i]=y
) else (
set cd[i]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[i]=!counter[i]!+1
if "!counter[i]!"=="!count[i]!" (
set "counter[i]="& set "count[i]="
set "t[i]= "
set "kl=À"
) else (
set "t[i]=³"
set "kl=Ã"
)
set /a folderi=!folderi!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !kl!ÄÄÄ!fcolor!Folder!foldera!.!folderb!.!folderc!.!folderd!.!foldere!.!folderf!.!folderg!.!folderh!.!folderi! !scolor!!size!
if !cd[i]!==y (
call :CountFolders j
for /d %%j in (*) do (
cd "%%j" 2>nul
if !errorlevel!==0 (
set cd[j]=y
) else (
set cd[j]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[j]=!counter[j]!+1
if "!counter[j]!"=="!count[j]!" (
set "counter[j]="& set "count[j]="
set "t[j]= "
set "kl=À"
) else (
set "t[j]=³"
set "kl=Ã"
)
set /a folderj=!folderj!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !kl!ÄÄÄ!fcolor!Folder!foldera!.!folderb!.!folderc!.!folderd!.!foldere!.!folderf!.!folderg!.!folderh!.!folderi!.!folderj! !scolor!!size!
if !cd[j]!==y (
call :CountFolders k
for /d %%k in (*) do (
cd "%%k" 2>nul
if !errorlevel!==0 (
set cd[k]=y
) else (
set cd[k]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[k]=!counter[k]!+1
if "!counter[k]!"=="!count[k]!" (
set "counter[k]="& set "count[k]="
set "t[k]= "
set "kl=À"
) else (
set "t[k]=³"
set "kl=Ã"
)
set /a folderk=!folderk!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !kl!ÄÄÄ!fcolor!Folder!foldera!.!folderb!.!folderc!.!folderd!.!foldere!.!folderf!.!folderg!.!folderh!.!folderi!.!folderj!.!folderk! !scolor!!size!
if !cd[k]!==y (
call :CountFolders l
for /d %%l in (*) do (
cd "%%l" 2>nul
if !errorlevel!==0 (
set cd[l]=y
) else (
set cd[l]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[l]=!counter[l]!+1
if "!counter[l]!"=="!count[l]!" (
set "counter[l]="& set "count[l]="
set "t[l]= "
set "kl=À"
) else (
set "t[l]=³"
set "kl=Ã"
)
set /a folderl=!folderl!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !kl!ÄÄÄ!fcolor!Folder!foldera!.!folderb!.!folderc!.!folderd!.!foldere!.!folderf!.!folderg!.!folderh!.!folderi!.!folderj!.!folderk!.!folderl! !scolor!!size!
if !cd[l]!==y (
call :CountFolders m
for /d %%m in (*) do (
cd "%%m" 2>nul
if !errorlevel!==0 (
set cd[m]=y
) else (
set cd[m]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[m]=!counter[m]!+1
if "!counter[m]!"=="!count[m]!" (
set "counter[m]="& set "count[m]="
set "t[m]= "
set "kl=À"
) else (
set "t[m]=³"
set "kl=Ã"
)
set /a folderm=!folderm!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !kl!ÄÄÄ!fcolor!Folder!foldera!.!folderb!.!folderc!.!folderd!.!foldere!.!folderf!.!folderg!.!folderh!.!folderi!.!folderj!.!folderk!.!folderl!.!folderm! !scolor!!size!
if !cd[m]!==y (
call :CountFolders n
for /d %%n in (*) do (
cd "%%n" 2>nul
if !errorlevel!==0 (
set cd[n]=y
) else (
set cd[n]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[n]=!counter[n]!+1
if "!counter[n]!"=="!count[n]!" (
set "counter[n]="& set "count[n]="
set "t[n]= "
set "kl=À"
) else (
set "t[n]=³"
set "kl=Ã"
)
set /a foldern=!foldern!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !t[m]!   !kl!ÄÄÄ!fcolor!Folder!foldern! !scolor!!size!
if !cd[n]!==y (
call :CountFolders o
for /d %%o in (*) do (
cd "%%o" 2>nul
if !errorlevel!==0 (
set cd[o]=y
) else (
set cd[o]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[o]=!counter[o]!+1
if "!counter[o]!"=="!count[o]!" (
set "counter[o]="& set "count[o]="
set "t[o]= "
set "kl=À"
) else (
set "t[o]=³"
set "kl=Ã"
)
set /a foldero=!foldero!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !t[m]!   !t[n]!   !kl!ÄÄÄ!fcolor!Folder!foldero! !scolor!!size!
if !cd[o]!==y (
call :CountFolders p
for /d %%p in (*) do (
cd "%%p" 2>nul
if !errorlevel!==0 (
set cd[p]=y
) else (
set cd[p]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[p]=!counter[p]!+1
if "!counter[p]!"=="!count[p]!" (
set "counter[p]="& set "count[p]="
set "t[p]= "
set "kl=À"
) else (
set "t[p]=³"
set "kl=Ã"
)
set /a folderp=!folderp!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !t[m]!   !t[n]!   !t[o]!   !kl!ÄÄÄ!fcolor!Folder!folderp! !scolor!!size!
if !cd[p]!==y (
call :CountFolders q
for /d %%q in (*) do (
cd "%%q" 2>nul
if !errorlevel!==0 (
set cd[q]=y
) else (
set cd[q]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[q]=!counter[q]!+1
if "!counter[q]!"=="!count[q]!" (
set "counter[q]="& set "count[q]="
set "t[q]= "
set "kl=À"
) else (
set "t[q]=³"
set "kl=Ã"
)
set /a folderq=!folderq!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !t[m]!   !t[n]!   !t[o]!   !t[p]!   !kl!ÄÄÄ!fcolor!Folder!folderq! !scolor!!size!
if !cd[q]!==y (
call :CountFolders r
for /d %%r in (*) do (
cd "%%r" 2>nul
if !errorlevel!==0 (
set cd[r]=y
) else (
set cd[r]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[r]=!counter[r]!+1
if "!counter[r]!"=="!count[r]!" (
set "counter[r]="& set "count[r]="
set "t[r]= "
set "kl=À"
) else (
set "t[r]=³"
set "kl=Ã"
)
set /a folderr=!folderr!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !t[m]!   !t[n]!   !t[o]!   !t[p]!   !t[q]!   !kl!ÄÄÄ!fcolor!Folder!folderr! !scolor!!size!
if !cd[r]!==y (
call :CountFolders s
for /d %%s in (*) do (
cd "%%s" 2>nul
if !errorlevel!==0 (
set cd[s]=y
) else (
set cd[s]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[s]=!counter[s]!+1
if "!counter[s]!"=="!count[s]!" (
set "counter[s]="& set "count[s]="
set "t[s]= "
set "kl=À"
) else (
set "t[s]=³"
set "kl=Ã"
)
set /a folders=!folders!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !t[m]!   !t[n]!   !t[o]!   !t[p]!   !t[q]!   !t[r]!   !kl!ÄÄÄ!fcolor!Folder!folders! !scolor!!size!
if !cd[s]!==y (
call :CountFolders t
for /d %%t in (*) do (
cd "%%t" 2>nul
if !errorlevel!==0 (
set cd[t]=y
) else (
set cd[t]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[t]=!counter[t]!+1
if "!counter[t]!"=="!count[t]!" (
set "counter[t]="& set "count[t]="
set "t[t]= "
set "kl=À"
) else (
set "t[t]=³"
set "kl=Ã"
)
set /a foldert=!foldert!+1
echo %tcolor%!t[a]!   !t[b]!   !t[c]!   !t[d]!   !t[e]!   !t[f]!   !t[g]!   !t[h]!   !t[i]!   !t[j]!   !t[k]!   !t[l]!   !t[m]!   !t[n]!   !t[o]!   !t[p]!   !t[q]!   !t[r]!   !t[s]!   !kl!ÄÄÄ!fcolor!Folder!foldert! !scolor!!size!
)
if !cd[t]!==y cd ..
)
)
)
set foldert=0& if !cd[s]!==y cd ..
)
)
)
set folders=0& if !cd[r]!==y cd ..
)
)
)
set folderr=0& if !cd[q]!==y cd ..
)
)
)
set folderq=0& if !cd[p]!==y cd ..
)
)
)
set folderp=0& if !cd[o]!==y cd ..
)
)
)
set foldero=0& if !cd[n]!==y cd ..
)
)
)
set foldern=0& if !cd[m]!==y cd ..
)
)
)
set folderm=0& if !cd[l]!==y cd ..
)
)
)
set folderl=0& if !cd[k]!==y cd ..
)
)
)
set folderk=0& if !cd[j]!==y cd ..
)
)
)
set folderj=0& if !cd[i]!==y cd ..
)
)
)
set folderi=0& if !cd[h]!==y cd ..
)
)
)
set folderh=0& if !cd[g]!==y cd ..
)
)
)
set folderg=0& if !cd[f]!==y cd ..
)
)
)
set folderf=0& if !cd[e]!==y cd ..
)
)
)
set foldere=0& if !cd[d]!==y cd ..
)
)
)
set folderd=0& if !cd[c]!==y cd ..
)
)
)
set folderc=0& if !cd[b]!==y cd ..
)
)
)
set folderb=0& if !cd[a]!==y cd ..
)
)
echo.
echo %_bBWhite%%reachedend%
echo %_RESET%
pause>nul
exit /b
:FolderSize
if not "%DisableLowSizes%"=="enabled" goto FolderSizeNotEnabled
for /f "tokens=2-3 delims= " %%y in ('
robocopy "!CD!" "%TEMP%" /S /L /XJ /NFL /NDL /NJH /R:0 ^| findstr "Bytes"
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
:FolderSizeNotEnabled
for /f "tokens=2-3 delims= " %%y in ('
robocopy "!CD!" "%TEMP%" /S /L /XJ /NFL /NDL /NJH /R:0 ^| findstr "Bytes"
') do ( 
set dim=%%z
set "dim=!dim:k=KB!" & set "dim=!dim:m=MB!" & set "dim=!dim:g=GB!" & set "dim=!dim:t=TB!"    
if !dim! EQU %%z set dim=B
set "size=%%y !dim!"
)
if "!dim!"=="B" (set "scolor=%_fDGray%" & set "dimnum=1")
if "!dim!"=="KB" (set "scolor=%_fDGray%" & set "dimnum=2")
if "!dim!"=="MB" (set "scolor=%_fGreen%" & set "dimnum=3")
if "!dim!"=="GB" (set "scolor=%_fYellow%" & set "dimnum=4")
if "!dim!"=="TB" (set "scolor=%_fRed%" & set "dimnum=5")
goto FolderSizeNotEnabledNext
:CountFolders <letter>
if not "!count[%1]!"=="" goto CountFoldersEnd
for /f %%z in ('dir /b /ad-h-s ^|%windir%\system32\FIND.exe /c /v "" ') do set "count[%1]=%%z"
if "!count[%1]!"=="0" goto CountFoldersZero
for /d %%x in (*) do (
cd %%x 2>nul
if "!errorlevel!"=="0" (set "cdcfolcontinue=0") else (set "cdcfolcontinue=1")
if "%DisableLowSizes%"=="enabled" (
for /f "tokens=2-3 delims= " %%y in ('
robocopy "!CD!" "%TEMP%" /S /L /XJ /NFL /NDL /NJH /R:0 ^| findstr "Bytes"
') do (
set dlm=%%z
set "dlm=!dlm:k=KB!" & set "dlm=!dlm:m=MB!" & set "dlm=!dlm:g=GB!" & set "dim=!dlm:t=TB!"
if !dim! EQU %%z set dlm=B
set "slze=%%y !dlm!"
set "slzee=%%y"
)
if "!dlm!"=="B" (set "dlmnum=1")
if "!dlm!"=="KB" (set "dlmnum=2")
if "!dlm!"=="MB" (set "dlmnum=3")
if "!dlm!"=="GB" (set "dlmnum=4")
if "!dlm!"=="TB" (set "dlmnum=5")
for /l %%z in (10,-1,1) do (if not "!slzee:.=!"=="!slzee!" set slzee=!slzee:~0,%%z!)
if !low[2]! gtr !dlmnum! (set /a count[%1]=!count[%1]!-1) else (if not !low[1]! leq !slzee! (set /a count[%1]=!count[%1]!-1))
)
if "!cdcfolcontinue!"=="0" cd ..
)
:CountFoldersEnd
exit /b
:CountFoldersZero
set "count[%1]="
exit /b
