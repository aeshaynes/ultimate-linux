#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------


function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }




function my_ip() # Get IP adress on ethernet.
{
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

# Show current network information
netinfo ()
{
        echo "--------------- Network Information ---------------"
        /sbin/ifconfig | awk /'inet addr/ {print $2}'
        echo ""
        /sbin/ifconfig | awk /'Bcast/ {print $3}'
        echo ""
        /sbin/ifconfig | awk /'inet addr/ {print $4}'

        /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
        echo "---------------------------------------------------"
}

# IP address lookup
alias whatismyip="whatsmyip"
function whatsmyip ()
{
        # Dumps a list of all IP addresses for every device
        # /sbin/ifconfig |grep -B1 "inet addr" |awk '{ if ( $1 == "inet" ) { print $2 } else if ( $2 == "Link" ) { printf "%s:" ,$1 } }' |awk -F: '{ print $1 ": " $3 }';

        # Internal IP Lookup
        echo -n "Internal IP: " ; /sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'

        # External IP Lookup
        echo -n "External IP: " ; wget https://api.ipify.org/ -O - -q 
}

function sendkey ()
{
    if [ -f ~/.ssh/id_rsa.pub ]
    then
        echo "Key Exists for $USER"
        ssh $USER@$1 'mkdir -p .ssh'
        cat ~/.ssh/id_rsa.pub |ssh $USER@$1 'cat >> .ssh/authorized_keys'
    fi

}


