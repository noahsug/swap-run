exports.Position =

  equals: (pos1, pos2) ->
    pos1.x == pos2.x and pos1.y == pos2.y

  add: (pos1, pos2) ->
    x: pos1.x + pos2.x, y: pos1.y + pos2.y

  subtract: (pos1, pos2) ->
    x: pos1.x - pos2.x, y: pos1.y - pos2.y

  negate: (pos) ->
    x: -pos.x, y: -pos.y

  clone: (pos) ->
    { x: pos.x, y: pos.y }
