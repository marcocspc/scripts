set "network_name=EXAMPLE_NAME"
set "peer=XXXXXXXXXXXPEER_KEYXXXXXXXXXXXXXXXX"
set "endpoint=0.0.0.0:0000"

wg set %network_name% peer %peer% endpoint %endpoint%
