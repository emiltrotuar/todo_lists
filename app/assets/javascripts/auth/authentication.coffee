class @Authentication
  @Strategies = {}

  config:
    csrfToken: null

  constructor: (config) ->
    $.extend @config, config if config

  start: (options={}) ->
    @authenticate 'token', {}, options

  authenticate: (strategyName, params, options) ->
    strategyClassName = strategyName.camelize().capitalize()
    strategyClass = Authentication.Strategies[strategyClassName]
    throw "Strategy not found: #{strategyClassName}" if strategyClass is `undefined`
    strategy = new strategyClass(this, params, options)
    strategy.name = strategyName
    strategy.authenticate()

  request: (clientName, params, options) ->
    clientClassName = clientName.camelize().capitalize()
    clientClass = Authentication.Clients[clientClassName]
    throw "Client not found: #{clientClassName}" if clientClass is `undefined`
    client = new clientClass(this, params, options)
    client.name = clientName
    client.request()
