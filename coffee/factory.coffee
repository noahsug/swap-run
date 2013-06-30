exports.Factory = class Factory
  @create: (factoryClass, type) ->
    factoryClass.instance ?= new factoryClass
    factoryClass.instance.create type

  create: (@type_) ->
    if @type_ of @creationMethods_
      result = @creationMethods_[@type_].apply(this)
      return @processResult_ result
    else
      throw "type '#{@type_}' was not found"

  processResult_: (result) ->
    result
