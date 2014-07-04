TodoLists.NoteSerializer = DS.RESTSerializer.extend

  extractArray: (store, type, payload, id, requestType) ->
    TodoLists.rawNotes = payload.notes
    normalizedNotes = {}
    for note in payload.notes
      normalizedNotes[note.id] = note.content
    TodoLists.normalizedNotes = normalizedNotes
    super store, type, payload, id, requestType
