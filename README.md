# W10M-Emulator-Selector
A simple PowerShell script to easily choose the right emulator version. This way there is no need to start Visual Studio. 

The problem is that you can't just start the emulator on its own. It was originally intended to debug UWP apps, which would then be launched from Visual Studio. Fortunately, there is a workaround with PowerShell. Unfortunately, the command is quite long and not easy to remember. So I made a simple PowerShell GUI that automatically adjusts the command based on the chosen version.

![Screenshot 2023-04-01 192717](https://user-images.githubusercontent.com/36573021/231742918-1e5ef264-90ff-42a7-9df3-c4d6be5bf619.png)
