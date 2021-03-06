class App.TrashView extends Backbone.View
  events:
    'dragstart':        'start'
    'dragenter .trash': 'enter'
    'dragleave .trash': 'leave'
    'drop      .trash': 'trash'
    'drop':             'drop'

  render: ->
    @$el.append JST.trash()
    @trash = @el.querySelector '.trash'
    @trash.style.display = 'none'
    App.Dnd.install @trash, ['postit', 'line']
    @

  start: (e) ->
    classes = e.target.classList
    unless classes.contains 'resize' or classes.contains 'corner'
      @trash.style.display = 'block'
    true

  enter: ->
    @trash.classList.add 'hover'
    true

  leave: ->
    @trash.classList.remove 'hover'
    true

  trash: (originalEvent: e) ->
    [type, cid] = App.Dnd.get e
    if type == "text/koalab-line"
      collection = @model.lines
    else if type == "text/koalab-postit"
      collection = @model.postits
    else
      return true
    if el = collection.get cid
      el.destroy()
    e.preventDefault()
    false

  drop: (e) ->
    @trash.style.display = 'none'
    @trash.classList.remove 'hover'
    true
