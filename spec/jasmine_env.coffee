{keybindings} = require "../coffee/keybindings.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"

exports.jasmine_env =

  init: (@test) ->
    atom.input.reset()
    keybindings.configure = ->
    @addMatchers_()

  addMatchers_: ->
    @test.addMatchers
      toBeBetween: (a, b) ->
        a < this.actual < b

      toBeAnInstanceOf: (clazz) ->
        this.actual instanceof clazz

      toAlmostBe: (expected) ->
        "#{this.actual}".indexOf("#{expected}") is 0
