class TodoLists.FuzzySearchComponent extends Ember.TextField
  uiOptions: [
    'disabled'
    'autoFocus'
    'delay'
    'minLength'
    'position'
    'source'
  ]

  didInsertElement: ->
    options = @_gatherOptions()
    @ui = jQuery.ui.autocomplete(options, @element)

  willDestroyElement: ->
    @ui._destroy()

  _gatherOptions: ->
    uiOptions = @uiOptions
    options = {}
    uiOptions.forEach ((key) ->
      result = @_applyIfFunction(key)
      options[key] = result
    ), @
    options

  _applyIfFunction: (key) ->
    c = @get('controller-i')
    val = @get(key)
    if typeof val is 'function'
      result = -> 
        val.apply c, arguments
    else
      result = val
