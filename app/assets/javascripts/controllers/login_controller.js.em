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
      options =
        error: (data) =>
          console.log event, data
        success: (data) =>
          console.log event, data
          TodoLists.authenticated = true
          @transitionToRoute 'projects'
      TodoLists.authentication.authenticate 'password', params, options
