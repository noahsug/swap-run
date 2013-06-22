{util} = require '../coffee/util.coffee'

describe 'Util functions:', ->

  describe 'shuffle', ->
    it 'randomizes the order of an array in place', ->
      shuffled = [0..19]
      util.shuffle shuffled
      diff = (ele for ele, i in shuffled when ele isnt i)
      expect(diff.length).toBeGreaterThan 0

    it 'keeps the elements of the original array', ->
      original = [1, 2, 3, 4, 5, 'c', 'e', 'f']
      shuffled = util.shuffle original[..]
      expect(shuffled.length).toBe original.length
      for i in original
        expect(shuffled).toContain i

    it 'does nothing to an array of size < 2', ->
      arr = util.shuffle [1]
      expect(arr).toEqual [1]

      arr = util.shuffle []
      expect(arr).toEqual []

  describe 'randInt', ->
    it 'returns an int in range [min, max]', ->
      min = 13
      max = 17
      for i in [1..20]
        expect(min <= util.randInt(min, max) <= max).toBe true

    it 'returned int is inclusive of the min and max', ->
      min = 9
      max = 12
      wasMin = wasMax = false
      for i in [1..40]
        result = util.randInt(min, max)
        wasMin or= result is min
        wasMax or= result is max
      expect(wasMin and wasMax).toBe true

    it 'defaults min to 0', ->
      max = 8
      for i in [1..20]
        expect(0 <= util.randInt(max) <= max).toBe true

  describe 'bound', ->
    it 'ensures a value is >= min', ->
      result = util.bound 3, 5, 10
      expect(result).toBe 5

    it 'ensures a value is <= max', ->
      result = util.bound 100, 5, 10
      expect(result).toBe 10

    it 'does nothing when a value is within [min, max]', ->
      result = util.bound 7, 5, 10
      expect(result).toBe 7
      result = util.bound 5, 5, 10
      expect(result).toBe 5
      result = util.bound 10, 5, 10
      expect(result).toBe 10

    it 'throws an error when max < min', ->
      expect(-> util.bound 3, 10, 5).toThrow()

  describe 'distance', ->
    it 'determines the distance between two points', ->
      point1 = { x: 1, y: 2 }
      point2 = { x: 4, y: 6 }
      expect(util.distance point1, point2).toBe 5

  describe 'distanceSquared', ->
    it 'determines the squared distance between two points', ->
      point1 = { x: 1, y: 2 }
      point2 = { x: 4, y: 6 }
      expect(util.distanceSquared point1, point2).toBe 25

  describe 'sign', ->
    it 'returns 1 if value >= 0', ->
      expect(util.sign 6).toBe 1
      expect(util.sign 0).toBe 1

    it 'returns -1 if value > 0', ->
      expect(util.sign -7).toBe -1
      expect(util.sign -.00001).toBe -1
