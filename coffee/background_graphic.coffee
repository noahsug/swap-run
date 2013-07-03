{Graphic} = require "../coffee/graphic.coffee"

exports.BackgroundGraphic = class BackgroundGraphic extends Graphic
  constructor: (@tile_) ->
    super @tile_
    @tileGrid_ = {}
    @frameRatios_ = [1]

  setFrameOccurrenceRatios: (@frameRatios_) ->
    sum = @frameRatios_.reduce (a, b) -> a + b
    @frameRatios_ = (r / sum for r in @frameRatios_)

  fill: (context, xOffset, yOffset, width, height) ->
    return unless @isLoaded_()
    for col in [0..(width - 1) / @tile_.frameW]
      for row in [0..(height - 1) / @tile_.frameH]
        @selectFrame_ col, row
        x = xOffset + col * @tile_.frameW
        y = yOffset + row * @tile_.frameH
        @tile_.draw context, x, y

  selectFrame_: (col, row) ->
    key = "#{col},#{row}"
    frameNum = 0
    if key of @tileGrid_
      frameNum = @tileGrid_[key]
    else
      frameNum = @chooseFrameNumber_()
      @tileGrid_[key] = frameNum
    @goToFrame_ frameNum

  chooseFrameNumber_: ->
    sum = 0
    rand = Math.random()
    for ratio, frameNum in @frameRatios_
      sum += ratio
      return frameNum + 1 if rand <= sum

  goToFrame_: (frameNum) ->
    {row, col} = @tile_.frameNumberToRowCol frameNum
    @tile_.setFrame row, col
