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
    