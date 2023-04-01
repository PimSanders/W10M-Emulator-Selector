# Init PowerShell Gui
Add-Type -AssemblyName System.Windows.Forms

# Create a new form
$W10MVersionForm                    = New-Object system.Windows.Forms.Form

# Define the size, title and background color of the window
$W10MVersionForm.ClientSize         = '300,100'
$W10MVersionForm.text               = "W10M Emulator"
$W10MVersionForm.BackColor          = "#121212"

##########################

# Create a Title for our form. We will use a label for it.
$Title                           = New-Object system.Windows.Forms.Label
# The content of the label
$Title.text                      = "Choosing a Windows version"
# Make sure the label is sized the height and length of the content
$Title.AutoSize                  = $true
# Define the minial width and height (not nessary with autosize true)
$Title.width                     = 25
$Title.height                    = 10
# Position the element
$Title.location                  = New-Object System.Drawing.Point(20,20)
# Define the font type and size
$Title.Font                      = 'Microsoft Sans Serif,13'
$TItle.ForeColor                     = "#ffffff"

##########################

#  Define the dropdown selector
$VersionSelector                     = New-Object system.Windows.Forms.ComboBox
$VersionSelector.text                = ""
$VersionSelector.width               = 170
$VersionSelector.autosize            = $true

# Add the items in the dropdown list
Get-ChildItem -Path "C:\Program Files (x86)\Microsoft XDE" -Directory -Force -ErrorAction SilentlyContinue | Select-Object -Property Name | foreach { $_.Name } | ForEach-Object {[void] $VersionSelector.Items.Add($_)}

# Select the default value
$VersionSelector.SelectedIndex       = 0
$VersionSelector.location            = New-Object System.Drawing.Point(20,50)
$VersionSelector.Font                = 'Microsoft Sans Serif,10'

##########################

$ChooseVersionBtn                   = New-Object system.Windows.Forms.Button
$ChooseVersionBtn.BackColor         = "#ffffff"
$ChooseVersionBtn.text              = "Run"
$ChooseVersionBtn.width             = 60
$ChooseVersionBtn.height            = 20
$ChooseVersionBtn.location          = New-Object System.Drawing.Point(200,50)
$ChooseVersionBtn.Font              = 'Microsoft Sans Serif,10'
$ChooseVersionBtn.ForeColor         = "#121212"

##########################

# ADD NEW OBJECT TO THE RANGE
$W10MVersionForm.controls.AddRange(@($Title, $VersionSelector, $ChooseVersionBtn))

##########################

function startEmulator {
    $version = $VersionSelector.SelectedItem
    $path = "C:\Users\Pim\AppData\Local\Microsoft\XDE\$($version)"


    if (Test-Path $path) {   
    } else {
        New-Item $path -ItemType Directory
    }

    & "C:\Program Files (x86)\Microsoft XDE\$($version)\XDE.exe" /name "$($version)" /memsize 2048 /vhd "C:\Program Files (x86)\Windows Kits\10\Emulation\Mobile\$($version)\flash.vhd"  /creatediffdisk "C:\Users\Pim\AppData\Local\Microsoft\XDE\$($version)\dd.1080x1920.2048.vhd" /snapshot /fastShutdown
}

$ChooseVersionBtn.Add_Click({ startEmulator })

##########################

# THIS SHOULD BE AT THE END OF YOUR SCRIPT
# Display the form
[void]$W10MVersionForm.ShowDialog()