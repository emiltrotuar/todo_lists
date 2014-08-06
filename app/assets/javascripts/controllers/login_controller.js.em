class TodoLists.LoginController extends Ember.ObjectController
  
  actions:
    toggleForm: ->
      $("#login_form").slideToggle "slow"

    loginUser: ->
      formElements = $("form").serializeArray()
      params = {}
      $.each formElements, (index, value) ->
        params[value.name] = value.value
      params =
        user:
          email: params.email
          password: params.password
      success = (data) =>
        console.log event, data
        TodoLists.authenticated = true
        @transitionToRoute 'projects'
      error = (data) =>
        console.log event, data
      TodoLists.authentication.authenticate('password', params).then success, error
