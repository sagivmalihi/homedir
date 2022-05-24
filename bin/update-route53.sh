#!/bin/bash

# Copied from http://willwarren.com/2014/07/03/roll-dynamic-dns-service-using-amazon-route53/

# Externalizing the zone ID and CNAME
if [ -z "$1" ]
  then
    echo "The first argument needs to be the Hosted Zone ID, i.e. BJBK35SKMM9OE"
    exit 1
fi

if [ -z "$2" ]
  then
    echo "The second argument needs to be CNAME to update, i.e. example.com"
    exit 1
fi

if [ -z "$3" ]
  then
    echo "The third argument needs to be AWS IAM role that has access to this domain, i.e. your-dns-updater"
    exit 1
fi


# Hosted Zone ID e.g. BJBK35SKMM9OE
ZONEID=$1

# The CNAME you want to update e.g. hello.example.com
RECORDSET=$2

# The IAM user profile to use
IAM_PROFILE=$3

# Force the update
# if [ $4 = "1" ];
#  then
#  echo "Force update is set."
#    FORCE_UPDATE=1
# fi

# More advanced options below
# The Time-To-Live of this recordset
TTL=300
# Change this if you want
COMMENT="Auto updating @ `date`"
# Change to AAAA if using an IPv6 address
TYPE4="A"
TYPE6="AAAA"

# Get the external IP address
IPv4=`curl -sSk https://ipv4.myip.wtf/text`
IPv6=`curl -sSk https://ipv6.myip.wtf/text`

function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

# Get current dir (stolen from http://stackoverflow.com/a/246128/920350)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOGFILE="$DIR/update-route53.log"
IPFILE="$DIR/update-route53.ip"

if ! valid_ip $IPv4; then
    echo "Invalid IPv4 address: $IPv4" >> "$LOGFILE"
    exit 1
fi

# Check if the IP has changed
if [ ! -f "$IPFILE" ]
    then
      touch "$IPFILE"
fi

echo "IP has changed to $IPv4 $IPv6, updating ..."
echo "IP has changed to $IPv4 $IPv6" >> "$LOGFILE"
# Fill a temp file with valid JSON
TMPFILE4=$(mktemp /tmp/temporary-file.XXXXXXXX)
cat > ${TMPFILE4} << EOF
{
  "Comment":"$COMMENT",
  "Changes":[
    {
      "Action":"UPSERT",
      "ResourceRecordSet":{
        "ResourceRecords":[
          {
            "Value":"$IPv4"
          }
        ],
        "Name":"$RECORDSET",
        "Type":"$TYPE4",
        "TTL":$TTL
      }
    }
  ]
}
EOF

# Fill a temp file with valid JSON
TMPFILE6=$(mktemp /tmp/temporary-file.XXXXXXXX)
cat > ${TMPFILE6} << EOF
{
  "Comment":"$COMMENT",
  "Changes":[
    {
      "Action":"UPSERT",
      "ResourceRecordSet":{
        "ResourceRecords":[
          {
            "Value":"$IPv6"
          }
        ],
        "Name":"$RECORDSET",
        "Type":"$TYPE6",
        "TTL":$TTL
      }
    }
  ]
}
EOF
# Update the Hosted Zone record
aws route53 change-resource-record-sets \
    --profile $IAM_PROFILE \
    --hosted-zone-id $ZONEID \
    --change-batch file://"$TMPFILE4" >> "$LOGFILE"
echo "" >> "$LOGFILE"

# Update the Hosted Zone record
aws route53 change-resource-record-sets \
    --profile $IAM_PROFILE \
    --hosted-zone-id $ZONEID \
    --change-batch file://"$TMPFILE6" >> "$LOGFILE"
echo "" >> "$LOGFILE"

# Clean up
rm $TMPFILE4
rm $TMPFILE6

# All Done - cache the IP address for next time
# echo "$IP" > "$IPFILE"

