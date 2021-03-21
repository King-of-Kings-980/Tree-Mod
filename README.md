DO NOT DOWNLOAD THIS PROJECT! DEVELOPEMENT IS STILL IN PROGRESS!




"Tree-Mod.bat" is the main script which can display the normal tree
    - with an option which lets you choose the path
    - with the folder size
        * with a minimum size
        * with a maximum size
    - with colors
        * The tree, the folder names and sizes can have different colors
        * The color of the sizes can change based on the size of a folder
        * You can enable an option to allow dublicate colors
        * The script can generate a random combination of colors color or enable an option to choose it yourself
        * You can disable colors you do not like
  Note: If you are not using Windows 10, your script might crash at the end. If that happens, you can enable an option (set DisableReachedEnd=enabled) which should fix it.

"Tree-Mod-Anonymous-Demo.bat" does the same as "Tree-Mod.bat" but instead of displaying the real folder name it displays e.g.:
    │
    └───Folder 1
        │
        ├───Folder 1.1
        └───Folder 1.2
            └───Folder 1.2.1

"Tree-Mod-Updater.bat" is a file which always downloads the newest version of the main script (in %temp%) and executes it. The Updater has all the options from the main script. It can also update itself, if I add new options. You will also be notified if there are new options available.

"TreeModForUpdater.bat" is just a file for the "Tree-Mod-Updater.bat". You shouldn't download it.
