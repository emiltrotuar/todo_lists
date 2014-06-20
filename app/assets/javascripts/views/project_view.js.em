class TodoLists.ProjectView extends Ember.View

  unFolded: true

  actions:
    toggleList: ->
      @.$(".task_list").slideToggle "slow"
      @unFolded = not @unFolded

  didInsertElement: ->
    @.$(".task_input").focus()
