#= require jquery
#= require jquery.ui.all
#= require jquery_ujs
#= require bootstrap
#= require jquery
#= require handlebars
#= require ember
#= require ember-data
#= require localstorage_adapter
#= require_self
#= require todo_lists

window.TodoLists = Ember.Application.create()

#class TodoLists.ApplicationAdapter extends DS.LSAdapter
  #namespace: 'todo-lists'

TodoLists.ApplicationAdapter = DS.FixtureAdapter
