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
        a < @actual < b

      toBeAnInstanceOf: (clazz) ->
        @actual instanceof clazz

      toAlmostBe: (expected, sigDigAccuracy=4) ->
        @actual.toFixed(sigDigAccuracy) is expected.toFixed(sigDigAccuracy)

      toBeLessThanOrEqualTo: (expected) ->
        @actual <= expected

      toBeLessThanOrEqualTo: (expected, sigDigAccuracy=4) ->
        @actual <= expected

      toAlmostBeLessThanOrEqualTo: (expected, sigDigAccuracy=4) ->
        actual = parseFloat @actual.toFixed(sigDigAccuracy)
        expected = parseFloat expected.toFixed(sigDigAccuracy)
        actual <= expected
