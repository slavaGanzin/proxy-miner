class Redis
  constructor: (@config) ->
    throw new Error 'No Redis config specified' unless @config.Redis
    @redis = require('redis')
        .createClient @config.Redis.port, @config.Redis.host, @config.Redis.options
        .on "error", (error) -> throw new Error "Redis #{error}"

  saveSuccessProxy: (proxyString, proxy) ->
    @redis.zadd @config.mapping.fail_zset, proxy.time, proxyString
    @redis.hset @config.mapping.proxy_hash, proxyString, JSON.stringify proxy

  saveFailProxy: (proxyString, proxy) ->
    @redis.zadd @config.mapping.success_zset, proxy.time, proxyString
    @redis.hset @config.mapping.proxy_hash, proxyString, JSON.stringify proxy

  getProxy: (callback) ->
    @redis.zrange @config.mapping.success_zset, 0, 0, callback

module.exports = Redis
