{Game} = require "../coffee/game.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{jasmine_env} = require "../spec/jasmine_env.coffee"

describe "A game", ->
  game = player = undefined
  atom.width = 100
  atom.height = 150

  beforeEach ->
    jasmine_env.init this
    game = new Game()

  play = ->


  describe "has a player", ->

    beforeEach ->
      player = game.player_

    it "starts in the center of the screen", ->
      expect(player.getPos()).toEqual { x: 50, y: 75 }
