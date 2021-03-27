@echo off
setlocal enableDelayedExpansion
title Tree Mod Whith Colors and Folder Sizes
if not "%1"=="" goto SkipSettings
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
setlocal DisableDelayedExpansion
echo Path: (!userprofile! or .. etc. works, too)
endlocal
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
::#
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
call :TreeModMain a
echo.
echo %_bBWhite%%reachedend%
echo %_RESET%
pause>nul
exit /b
:TreeModMain <letter>
setlocal EnableDelayedExpansion
call :CountFolders %1
for /d %%%1 in (*) do (
cd "%%%1" 2>nul
if !errorlevel!==0 (
set cd[%1]=y
) else (
set cd[%1]=n
)
call :FolderSize
if "!shownext!"=="y" (
set /a counter[%1]=!counter[%1]!+1
if "!counter[%1]!"=="!count[%1]!" (
set "counter[%1]="
set "count[%1]="
set "t[%1]=    "
set "kl=À"
) else (
set "t[%1]=³   "
set "kl=Ã"
)
if "%1"=="a" echo %tcolor%!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="b" echo %tcolor%!t[a]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="c" echo %tcolor%!t[a]!!t[b]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="d" echo %tcolor%!t[a]!!t[b]!!t[c]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="e" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="f" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="g" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="h" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="i" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="j" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="k" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="l" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!t[k]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="m" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!t[k]!!t[l]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="n" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!t[k]!!t[l]!!t[m]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="o" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!t[k]!!t[l]!!t[m]!!t[n]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="p" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!t[k]!!t[l]!!t[m]!!t[n]!!t[o]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="q" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!t[k]!!t[l]!!t[m]!!t[n]!!t[o]!!t[p]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="r" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!t[k]!!t[l]!!t[m]!!t[n]!!t[o]!!t[p]!!t[q]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="s" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!t[k]!!t[l]!!t[m]!!t[n]!!t[o]!!t[p]!!t[q]!!t[r]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="t" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!t[k]!!t[l]!!t[m]!!t[n]!!t[o]!!t[p]!!t[q]!!t[r]!!t[s]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="u" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!t[k]!!t[l]!!t[m]!!t[n]!!t[o]!!t[p]!!t[q]!!t[r]!!t[s]!!t[t]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="v" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!t[k]!!t[l]!!t[m]!!t[n]!!t[o]!!t[p]!!t[q]!!t[r]!!t[s]!!t[t]!!t[u]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="w" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!t[k]!!t[l]!!t[m]!!t[n]!!t[o]!!t[p]!!t[q]!!t[r]!!t[s]!!t[t]!!t[u]!!t[v]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="x" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!t[k]!!t[l]!!t[m]!!t[n]!!t[o]!!t[p]!!t[q]!!t[r]!!t[s]!!t[t]!!t[u]!!t[v]!!t[w]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="y" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!t[k]!!t[l]!!t[m]!!t[n]!!t[o]!!t[p]!!t[q]!!t[r]!!t[s]!!t[t]!!t[u]!!t[v]!!t[w]!!t[x]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if "%1"=="z" echo %tcolor%!t[a]!!t[b]!!t[c]!!t[d]!!t[e]!!t[f]!!t[g]!!t[h]!!t[i]!!t[j]!!t[k]!!t[l]!!t[m]!!t[n]!!t[o]!!t[p]!!t[q]!!t[r]!!t[s]!!t[t]!!t[u]!!t[v]!!t[w]!!t[x]!!t[y]!!kl!ÄÄÄ!fcolor!%%%1 !scolor!!size!
if !cd[%1]!==y (
set lettercounter=1
for %%z in (a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z) do (
set /a lettercounter=!lettercounter!+1
if "%1"=="%%z" set lettercount=!lettercounter!
)
set letterco=0
for %%z in (a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0) do (
set /a letterco=!letterco!+1
if "!letterco!"=="!lettercount!" set letter=%%z
)
if not "!letter!"=="" (if not "!letter!"=="0" call :TreeModMain !letter!)
)
)
if !cd[%1]!==y cd ..
)
endlocal
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
if !low[2]! gtr !dimnum! set "shownext=n"
if !low[2]! equ !dimnum! if !low[1]! leq !sizee! (set "shownext=y") else (set "shownext=n")
if !low[2]! lss !dimnum! set "shownext=y"
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
if !low[2]! gtr !dlmnum! set /a count[%1]=!count[%1]!-1
if !low[2]! equ !dlmnum! if !low[1]! gtr !slzee! set /a count[%1]=!count[%1]!-1
)
if "!cdcfolcontinue!"=="0" cd ..
)
:CountFoldersEnd
exit /b
:CountFoldersZero
set "count[%1]="
exit /b
