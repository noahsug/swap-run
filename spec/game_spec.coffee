{EntityFactory} = require "../coffee/entity_factory.coffee"
{Game} = require "../coffee/game.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{jasmine_env} = require "../spec/jasmine_env.coffee"
{util} = require "../coffee/util.coffee"

describe "A game", ->
  game = player = undefined
  atom.width = 100
  atom.height = 150

  tick = (num=1) ->
    for i in [1..num]
      game.update .05

  addEnemy = (pos) ->
    enemy = EntityFactory.create 'enemy'
    enemy.setPos pos
    game.addEnemy_ enemy

  beforeEach ->
    jasmine_env.init this
    game = new Game()
    player = game.getPlayer()
    tick()

  getEnemy = (num) ->
    game.getEnemies()[num]

  it "has a player that starts in the center of the screen", ->
    expect(player.getPos()).toEqual { x: 50, y: 75 }

  it "has enemies that closes in on the player", ->
    distance = util.distance player.getPos(), getEnemy(0).getPos()
    tick()
    updatedDistance = util.distance player.getPos(), getEnemy(0).getPos()
    expect(updatedDistance - distance).toBeLessThan 0

  it "ends when an enemy collides with a player", ->
    x = player.getPos().x + getEnemy(0).getRadius() + player.getRadius()
    y = player.getPos().y
    getEnemy(0).setPos { x, y }

    game.checkCollisions_()
    expect(game.getState()).toBe 'playing'
    tick()
    expect(game.getState()).toBe 'lost'

  it "kills enemies when they collide with each other", ->
    addEnemy getEnemy(0).getPos()
    expect(game.getEnemies().length).toBe 2
    tick()
    expect(game.getEnemies().length).toBe 0

  it "eventually ends if the player doesn't move", ->
    tick 20
    expect(game.getState()).toBe 'lost'

  it "can be reset after it ends", ->
    tick 20
    atom.input.press 'swap'
    tick()
    expect(game.getState()).toBe 'playing'
    expect(game.getPlayer().getPos()).toEqual x: 50, y: 75
    expect(game.getEnemies().length).toBe 0

  it "has enemies that are removed when they collide", ->
    addEnemy x: 10, y: 10
    getEnemy(0).setPos x: 15, y: 13

  it "keeps track of score", ->
    addEnemy getEnemy(0).getPos()
    tick()
    expect(game.getScore()).toBe 2
