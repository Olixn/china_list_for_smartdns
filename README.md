# 配置 SmartDNS 上游和仅测速国内域名
如前文所说，在本地解析需要被代理的域名时，不需要测速、也不一定要绝对准确，只需要解析得到的 IP 不会干扰 Surge/Clash 分流即可；只将国内的递归 DNS 作为上游解析国内直连域名，也只对其进行测速。因此，我们使用「白名单」策略，默认解析不测速、不使用国内递归 DNS 作为上游。

首先需要禁用 SmartDNS 全局的测速设置：
```
speed-check-mode none
```
然后设置两组上游 DNS：默认的一组不位于中国大陆境内的递归 DNS；另一组位于中国大陆境内的递归 DNS，仅用于解析 dnsmasq-china-list 列表中的域名：

```
# ----- Default Group -----
# 默认使用的上游 DNS 组
# OpenDNS 非常规 443 端口、支持 TCP 查询
server-tcp 208.67.220.220:443
# OpenDNS 的 IP DoH
server-https https://146.112.41.2/dns-query
# TWNIC 的 IP DoH
server-https https://101.101.101.101/dns-query
# 你也可以配置其它 DNS 作为上游

# ----- Domestic Group: domestic -----
# 仅用于解析 dnsmasq-china-list 列表中的域名
# 腾讯 DNSPod IP DoT
server-tls 1.12.12.12:853 -group domestic -exclude-default-group
server-tls 120.53.53.53:853 -group domestic -exclude-default-group
# 阿里 IP DoT
server-tls 223.5.5.5:853 -group domestic -exclude-default-group
server-tls 223.6.6.6:853 -group domestic -exclude-default-group
# 114 DNS、使用 TCP 查询
server-tcp 114.114.114.114 -group domestic -exclude-default-group
server-tcp 114.114.115.115 -group domestic -exclude-default-group
# CNNIC 公共 DNS、仅支持 UDP 查询
server 1.2.4.8 -group domestic -exclude-default-group
server 210.2.4.8 -group domestic -exclude-default-group
```
其中，设置有 -exclude-default-group 的上游 DNS 默认不会被使用，仅当 domain-rules 或 nameserver 配置明确指定时使用。

你可能注意到，我的配置中添加了 CNNIC（中国互联网络信息中心）的公共 DNS。这是考虑到 CNNIC 的公共 DNS 节点质量较差、出口 IP 位置稀少、基本没有针对 CDN 做任何优化（截至本文写就，1.2.4.8 的 Anycast 仅在 浙江杭州阿里云 和 香港 Zenlayer 广播路由，210.2.4.8 的 Anycast 仅在 北京联通 广播路由）。所以，一般情况下，只有 CNNIC 的公共 DNS 一定不能 返回距离我位置最近的 CDN 节点（其余的公共 DNS 基本都会返回给我最优的 CDN 节点）。
设想一下，除 CNNIC 外、大部分公共 DNS 都会尽可能返回距离我本地运营商最近的、最优的 CDN 节点；由于 SmartDNS 的测速和优选，CNNIC 返回的非最优 CDN 节点一般会被忽略。然而，假如距离我最近的 CDN 节点出现故障，只有 CNNIC 能够给我返回不一样的 CDN 节点、能够响应 SmartDNS 测速，因此我能够使用并非最优、但是可用的 CDN 节点「救急」、不至于直接「断网」。
简单来说，就是因为 CNNIC 公共 DNS 能够非常稳定地提供质量最差的递归 DNS 服务、不会间歇发生解析质量好转，才得以入选。

最后，引入前文由 dnsmasq-china-list 生成的 domain-rules 配置文件：
```
conf-file /path/to/dnsmasq-china-list/accelerated-domains.china.domain.smartdns.conf
conf-file /path/to/dnsmasq-china-list/apple.china.domain.smartdns.conf
```
---------------------
本文著作权归作者 Sukka 所有。本文采用 CC BY-NC-SA 4.0 许可协议，商业转载请联系作者获得授权，非商业转载请注明出处。
作者：Sukka
来源：我有特别的 DNS 配置和使用技巧
链接：https://blog.skk.moe/post/i-have-my-unique-dns-setup/