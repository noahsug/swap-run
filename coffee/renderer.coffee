{Animation} = require "../coffee/animation.coffee"
{EntitySpriteFactory} = require "../coffee/entity_sprite_factory.coffee"
{GraphicFactory} = require "../coffee/graphic_factory.coffee"
{Sprite} = require "../spec/mock/sprite_mock.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"

exports.Renderer = class Renderer
  constructor: (@gameInfo_) ->
    @prevState_ = 'none'
    @deathAnimations_ = []
    @backgroundGraphic_ = GraphicFactory.create 'background'
    @initAnimations_()

  initAnimations_: ->
    @fadeToBlackAnimation_ = new Animation
    @fadeToBlackAnimation_.vary('alpha').from(0).to(1).forDuration(2)

  update: (dt) ->
    switch @gameInfo_.getState()
      when 'dying' then @fadeToBlackAnimation_.update dt

  draw: ->
    switch @gameInfo_.getState()
      when 'playing' then @drawPlayScreen_()
      when 'dying' then @drawDyingScreen_()
      when 'lost' then @drawScoreScreen_()
      when 'paused' then @drawPauseScreen_()
    @prevState_ = @gameInfo_.getState()

  drawPlayScreen_: ->
    @drawBackground_()
    @drawEntities_()
    @drawDeaths_()

  drawBackground_: ->
    atom.context.clearRect 0, 0, atom.width, atom.height
    @backgroundGraphic_.fill atom.context, 0, 0, atom.width, atom.height

  drawEntities_: ->
    entities = @gameInfo_.getEntities().sort @yCoordComparator_
    for entity in entities
      @drawShadow_ entity
    for entity in entities
      entity.draw atom.context

  drawDeaths_: ->
    for deathAnimation in @deathAnimations_
      deathAnimation.draw atom.context
    @deathAnimations_ = (a for a in @deathAnimations_ when a.isAnimating())

  yCoordComparator_: (e1, e2) ->
    e1.getPos().y > e2.getPos().y

  drawShadow_: (entity) ->
    atom.context.setAlpha .35
    atom.context.fillStyle = 'black'
    @fillEllipseFromCenter_ entity.getPos().x, entity.getPos().y,
        entity.getRadius() * 2, entity.getRadius()
    atom.context.setAlpha 1

  fillEllipseFromCenter_: (cx, cy, w, h) ->
    @fillEllipse_(cx - w/2.0, cy - h/2.0, w, h)

  fillEllipse_: (x, y, w, h) ->
    kappa = .5522848
    ox = (w / 2) * kappa
    oy = (h / 2) * kappa
    xe = x + w
    ye = y + h
    xm = x + w / 2
    ym = y + h / 2
    ctx = atom.context

    ctx.beginPath()
    ctx.moveTo(x, ym)
    ctx.bezierCurveTo(x, ym - oy, xm - ox, y, xm, y)
    ctx.bezierCurveTo(xm + ox, y, xe, ym - oy, xe, ym)
    ctx.bezierCurveTo(xe, ym + oy, xm + ox, ye, xm, ye)
    ctx.bezierCurveTo(xm - ox, ye, x, ym + oy, x, ym)
    ctx.fill()
    ctx.closePath()

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

  playerDeathAnimationFinished: ->
    @fadeToBlackAnimation_.isFinished()

  drawScoreScreen_: ->
    @drawDyingScreen_()
    @drawScore_()

  drawScore_: ->
    @broadcastMessage_ "score: #{@gameInfo_.getScore()}"

  drawPauseScreen_: ->
    if @prevState_ isnt 'paused'
      atom.context.setAlpha .75
      atom.context.fillStyle = 'black'
      atom.context.fillRect 0, 0, atom.width, atom.height
      atom.context.setAlpha 1
      @broadcastMessage_ "paused"

  broadcastMessage_: (text) ->
    atom.context.fillStyle = 'white'
    atom.context.textAlign = "center"
    atom.context.font = "100px Chelsea Market"
    atom.context.fillText text, atom.width / 2, atom.height / 2

  drawEntityDeath: (entity) ->
    deathAnimation = GraphicFactory.create 'death'
    deathAnimation.runOnce()
    deathAnimation.setPos entity.getGraphic().getCenter()
    @deathAnimations_.push deathAnimation

preloadImages = ->
  images = (m for m in EntitySpriteFactory.getImagesToPreload())
  images.push (m for m in GraphicFactory.getImagesToPreload())...
  Sprite.preloadImages images
preloadImages()
