{Position} = require "../coffee/position.coffee"

describe "Position provides the following helper functions", ->
  describe "equals", ->
    it "returns true when positions have the same x and y values", ->
      pos1 = { x: 0, y: 1}
      pos2 = { x: 0, y: 1}
      expect(Position.equals pos1, pos2).toBe true

    it "returns false when positions have different x and y values", ->
      pos1 = { x: 0, y: 1}
      pos2 = { x: 0, y: 2}
      expect(Position.equals pos1, pos2).toBe false

  describe "clone", ->
    it "makes an equal clone of a position", ->
      orig = { x: 1, y: 2}
      clone = Position.clone orig
      expect(Position.equals orig, clone).toBe true

    it "ensures changes to the original pos don't effect the clone'", ->
      orig = { x: 1, y: 2}
      clone = Position.clone orig
      orig.x = 5
      expect(Position.equals orig, clone).toBe false

  describe "add", ->
    it "adds two positions together", ->
      pos1 = x: 5, y: 1
      pos2 = x: 3, y: 9
      expect(Position.add pos1, pos2).toEqual { x: 8, y: 10 }

  describe "subtract", ->
    it "subtracts two positions from each other", ->
      pos1 = x: 5, y: 1
      pos2 = x: 3, y: 9
      expect(Position.subtract pos1, pos2).toEqual { x: 2, y: -8 }

  describe "negate", ->
    it "returns the point with its coordinate multiplied by -1", ->
      pos = x: 5, y: -1
      expect(Position.negate pos).toEqual { x: -5, y: 1 }
