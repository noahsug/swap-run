{Entity} = require "../coffee/entity.coffee"
{Renderer} = require "../coffee/renderer.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{keybindings} = require "../coffee/keybindings.coffee"

exports.Game = class Game extends atom.Game

  constructor: ->
    super
    keybindings.configure()
    @initPlayer_()
    @renderer_ = new Renderer()

  initPlayer_: ->
    @player_ = new Entity
    @player_.setPos { x: atom.width / 2, y: atom.height / 2 }

  update: (dt) ->
    @player_.update(dt)

  draw: ->
    @renderer_.draw @player_
