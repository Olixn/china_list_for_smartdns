#/bin/sh

mkdir -p /tmp/smartdns/


wget -O /tmp/smartdns/apple.china.domain.smartdns.conf https://mirror.ghproxy.com/https://raw.githubusercontent.com/Olixn/china_list_for_smartdns/main/apple.china.domain.smartdns.conf
wget -O /tmp/smartdns/chinalist.domain.smartdns.conf https://mirror.ghproxy.com/https://raw.githubusercontent.com/Olixn/china_list_for_smartdns/main/chinalist.domain.smartdns.conf
wget -O /tmp/smartdns/gfwlist.domain.smartdns.conf https://mirror.ghproxy.com/https://raw.githubusercontent.com/Olixn/china_list_for_smartdns/main/gfwlist.domain.smartdns.conf
wget -O /tmp/smartdns/google.china.domain.smartdns.conf https://mirror.ghproxy.com/https://raw.githubusercontent.com/Olixn/china_list_for_smartdns/main/google.china.domain.smartdns.conf
wget -O /tmp/smartdns/accelerated-domains.china.domain.smartdns.conf https://mirror.ghproxy.com/https://raw.githubusercontent.com/Olixn/china_list_for_smartdns/main/accelerated-domains.china.domain.smartdns.conf
# anti-AD 规则
wget -O /tmp/smartdns/anti-ad.domain.smartdns.conf https://mirror.ghproxy.com/https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-smartdns.conf

mv -f /tmp/smartdns/apple.china.domain.smartdns.conf  /etc/smartdns/apple.china.domain.smartdns.conf
mv -f /tmp/smartdns/chinalist.domain.smartdns.conf  /etc/smartdns/chinalist.domain.smartdns.conf
mv -f /tmp/smartdns/gfwlist.domain.smartdns.conf  /etc/smartdns/gfwlist.domain.smartdns.conf
mv -f /tmp/smartdns/google.china.domain.smartdns.conf  /etc/smartdns/google.china.domain.smartdns.conf
mv -f /tmp/smartdns/accelerated-domains.china.domain.smartdns.conf  /etc/smartdns/accelerated-domains.china.domain.smartdns.conf
# anti-AD 规则
mv -f /tmp/smartdns/anti-ad.domain.smartdns.conf  /etc/smartdns/anti-ad.domain.smartdns.conf


rm -rf /tmp/smartdns/

/etc/init.d/smartdns reload