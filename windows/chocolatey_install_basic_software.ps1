# This is a script to help me quickly install all the basic applications using chocolatey.
# Run this as admin and make sure chocolatey is installed.
# Install it by visiting: https://chocolatey.org/install


# The apps are divided into categories. You can select what
# not to install by deleting its name from one of the variables.
# You can also add new softwares by adding a name in one of the 
# variables. Remember that the list must be space separated.
# The names are chocolatey packages. Go here to search for
# new packages: https://community.chocolatey.org/packages
$web_browsers = "firefox googlechrome"
$pdf = "adobereader"
$compression = "7zip"
$graphics = "inkscape gimp krita greenshot"
$cloud_storage = "googledrive dropbox onedrive"
$documents = "libreoffice"
$games = "steam-client"
$maps = "googleearth"
$meetings = "skype zoom"
$development_and_runtimes = "python3 javaruntime"
$ide = "notepadplusplus vim vscode"
$remote_management = "winscp putty teamviewer"
# Warning! Spotify may make the installation enter a loop, if that's the case, Ctrl-C and run the script again.
$media = "vlc itunes audacity k-litecodecpackmega spotify handbrake"
$password_management = "keepass"
$torrenting = "transmission"
$system_tools = "windirstat"

$answer_yes = ""
#Uncomment to accept all prompts
#$answer_yes = "-y"


choco install $answer_yes $web_browsers $pdf $compression $graphics $cloud_storage $documents $games $maps $meetings $development_and_runtimes $ide $remote_management $media $password_management $torrenting $system_tools
