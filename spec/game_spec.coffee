{EntityFactory} = require "../coffee/entity_factory.coffee"
{Game} = require "../coffee/game.coffee"
{MoveBehavior} = require "../coffee/move_behavior.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{jasmine_env} = require "../spec/jasmine_env.coffee"
{util} = require "../coffee/util.coffee"

describe "A game", ->
  game = gameInfo = state = enemies = player = undefined
  dt = .03

  tick = (num=1) ->
    for i in [1..num]
      game.update dt
    player = gameInfo.getPlayer()
    state = gameInfo.getState()
    enemies = gameInfo.getEnemies()
    game.renderer_.draw()

  addEnemy = (pos, type='enemy') ->
    enemy = EntityFactory.create type
    game.addEnemy_ enemy
    enemy.setPos pos

  beforeEach ->
    jasmine_env.init this
    game = new Game()
    gameInfo = game.gameInfo_

  getEnemy = (num) ->
    gameInfo.getEnemies()[num]

  stopEnemyMovement = ->
    for enemy in enemies
      enemy.setMoveBehavior new MoveBehavior()
      enemy.velocityVector_ = { x: 0, y: 0 }
    gameInfo.getLevel().on 'spawn', (enemy) =>
      enemy.setMoveBehavior new MoveBehavior()

  startNextLevel = ->
    stopEnemyMovement()
    tick 40 / dt

    atom.input.press 'swap'
    tick()
    atom.input.release 'swap'

  it "is initially in the 'level intro' state", ->
    expect(gameInfo.getState()).toBe 'level intro'

  describe "in the 'playing' state", ->

    beforeEach ->
      atom.input.press 'swap'
      tick()
      atom.input.release 'swap'
      tick()

    it "is in the 'playing' state", ->
      expect(state).toBe 'playing'

    it "has a player that starts in the center of the screen", ->
      expect(player.getPos()).toEqual { x: 50, y: 75 }

    it "has enemies that closes in on the player", ->
      distance = util.distance player.getPos(), getEnemy(0).getPos()
      tick()
      updatedDistance = util.distance player.getPos(), getEnemy(0).getPos()
      expect(updatedDistance - distance).toBeLessThan 0

    it "ends when an enemy collides with a player", ->
      getEnemy(0).setReactionTime 0
      x = player.getPos().x + getEnemy(0).getRadius() + player.getRadius()
      y = player.getPos().y
      getEnemy(0).setPos { x, y }
      game.checkCollisions_()
      expect(player.isActive()).toBe true
      expect(state).toBe 'playing'

      tick()
      expect(state).toBe 'lost'

    it "kills enemies when they collide with each other", ->
      addEnemy getEnemy(0).getPos()
      expect(enemies.length).toBe 2
      tick()
      expect(enemies.length).toBe 0

    it "has enemies that are removed when they collide", ->
      addEnemy x: 10, y: 10
      getEnemy(0).setPos x: 15, y: 13

    it "keeps track of score", ->
      addEnemy getEnemy(0).getPos()
      tick()
      expect(gameInfo.getScore()).toBe 2

    it "scores the enemy that hits the player", ->
      getEnemy(0).setPos player.getPos()
      tick()
      expect(gameInfo.getScore()).toBe 1

    it "has a player that swaps position when the swap key is pressed", ->
      getEnemy(0).setPos x: 30, y: 50
      player.setPos x: 70, y: 100
      origPlayerPos = player.getPos()
      origEnemyPos = getEnemy(0).getPos()
      atom.input.press 'swap'
      tick()
      expect(getEnemy(0).getPos()).toEqual origPlayerPos
      playerDistanceFromOrigEnemyPos = util.distance origEnemyPos, player.getPos()
      distanceEnemyTravelled = getEnemy(0).getSpeed() * dt
      expect(playerDistanceFromOrigEnemyPos).toAlmostBeLessThanOrEqualTo distanceEnemyTravelled

    it "eventually ends if the player doesn't move", ->
      tick 70
      expect(state).toBe 'lost'

    it "doesn't accept input until the death animation has finished", ->
      getEnemy(0).setPos player.getPos()
      tick()
      expect(state).toBe 'lost'

      atom.input.press 'swap'
      tick()
      atom.input.release 'swap'
      expect(state).toBe 'lost'

      game.renderer_.lostAnimationFinished = -> true
      tick()
      expect(state).toBe 'lost'

      atom.input.press 'swap'
      tick()
      expect(state).toBe 'playing'

    it "can be reset after it ends", ->
      game.renderer_.lostAnimationFinished = -> true
      getEnemy(0).setPos player.getPos()
      tick 1
      expect(state).toBe 'lost'

      atom.input.press 'swap'
      tick()
      expect(state).toBe 'playing'
      expect(gameInfo.getPlayer().getPos()).toEqual x: 50, y: 75
      expect(enemies.length).toBe 0

    it "stops spawning entities after it has ended", ->
      getEnemy(0).setPos player.getPos()
      tick()
      expect(enemies.length).toBe 0
      tick 20
      expect(enemies.length).toBe 0

    it "can be paused and unpaused", ->
      atom.input.press 'pause'
      tick()
      expect(state).toBe 'paused'
      tick()
      expect(state).toBe 'playing'

    it "can only be paused when game is running", ->
      getEnemy(0).setPos player.getPos()
      tick()
      expect(state).not.toBe 'playing'
      atom.input.press 'pause'
      tick()
      expect(state).not.toBe 'paused'

    it "limits the time difference between updates", ->
      startingPos = player.getPos()
      atom.input.press 'up'
      game.update 100
      distance = util.distance startingPos, player.getPos()
      expect(distance).toAlmostBe .075 * player.getSpeed()

    it "changes to 'level intro' state after beating a level", ->
      stopEnemyMovement()
      tick 40 / dt
      expect(state).toBe 'level intro'
      expect(gameInfo.getLevel().getNumber()).toBe 2

    it "changes to 'beat game' state after beating the final level", ->
      startNextLevel()
      expect(state).toBe 'playing'

      stopEnemyMovement()
      tick 40 / dt
      expect(state).toBe 'beat game'

      atom.input.press 'swap'
      tick()
      expect(state).toBe 'playing'
      expect(gameInfo.getLevel().getNumber()).toBe 1

    it "resets entities when starting a new level", ->
      atom.input.press 'up'
      tick()
      atom.input.release 'up'
      startNextLevel()
      expect(enemies.length).toBe 0
      expect(gameInfo.getPlayer().getPos()).toEqual x: 50, y: 75
      expect(gameInfo.getPlayer().moveBehavior_.getVelocityVector()).toEqual x: 0, y: 0
