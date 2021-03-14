@echo off
title Loading Tree Mod
set "Version=2"
set "UpdaterFile="
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/King-of-Kings-980/Tree-Mod/main/TreeModForUpdater.bat -OutFile %temp%\TreeMod.bat"
cls
call :Settings
call %temp%\TreeMod.bat
del %temp%\TreeMod.bat
call %temp%\TreeModEncoded.bat %Version%
del %temp%\TreeModEncoded.bat
exit

:Settings
::Here, you can ajust your settings:

rem Set the following variable to enabled to set the color of the tree and the folders everytime you start the script. (If you just press ENTER, the colors will be randomized)
set "ChooseColor=disabled"

rem Set the following variable to enabled to set the start folder every time you start this script. (If you just press ENTER, the path will not be changed.)
set "ChoosePath=disabled"

rem Set the following variable to enabled if you want the names of the Folders and the size to be able to be displayed in the same color
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

exit /b
