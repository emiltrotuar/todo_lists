class @Authentication
  @Strategies = {}

  config:
    csrfToken: null

  constructor: (config) ->
    $.extend @config, config if config

  start: (options={}) ->
    @authenticate 'token', {}, options

  authenticate: (strategyName, params, options) ->
    defer = $.Deferred()
    strategyClassName = strategyName.camelize().capitalize()
    strategyClass = Authentication.Strategies[strategyClassName]
    throw "Strategy not found: #{strategyClassName}" if strategyClass is `undefined`
    strategy = new strategyClass(this, defer, params, options)
    strategy.name = strategyName
    strategy.authenticate()
    defer.promise()
