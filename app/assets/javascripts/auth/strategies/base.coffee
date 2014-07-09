class @Authentication.Strategies.Base
  strategyLoading: null

  constructor: (@authentication, @params = {}, @options = {}) ->

  authenticate: ->
    $.ajax @ajaxSettings()

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
    'X-CSRF-Token': @authentication.config.csrf_token

  method: ->
    throw 'Method `method` not implemented'

  url: ->
    throw 'Method `url` not implemented'

  data: ->
    throw 'Method `data` not implemented'

  validate: (params) ->
    throw 'Method `validate` not implemented'

  successCallback: (data, textStatus, xhr) =>
    @options.success(data, textStatus, xhr) if @options and @options.success

  errorCallback: (xhr, textStatus, errorThrown) =>
    @options.error(xhr, textStatus, errorThrown) if @options and @options.error
