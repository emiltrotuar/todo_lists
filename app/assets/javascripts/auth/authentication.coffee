class @Authentication
  @Strategies = {}

  config:
    tokenCookieName: 'tl_token'
    csrf_token: null

  constructor: (config) ->
    $.extend @config, config if config

  start: (options={}) ->
    token = @getAuthenticationToken()
    @authenticate('token', {token: token}, options) if token

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

  getAuthenticationToken: ->
    $.cookie(@config.tokenCookieName)

  setAuthenticationToken: (token) ->
    @authenticationToken = token
    $.cookie @config.tokenCookieName, token, path: '/'

  removeAuthenticationToken: ->
    @authenticationToken = null
    $.removeCookie @config.tokenCookieName, path: '/'

  triggerStarted: ->
    $(document).trigger 'started.authentication'

  triggerAuthenticated: (data, strategy) ->
    $(document).trigger 'authenticated.authentication', {strategy: strategy, data: data}

  triggerConfirmation: (data, strategy) ->
    $(document).trigger 'confirmation.authentication', {strategy: strategy, data: data}

  triggerError: (data, strategy) ->
    $(document).trigger 'error.authentication', {strategy: strategy, data: data}

  triggerUnauthenticated: (data, strategy) ->
    $(document).trigger 'unauthenticated.authentication', {strategy: strategy, data: data}

  triggerClientSuccess: (data, client) ->
    $(document).trigger 'clientsuccess.authentication', {client: client, data: data}

  triggerClientFailure: (data, client) ->
    $(document).trigger 'clientfailure.authentication', {client: client, data: data}
