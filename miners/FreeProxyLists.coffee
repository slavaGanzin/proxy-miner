class FreeProxyList extends require('../AbstractMiner.js')
  constructor: ->
    super 'FreeProxyList'

  processPage: (errors, window) =>
    @debug 'w', /permission/.test window.$('body').text()
    super errors, window

new FreeProxyList().start()