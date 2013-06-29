exports.util =

  # Randomize the order of the elements in a given array in place
  shuffle: (arr) ->
    return arr if arr.length < 2
    for i in [0..arr.length - 2]
      swapIndex = @randInt i, arr.length - 1
      @swap arr, i, swapIndex
    return arr

  # Swap two elements in an array
  swap: (arr, index1, index2) ->
    [arr[index2], arr[index1]] = [arr[index1], arr[index2]]

  # Return an integer in the range [min, max]
  randInt: (min, max) ->
    if arguments.length is 1
      [min, max] = [0, min]
    throw "min must be <= max, but #{min} > #{max}" if min > max
    Math.floor(Math.random() * (max + 1 - min) + min)

  # Return a random element from the given array
  randElement: (arr) ->
    return arr[@randInt arr.length - 1]

  bound: (value, min, max) ->
    throw "max (${max}) must be >= to min (${min})" if max < min
    if value < min
      value = min
    if value > max
      value = max
    return value

  distance: (a, b) ->
    Math.sqrt @distanceSquared a, b

  distanceSquared: (a, b) ->
    Math.pow(a.x - b.x, 2) + Math.pow(a.y - b.y, 2)

  sign: (num) ->
    if num < 0 then -1 else 1

  flipCoin: ->
    Math.random() < .5
