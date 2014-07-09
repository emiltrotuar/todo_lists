class @Authentication.Strategies.Unauthenticate extends @Authentication.Strategies.Base
  validate: (params) ->
    true

  method: ->
    'DELETE'

  data: ->
    JSON.stringify({})

  headers: ->
    super

  url: ->
    '/users/sign_out.json'

  successCallback: (data, textStatus, xhr) ->
    @options.success(data, textStatus, xhr) if @options and @options.success
    