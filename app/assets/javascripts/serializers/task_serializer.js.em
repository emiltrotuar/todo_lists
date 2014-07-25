class TodoLists.TaskSerializer extends DS.ActiveModelSerializer

  keyForRelationship: (key, kind) ->
    key = Ember.String.decamelize(key)
    if kind is "hasMany"
      singularize(key) + "_ids"
    else
      key
