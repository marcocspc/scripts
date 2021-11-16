# Quick Help

## restart_service.bat

This script is able to reset any service from the system (if ran and amdin user). I used it to restart vpn services on my machine once, using task manager.

- Hint: if using task manager to run it, make sure to tick "[X] Run whether user is logged on or not" checkbox. Otherwise, an annoying cmd windows will keep showing every time the script is opened by task manager.

## wireguard_watchdog.ps1

I scheduled it to run every minute on task manager, I'm still testing if this is going to make the connection stable. This one must be run as admin.
