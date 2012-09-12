class App.User extends Backbone.Model
  url: '/user'

  defaults:
    email: null

  isLogged: ->
    !! @get('email')

App.User.current = ->
  email = document.cookie.match /email=(\w+)/
  new App.User email: email
