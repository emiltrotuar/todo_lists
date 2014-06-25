class @Authentication.Strategies.Token extends @Authentication.Strategies.Base
  validate: (params) ->
    return {error: 'Params are empty', object: 'params'} unless params
    return {error: 'Token is missing', object: 'token'} unless params.token
    return {error: 'Token is not a string', object: 'token'} unless typeof params.token is 'string'
    return true

  headers: ->
    $.extend super(), {'Authorization': "Token token=#{@params.token}"}

  method: ->
    'GET'

  url: ->
    '/users/me'

  data: ->
    {}
