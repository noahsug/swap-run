exports.EventEmitter = class EventEmitter
  constructor: ->
    @eventCallbacks_ = {}

  on: (event, callback) ->
    (@eventCallbacks_[event] ?= []).push callback

  emit: (event, args...) ->
    return unless event of @eventCallbacks_
    for callback in @eventCallbacks_[event]
      callback(args...)
