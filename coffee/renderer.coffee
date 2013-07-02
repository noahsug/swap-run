{Animation} = require "../coffee/animation.coffee"
{GraphicFactory} = require "../coffee/graphic_factory.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"

exports.Renderer = class Renderer
  constructor: (@gameInfo_) ->
    @prevState_ = 'none'
    @backgroundGraphic_ = GraphicFactory.create 'background'
    @initAnimations_()

  initAnimations_: ->
    @fadeToBlackAnimation_ = new Animation
    @fadeToBlackAnimation_.vary('alpha').from(0).to(1).forDuration(1)

  update: (dt) ->
    switch @gameInfo_.getState()
      when 'dying' then @fadeToBlackAnimation_.update dt

  draw: ->
    switch @gameInfo_.getState()
      when 'playing' then @drawPlayScreen_()
      when 'dying' then @drawDyingScreen_()
      when 'lost' then @drawScoreScreen_()
    @prevState_ = @gameInfo_.getState()

  drawPlayScreen_: ->
    @drawBackground_()
    @drawEntities_()

  drawBackground_: ->
    atom.context.clearRect 0, 0, atom.width, atom.height
    @backgroundGraphic_.fill atom.context, 0, 0, atom.width, atom.height

  drawEntities_: ->
    for entity in @gameInfo_.getEntities().sort @yCoordComparator_
      entity.draw atom.context

  yCoordComparator_: (e1, e2) ->
    e1.getPos().y > e2.getPos().y

  drawDyingScreen_: ->
    @drawPlayScreen_()
    @fadeToBlack_()

  fadeToBlack_: ->
    if @prevState_ is 'playing'
      @fadeToBlackAnimation_.start()
    atom.context.setAlpha @fadeToBlackAnimation_.get 'alpha'
    atom.context.fillStyle = 'black'
    atom.context.fillRect 0, 0, atom.width, atom.height
    atom.context.setAlpha 1

  deathAnimationFinished: ->
    @fadeToBlackAnimation_.isFinished()

  drawScoreScreen_: ->
    @drawDyingScreen_()
    @drawScore_()

  drawScore_: ->
    atom.context.fillStyle = 'white'
    atom.context.textAlign = "center"
    atom.context.font = "100px helvetica"
    atom.context.fillText "score: #{@gameInfo_.getScore()}",
        atom.width / 2, atom.height / 2
