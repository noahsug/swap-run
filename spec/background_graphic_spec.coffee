{GraphicFactory} = require "../coffee/graphic_factory.coffee"

describe 'A background graphic', ->
  bg = undefined

  beforeEach ->
    bg = GraphicFactory.create 'background'

  it 'fills an area with background tiles', ->
    spyOn bg.tile_, 'draw'
    bg.fill 'context', 10, 50, 20, 60
    for x in [10..20] by 10
      for y in [50..100] by 10
        expect(bg.tile_.draw).toHaveBeenCalledWith 'context', x, y
    expect(bg.tile_.draw.callCount).toBe 12

  it 'selects tiles randomly based on the given frame occurrence ratios', ->
    bg.setFrameOccurrenceRatios [1, .5, 0]
    frameCounts = [0, 0, 0]
    bg.tile_.setFrame = (row, col) ->
      frameCounts[col - 1]++
    bg.fill 'context', 0, 0, 200, 200
    expect(frameCounts[0]).toBeGreaterThan frameCounts[1]
    expect(frameCounts[1]).toBeGreaterThan frameCounts[2]
    expect(frameCounts[2]).toBe 0

  it "doesn't throw an error when drawn before being loaded", ->
    bg.tile_.unload()
    bg.fill 0, 0, 100, 100
