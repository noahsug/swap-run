exports.Position =

  equals: (pos1, pos2) ->
    pos1.x == pos2.x and pos1.y == pos2.y

  clone: (pos) ->
    { x: pos.x, y: pos.y }
