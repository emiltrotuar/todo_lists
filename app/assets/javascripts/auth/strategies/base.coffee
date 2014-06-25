class @Authentication.Strategies.Base
  strategyLoading: null

  constructor: (@authentication, @params = {}, @options = {}) ->

  authenticate: ->
    validationResult = @validate(@params)
    if validationResult == true
      @authentication.triggerStarted()
      @strategyLoading = true
      $.ajax @ajaxSettings()
    else
      @strategyLoading = false
      @errorCallback({responseJSON: validationResult}, 'error', null)
    @

  ajaxSettings: ->
    dataType: @dataType()
    method: @method()
    url: @url()
    data: @data()
    headers: @headers()
    success: @successCallback
    error: @errorCallback

  dataType: ->
    'json'

  headers: ->
    'Content-Type':  "application/json; utf-8"
    'token': @authentication.config.csrf_token

  method: ->
    throw 'Method `method` not implemented'

  url: ->
    throw 'Method `url` not implemented'

  data: ->
    throw 'Method `data` not implemented'

  validate: (params) ->
    throw 'Method `validate` not implemented'

  successCallback: (data, textStatus, xhr) =>
    @strategyLoading = false
    @authentication.setAuthenticationToken xhr.getResponseHeader('x-authentication-token');
    @authentication.triggerAuthenticated(data, @name)
    @options.success(data, textStatus, xhr) if @options and @options.success

  errorCallback: (xhr, textStatus, errorThrown) =>
    @strategyLoading = false
    error = xhr.responseJSON || textStatus
    @authentication.removeAuthenticationToken()
    @authentication.triggerError(error, @name)
    @options.error(xhr, textStatus, errorThrown) if @options and @options.error
