# This script tries to translate the script available at
# https://gist.github.com/mattkasun/9a0e90d9d31b2c935d3f6d6e71dbece9
# to Windows Poweshell. 
# Call it by passing the following parameters:
# wireguard_watchdog.ps1 $HOST $INTERFACE
# Where:
# $HOST: ip of the host to ping to check wireguard connection (example: 10.0.0.1)
# $INTERFACE: interface name to reset the connection (example: wg0)
# Also MAKE SURE that the wireguard tunnel is enabled on its system trail app.
# Otherwise the service won't be recognized by the net command and restarting will fail.
# This script will run once, so set it's execution on task scheduler. (I've set mine to run once every 30s)

$HOST_IP = $args[0]
$INTERFACE = $args[1]

function check_peer($ip) {
    For ($i = 0; $i -lt 3; $i++) {
        $test = $(Test-Connection -ComputerName $ip -Count 1 -Quiet)
        if ($test -eq "True") {
            Write-Host("Wireguard working, exiting...")
            Exit
        }
    }
}

function restart_wireguard($interface) {
    Write-Host "Resetting service WireGuardTunnel`$$interface"
    net stop "WireGuardTunnel`$$interface"
    net start "WireGuardTunnel`$$interface"
}

check_peer($HOST_IP)
Write-Host("Wireguard NOT working, resetting...")
restart_wireguard($INTERFACE)
