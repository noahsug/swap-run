{keybindings} = require "../coffee/keybindings.coffee"

exports.jasmine_env =

  init: (@test) ->
    keybindings.configure = ->
    @addMatchers_()

  addMatchers_: ->
    @test.addMatchers
      toBeBetween: (a, b) ->
        return a < this.actual < b
