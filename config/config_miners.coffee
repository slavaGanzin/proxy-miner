module.exports =

miners:
  active: [
    'Samair'
    'SocksList'
    'ProxyHttp'
    'Spys'
    'BestProxy'
    'Xroxy'
  ]

  default:
    debug: true
    db: 'Redis'
    Redis:
      port: 6379
      host: '127.0.0.1'
      options: null
    proxy:
     regexp: /^\d+.\d+.\d+.\d+:\d+$/
    host:
      regexp: /(\d+.\d+.\d+.\d+)\D*.*/
    port:
      regexp: /\D*(\d+)\D*/
    userAgent: [  #http://useragentstring.com/pages/Browserlist/
      'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.6) Gecko/2009011913 Firefox/3.0.6'
      'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.6) Gecko/2009011912 Firefox/3.0.6'
      'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.6) Gecko/2009011913 Firefox/3.0.6 (.NET CLR 3.5.30729)'
      'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.6) Gecko/2009020911 Ubuntu/8.10 (intrepid) Firefox/3.0.6'
      'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.6) Gecko/2009011913 Firefox/3.0.6'
      'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.6) Gecko/2009011913 Firefox/3.0.6 (.NET CLR 3.5.30729)'
      'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.48 Safari/525.19'
      'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648)'
      'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.6) Gecko/2009020911 Ubuntu/8.10 (intrepid) Firefox/3.0.6'
      'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.5) Gecko/2008121621 Ubuntu/8.04 (hardy) Firefox/3.0.5'
      'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/3.2.1 Safari/525.27.1'
      'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)'
      'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)'
      'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)'
    ]
    mapping:
      fail_zset: 'z_proxy_fail'
      success_zset: 'z_proxy_success'
      proxy_hash: 'h_proxy'
    page_replace: '#page'
    use_proxy: false
    first_page: 1
    last_page: 1
    request:
      headers:
        'Accept-Encoding': 'gzip, deflate'
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
        'Accept-Language': 'en-us,en;q=0.5'
    test:
      url: 'http://stackoverflow.com'
    jsdom:
      scripts: ["http://code.jquery.com/jquery.js"]
      features: [
        FetchExternalResources: ["script"]
        ProcessExternalResources: false
        SkipExternalResources: 'jquery'
      ]

  BestProxy:
    last_page: 10
    url: 'http://best-proxy.com/english/index.php?p=#page'
    row:
      selector: 'div.table ul'
    host:
      selector: 'li.proxy'
    port:
      selector: 'li.proxy'
      regexp: /^.*:(\d+)$/
    jsdom:
      features:
        SkipExternalResources: 'jquery'

  HideMe:
    url: 'http://hideme.ru/proxy-list/#page'
    row:
      selector: "table.pl tr"
    host:
      selector: "td:first"
    port:
      selector: "td:eq(1)"

  HideMyAss:
    last_page: 1
    jsdom:
      features:
        FetchExternalResources: ["script", "css"]
        SkipExternalResources: 'facebook.net|jquery'
    url: 'https://hidemyass.com/proxy-list/#page'
    row:
      selector: "#listtable tbody .tr"
    host:
      selector: "td:eq(2) span:visible"
    port:
      selector: "td:eq(3) span:visible"

  Samair:
    last_page: 30
    url: 'http://www.samair.ru/proxy/proxy-#page.htm'
    row:
      selector: '#proxylist tr:not(.list_sorted)'
    host:
      selector: "td:eq(0)"
    port:
      selector: "td:eq(0)"
      regexp: /.*:(\d+)$/

  SocksList:
    last_page: 3
    url: 'http://sockslist.net/proxy/server-socks-hide-ip-address/#page'
    row:
      selector: 'table.proxytbl tr:not(:first)'
    host:
      selector: 'td.t_ip'
      regexp: /(\d+.\d+.\d+.\d+)/
    port:
      selector: 'td.t_port'
      regexp: /[^]+\s(\d+)[^]+/

  ProxyHttp:
    last_page: 9
    url: 'http://proxyhttp.net/free-list/anonymous-server-hide-ip-address/#page'
    row:
      selector: 'table.proxytbl tr'
    host:
      selector: 'td.t_ip'
      regexp: /(\d+.\d+.\d+.\d+)/
    port:
      selector: 'td.t_port'
      regexp: /[^]+\s(\d+)[^]+/m

  Xroxy:
    last_page: 1
    url: 'http://www.xroxy.com/proxylist.php?pnum=#page'
    jsdom:
      scripts: ["http://code.jquery.com/jquery.js"]
      features: null
    row:
      selector: '.row0, .row1'
    host:
      selector: "td:eq(1)"
      regexp: /^(\d+.\d+.\d+.\d+)$\s*/m
    port:
      selector: "td:eq(2)"

  Spys:
    last_page: 3
    url: 'http://spys.ru/proxies/#page'
    row:
      selector: 'table table tr'
    host:
      selector: '.spy14'
      regexp: /(\d+.\d+.\d+.\d+)?.*/
    port:
      selector: '.spy14'
      regexp: /.*\)\):(\d+).*/m

  FreeProxyList:
    last_page: 1
    use_proxy: true
    url: 'http://www.freeproxylists.net/?page=#page'
    row:
      selector: 'table.DataGrid tbody tr:not(.Caption)'
    host:
      selector: 'td:first'
      regexp: /.*(\d+.\d+.\d+.\d+)?.*/
    port:
      selector: 'td:eq(2)'
      regexp: /(\d+)/
