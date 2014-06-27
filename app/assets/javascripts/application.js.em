#= require jquery
#= require jquery.ui.all
#= require jquery.cookie
#= require bootstrap
#= require jquery
#= require handlebars
#= require ember
#= require ember-data
#= require localstorage_adapter
#= require_self
#= require todo_lists

Ember.Application.initializer
  name: 'authentication'
  initialize: (container, application) ->
    application.authentication = new Authentication
      csrf_token: $("meta[name='csrf-token']").attr('content')
    application.currentUser = null
    application.authenticated = false

    application.authsuccess = (data) ->
      console.log data
      application.authenticated = true
    application.unauthsuccess = (data) ->
      console.log data
    application.autherror = (data) ->
      console.log data
    application.authentication.start
      success: (data) => application.authsuccess(data)
      error: (data)   => application.autherror(data)

window.TodoLists = Ember.Application.create
  LOG_TRANSITIONS: true
  LOG_BINDINGS: true

Ember.TextField.reopen
  didInsertElement: ->
    @.$().focus()