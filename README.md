# Tree Mod
## Tree-Mod.bat
Displays the normal tree:
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
 - with an option which, instead of displaying the real folder name, displays e.g.: Folder_1; Folder_1.1; Folder_1.2; Folder_1.2.1; Folder_2

Note: If you are not using Windows 10, your script might crash at the end. If that happens, you can enable an option (`set DisableReachedEnd=enabled`) which should fix it.




## Upcoming features

### Tree-Mod.bat
 - Fix crashes which might happen if a path has more than about 23 folders.
 - New options:
   * speed option _doesn't display the tree correctly but it is faster_
   * also list files
     * List files bigger than ...
     * List files smaler than ...
     * If the range of the listed files is bigger than the range of the displayed folders, the files outside of the range of the folder size will not be displayed; e.g.: `"Max_Folder_Size=100 MB"  "Max_File_Size=200 MB" -> Files bigger than 100 MB will not be displayed.`
   * set colors in the options menu and do not randomize them; **This option will ignore any othe option concerning colors!**
   * exclude colors you do not like; _This option will replace the option to disable the color white._
   * displaying the folder size will be optional
   * disable colors compleatly
   * new colors for each branch
   * add the options from the normal tree-command

### New files
 - A new file which lets you choose the options.
 - An installer
   * "Installing" the Tree-Mod.bat:
     * Place Tree-Mod.bat and some other files in `%ProgramFiles%` or in `%LocalAppdata%`
     * Add the path to those files in the path-variable so that you can run the script from anywhere by typing `TreeMod` in CMD. This will work like a command:
       * `TreeMod /?` will give you all the available options, e.g. `/d` or `/s`
       * This command will also have the option of the normal `tree`-command
   * Uninstall the Tree-Mod.bat (The files will not be dedeleted but they will be moved to the recycle bin.)
