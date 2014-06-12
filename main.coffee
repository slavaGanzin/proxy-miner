async = require 'async'
config = require './config.js'

worker = (minerName, callback) =>
  try require "./miners/#{minerName}.js"
  catch error
    callback error

finish = (error) ->
  console.log error if error
  console.log 'finish'

async.each config('miners.active'), worker, finish




