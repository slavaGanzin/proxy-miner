class Samair extends require('../AbstractMiner.js')
  constructor: ->
    super 'Samair'

  pageFormat: (page) ->
    if page < 10 then '0'+page else page

new Samair().start()