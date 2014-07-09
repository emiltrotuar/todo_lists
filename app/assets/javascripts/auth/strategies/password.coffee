class @Authentication.Strategies.Password extends @Authentication.Strategies.Base
  emailRegex: /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

  validate: (params) ->
    return {error: 'Params is empty', object: 'params'} unless params
    return {error: 'Params does not contain user', object: 'user'} unless params.user
    return {error: 'User in params object is not an object', object: 'user'} unless typeof params.user is 'object'
    return {error: 'Email is empty', object: 'email'} unless params.user.email
    return {error: 'Email is not a string', object: 'email'} unless typeof params.user.email is 'string'
    return {error: 'Email is not valid', object: 'email'} unless @emailRegex.test(params.user.email)
    return {error: 'Password is empty', object: 'password'} unless params.user.password
    return {error: 'Password is not a string', object: 'password'} unless typeof params.user.password is 'string'
    return true

  headers: ->
    super

  method: ->
    'POST'

  url: ->
    '/users/sign_in.json'

  data: ->
    JSON.stringify(@params)
