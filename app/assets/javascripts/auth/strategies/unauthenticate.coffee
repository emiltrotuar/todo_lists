class @Authentication.Strategies.Unauthenticate extends @Authentication.Strategies.Base
  validate: (params) ->
    true

  method: ->
    'DELETE'

  data: ->
    JSON.stringify({})

  headers: ->
    $.extend super(), {'X-CSRF-Token' : @authentication.config.csrf_token}

  url: ->
    '/users/sign_out.json'

  successCallback: (data, textStatus, xhr) ->
    @strategyLoading = false
    @authentication.removeAuthenticationToken()
    @authentication.triggerUnauthenticated(data, @name)
    @options.success(data, textStatus, xhr) if @options and @options.success
    