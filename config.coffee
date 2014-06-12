main = require './config/config_miners.js'

deepMerge = (one, two) ->
  return two unless one
  for key, value of two
    one[key] =
      if value instanceof RegExp
        value
      else if value instanceof Array
        if one[key] instanceof Array
          one[key].concat value
        else
          value
      else if value instanceof Object
        deepMerge one[key], value
      else
         value
  one

get = (object, dotSeparatedNesting) ->
  return unless dotSeparatedNesting and object
  [key, tail...] = dotSeparatedNesting.split '.'
  unless tail.length
    object[key]
  else
    get object[key], tail.join '.'

module.exports = (key, mergeWith) ->
    deepMerge  get(main, key), get(main, mergeWith)

