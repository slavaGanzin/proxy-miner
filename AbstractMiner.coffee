config = require './config.js'
request = require 'request'
jsdom = require 'jsdom'
async = require 'async'
now = require 'performance-now'

class MinerAbstract
  constructor: (@name) ->
    @config = config "miners.default", "miners.#{@name}"
    @debug "#{@name} Config", @config
    @db = new (require "./db/#{@config.db}.js") @config

  start: ->
    if not @config.use_proxy or @config.jsdom.proxy
      @debug "useProxy: ", @config.use_proxy, @config.jsdom.proxy
      async.each [@config.first_page..@config.last_page], @fetchUrl, @finishHandler
    else
      @db.getProxy @startWithProxy

  startWithProxy: (error, proxies) =>
    @config.jsdom.proxy = @protocol(@config.url) + proxies[0]
    @start()

  fetchUrl: (page, @callback) =>
    url = @debug 'url', @config.url.replace @config.page_replace, @pageFormat page
    jsdom.env url, @config.jsdom, @processPage

  processPage: (errors, window) =>
    @callback errors if errors
    matched = window.$ @config.row.selector
    @debug 'matched rows on page', matched.length
    matched.each (i, element) =>
      @processRow i, element, window

  processRow: (i, element, window) =>
    @testProxy @parseRow window.$ element

  parseRow: ($row) ->
    @debug 'row', $row.text()
    host: @clearHost @parseHost $row
    port: @clearPort @parsePort $row

  parseHost: ($row) ->
    @debug 'parseHost', $row.find(@config.host.selector).text()
  parsePort: ($row) ->
    @debug 'parsePort', $row.find(@config.port.selector).text()

  clearHost: (host) ->
    @debug 'clearHost', host.replace @config.host.regexp, '$1'
  clearPort: (port) ->
    @debug 'clearPort', port.replace @config.port.regexp, '$1'

  pageFormat: (page) ->
    page

  testProxy: (proxy) ->
    proxyString = @debug 'testProxy', "#{proxy.host}:#{proxy.port}"
    return unless @debug 'is proxy', @config.proxy.regexp.test proxyString
    proxy.time = now()
    request @requestOptions(proxyString), (error, response, body) =>
      proxy.time = now() - proxy.time
      unless error
        proxy.status = response.statusCode
        @db.saveSuccessProxy proxyString, proxy
      else
        proxy.error = error
        @db.saveFailProxy proxyString, proxy
      console.log proxy

  requestOptions: (proxyString) ->
    protocol = @protocol @config.test.url
    headers = @config.request.headers
    headers.UserAgent = @config.userAgent[Math.floor Math.random() * (@config.userAgent.length+1)]
    @debug 'request options', headers: headers, url: @config.test.url, proxy: protocol+proxyString

  finishHandler: (error) ->
    console.log 'finish'
    console.error error if error

  debug: (message, values...) ->
    console.log "#{message}:\n", values if @config.debug
    values[values.length - 1]

  protocol: (url) ->
    url.replace /(http(s)?:\/\/).*/i, '$1'

module.exports = MinerAbstract