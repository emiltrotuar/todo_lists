class @Authentication.Strategies.Token extends @Authentication.Strategies.Base
  headers: ->
    super

  method: ->
    'GET'

  url: ->
    '/users/me'

  data: ->
    {}
