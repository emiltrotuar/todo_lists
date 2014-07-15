class @Authentication.Strategies.Base
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
    'X-TL-Client': 'application'
    'X-CSRF-Token': @authentication.config.csrfToken

  method: ->
    throw 'Method `method` not implemented'

  url: ->
    throw 'Method `url` not implemented'

  data: ->
    throw 'Method `data` not implemented'

  validate: (params) ->
    throw 'Method `validate` not implemented'

  successCallback: (data, textStatus, xhr) =>
    @authentication.config.csrfToken = xhr.getResponseHeader('X-CSRF-Token')
    @options.success(data, textStatus, xhr) if @options and @options.success

  errorCallback: (xhr, textStatus, errorThrown) =>
    @options.error(xhr, textStatus, errorThrown) if @options and @options.error
