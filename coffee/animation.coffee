exports.Animation = class Animation
  constructor: ->
    @vars_ = {}
    @currentVar_ = null

  vary: (varName) ->
    @currentVar_ = @vars_[varName] = {}
    this

  from: (startValue) ->
    @currentVar_.startValue = startValue
    this

  to: (endValue) ->
    @currentVar_.endValue = endValue
    this

  forDuration: (duration) ->
    @currentVar_.duration = duration
    this

  get: (varName) ->
    @vars_[varName].value

  start: ->
    for varName, animationVar of @vars_
      animationVar.startValue ?= 0
      animationVar.value = animationVar.startValue
      animationVar.elapsed = 0

  update: (dt) ->
    for varName, animationVar of @vars_
      continue if @varIsFinished_ animationVar
      animationVar.elapsed += dt
      percentDone = animationVar.elapsed / animationVar.duration
      percentDone = 1 if percentDone > 1
      valueRange = animationVar.endValue - animationVar.startValue
      animationVar.value = animationVar.startValue + valueRange * percentDone

  varIsFinished_: (animationVar) ->
    not animationVar.elapsed? or animationVar.elapsed >= animationVar.duration

  isFinished: ->
    for varName, animationVar of @vars_
      return false unless @varIsFinished_ animationVar
    true
