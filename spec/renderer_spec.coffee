{Entity} = require "../coffee/entity.coffee"
{GameInfo} = require "../coffee/game_info.coffee"
{Renderer} = require "../coffee/renderer.coffee"
{Sprite} = require "../spec/mock/sprite_mock.coffee"

describe "A renderer", ->
  callCount = renderer = gameInfo = undefined

  beforeEach ->
    gameInfo = new GameInfo
    renderer = new Renderer gameInfo
    callCount = 0

  addEntityAtPos = (pos) ->
    entity = new Entity
    entity.setPos pos
    gameInfo.addEnemy entity
    entity.draw = -> entity.drawCallOrder = callCount++
    entity

  it "draws entities in ascending order by y-coordinate", ->
    gameInfo.setState 'playing'
    entity1 = addEntityAtPos x: 49, y: 82
    entity2 = addEntityAtPos x: 32, y: 0
    entity3 = addEntityAtPos x: 0, y: 33
    entity4 = addEntityAtPos x: 98, y: 24
    renderer.draw()
    expect(entity2.drawCallOrder).toBeLessThan entity4.drawCallOrder
    expect(entity4.drawCallOrder).toBeLessThan entity3.drawCallOrder
    expect(entity3.drawCallOrder).toBeLessThan entity1.drawCallOrder

  it "preloads images", ->
    expectedFileNames = [ 'bat.png', 'bald_female.png', 'deathknight.png'
        'skeleton.png', 'ogre.png', 'spectre.png', 'death.png', 'sand_tile.png' ]
    expectedFilePaths = ("../assets/#{name}" for name in expectedFileNames)
    for expectedFilePath in expectedFilePaths
      expect(Sprite.preloadedImages).toContain expectedFilePath
