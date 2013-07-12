{Animation} = require "../coffee/animation.coffee"
{EntitySpriteFactory} = require "../coffee/entity_sprite_factory.coffee"
{GraphicFactory} = require "../coffee/graphic_factory.coffee"
{Sprite} = require "../spec/mock/sprite_mock.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"

exports.Renderer = class Renderer
  constructor: (@gameInfo_) ->
    @prevState_ = 'none'
    @reset()
    @backgroundGraphic_ = GraphicFactory.create 'background'
    @initAnimations_()

  reset: ->
    @deathAnimations_ = []

  initAnimations_: ->
    @animations_ = []
    @lostAnimation_ = new Animation
    @lostAnimation_.vary('alpha').from(0).to(1).forDuration(2)
    @animations_.push @lostAnimation_

    @beatLevelAnimation_ = new Animation
    @beatLevelAnimation_.vary('alpha').from(0).to(1).forDuration(1)
    @animations_.push @beatLevelAnimation_

  update: (dt) ->
    for animation in @animations_
      animation.update dt

  draw: ->
    switch @gameInfo_.getState()
      when 'level intro' then @drawLevelIntroScreen_()
      when 'playing' then @drawPlayScreen_()
      when 'lost' then @drawLostScreen_()
      when 'paused' then @drawPauseScreen_()
      when 'beat game' then @drawBeatGameScreen_()
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

  drawLevelIntroScreen_: ->
    if @prevState_ is 'playing'
      @beatLevelAnimation_.start()
    if @beatLevelAnimationFinished()
      @drawBeatLevelAnimation_()
      @drawLevelIntroText_()
    else
      @drawPlayScreen_()
      @drawBeatLevelAnimation_()

  drawBeatLevelAnimation_: ->
    atom.context.setAlpha @beatLevelAnimation_.get 'alpha'
    atom.context.fillStyle = 'black'
    atom.context.fillRect 0, 0, atom.width, atom.height
    atom.context.setAlpha 1

  beatLevelAnimationFinished: ->
    @beatLevelAnimation_.isFinished()

  drawLevelIntroText_: ->
    text = "stage #{@gameInfo_.getLevel().getNumber()}"
    atom.context.fillStyle = 'white'
    atom.context.textAlign = 'center'
    atom.context.font = "50px Chelsea Market"
    atom.context.fillText text, atom.width / 2, atom.height / 2 - 60

    atom.context.font = "100px Chelsea Market"
    text = @gameInfo_.getLevel().getTitle()
    atom.context.fillText text, atom.width / 2, atom.height / 2 + 80

  drawLostScreen_: ->
    if @prevState_ is 'playing'
      @lostAnimation_.start()
    if @lostAnimationFinished()
      @drawLostAnimation_()
      @drawScore_()
    else
      @drawPlayScreen_()
      @drawLostAnimation_()

  drawLostAnimation_: ->
    atom.context.setAlpha @lostAnimation_.get 'alpha'
    atom.context.fillStyle = 'black'
    atom.context.fillRect 0, 0, atom.width, atom.height
    atom.context.setAlpha 1

  lostAnimationFinished: ->
    @lostAnimation_.isFinished()

  drawScore_: ->
    @broadcastMessage_ "score: #{@gameInfo_.getScore()}"

  drawPauseScreen_: ->
    if @prevState_ isnt 'paused'
      atom.context.setAlpha .75
      atom.context.fillStyle = 'black'
      atom.context.fillRect 0, 0, atom.width, atom.height
      atom.context.setAlpha 1
      @broadcastMessage_ "paused"

  drawBeatGameScreen_: ->
    atom.context.fillStyle = 'black'
    atom.context.fillRect 0, 0, atom.width, atom.height
    @broadcastMessage_ "victory is yours"

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
  Sprite.preloadImages images, {}
preloadImages()
