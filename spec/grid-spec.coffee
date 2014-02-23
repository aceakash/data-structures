Grid = DataStructures.Grid

describe "new Grid(width, height, blankValue, items)", ->  
  it "should throw an error if either width or height is not an integer greater than 0", ->    
    try
      new Grid(0, 8)
      expect("an error to be thrown").toBe(true)
    catch e
      expect(true).toBe(true)
    try
      new Grid(0, 0)
      expect("an error to be thrown").toBe(true)
    catch e
      expect(true).toBe(true)
    try
      new Grid(8, 0)
      expect("an error to be thrown").toBe(true)
    catch e
      expect(true).toBe(true)
    try
      new Grid(-1, 2)
      expect("an error to be thrown").toBe(true)
    catch e
      expect(true).toBe(true)
    try
      new Grid(8, -7)
      expect("an error to be thrown").toBe(true)
    catch e
      expect(true).toBe(true)
    try
      new Grid(-1, -2)
      expect("an error to be thrown").toBe(true)
    catch e      

  it "should create an array of (width * height) elements", ->
    items = new Grid(2, 3).getItems()
    expect(items).toBeDefined()
    expect(items.length).toBeDefined()
    expect(items.length).toBe(6)
    
    items = new Grid(4, 4).getItems()
    expect(items.length).toBe(16)

  it "should instantiate all array items to blankValue", ->
    items = new Grid(3, 4).getItems()
    for item in items
      expect(item).toBeNull()
    
    items = new Grid(4, 5, -1).getItems()
    for item in items
      expect(item).toBe(-1)

    items = new Grid(41, 52, 'empty').getItems()
    for item in items
      expect(item).toBe('empty')

  it "should instantiate the grid with the values in items", ->
    grid = new Grid(3, 2, false, [3,5,7,6,5,4])
    expect(grid.getItems()).toEqual([3,5,7,6,5,4])
    
  it "shouldn't allow modification of items", ->
    blankValue = -1
    grid = new Grid(2, 3, blankValue)
    items = grid.getItems()
    items[0] = 'something'
    itemsAgain = grid.getItems()
    expect(itemsAgain[0]).toBe(blankValue)

describe "getDimensions", ->
  it "should return an object with the height and width of the grid", ->
    grid = new Grid(2, 3)
    expect(grid.getDimensions()).toEqual({ height: 3, width: 2})

describe "set(x, y, value)", ->
  it "should throw error if x is out of bounds", ->
    grid = new Grid(10, 20, -1)
    try
      grid.set(10, 1, 55)
      expect('x should be a number from 0 to less than the grid width').toBe(false)
    catch e
      expect(true).toBe(true)
    try
      grid.set(-1, 1, 55)
      expect('x should be a number from 0 to less than the grid width').toBe(false)
    catch e
      expect(true).toBe(true)

  it "should throw error if y is out of bounds", ->
    grid = new Grid(10, 20, -1)
    try
      grid.set(1, 21, 55)
      expect('y should be a number from 0 to less than the grid height').toBe(false)
    catch e
      expect(true).toBe(true)
    try
      grid.set(1, -1, 55)
      expect('y should be a number from 0 to less than the grid height').toBe(false)
    catch e
      expect(true).toBe(true)

  it "should set the specified value in the specified position", ->
    grid = new Grid(2, 3, -1)
    grid.set(1, 2, 55)
    grid.set(0, 0, 33)
    grid.set(0, 1, 22)
    items = grid.getItems()
    expect(items[5]).toBe(55)
    expect(items[0]).toBe(33)
    expect(items[2]).toBe(22)

  it "should not change the values in the other positions", ->
    grid = new Grid(2, 3, -1)
    grid.set(1, 2, 55)
    grid.set(0, 0, 33)
    grid.set(1, 1, 22)
    for item, i in grid.getItems()      
      if i isnt 5 and i isnt 0 and i isnt 3
        expect(item).toBe(-1)

describe "get(x, y)", -> 
  it "should throw error if x is out of bounds", ->
    grid = new Grid(10, 20, -1)
    try
      grid.get(10, 1)
      expect('x should be a number from 0 to less than the grid width').toBe(false)
    catch e
      expect(true).toBe(true)
    try
      grid.get(-1, 1)
      expect('x should be a number from 0 to less than the grid width').toBe(false)
    catch e
      expect(true).toBe(true)  

  it "should throw error if y is out of bounds", ->
    grid = new Grid(10, 20, -1)
    try
      grid.get(1, 21)
      expect('y should be a number from 0 to less than the grid height').toBe(false)
    catch e
      expect(true).toBe(true)
    try
      grid.get(1, -1)
      expect('y should be a number from 0 to less than the grid height').toBe(false)
    catch e
      expect(true).toBe(true)

  it "should get the item at the specified position", ->
    grid = new Grid(5, 6, false)
    grid.set(2, 3, 'hello')
    grid.set(3, 4, 'world')
    expect(grid.get(2, 3)).toBe('hello')
    expect(grid.get(3, 4)).toBe('world')

describe "find(item)", ->
  it "should return an array of position {x, y} arrays", ->
    grid = new Grid(3, 3, false, [4,2,false,7,8,9,false,2,3])
    expect(grid.find(7)).toEqual([{x: 0, y: 1}])
    expect(grid.find(false)).toEqual([{x: 2, y: 0}, {x: 0, y: 2}])
    expect(grid.find(2)).toEqual([{x: 1, y: 0}, {x: 1, y: 2}])
    expect(grid.find(999)).toEqual([])

describe "getNeighbours(x, y)", ->
  it "should throw error if x is out of bounds", ->
    grid = new Grid(10, 20, -1)
    try
      grid.getNeighbours(10, 1)
      expect('x should be a number from 0 to less than the grid width').toBe(false)
    catch e
      expect(true).toBe(true)
    try
      grid.getNeighbours(-1, 1)
      expect('x should be a number from 0 to less than the grid width').toBe(false)
    catch e
      expect(true).toBe(true)  

  it "should throw error if y is out of bounds", ->
    grid = new Grid(10, 20, -1)
    try
      grid.getNeighbours(1, 21)
      expect('y should be a number from 0 to less than the grid height').toBe(false)
    catch e
      expect(true).toBe(true)
    try
      grid.getNeighbours(1, -1)
      expect('y should be a number from 0 to less than the grid height').toBe(false)
    catch e
      expect(true).toBe(true)  

  it "should get the specified cell's eight neighbours when they all exist", ->
    grid = new Grid(3, 3, null, ['nw', 'n', 'ne', 'w', 'CENTER', 'e', 'sw', 's', 'se'])
    neighbours = grid.getNeighbours(1, 1)
    expect(neighbours.topLeft).toEqual({x: 0, y: 0, item: 'nw'})
    expect(neighbours.top).toEqual({x: 1, y: 0, item: 'n'})
    expect(neighbours.topRight).toEqual({x: 2, y: 0, item: 'ne'})    
    expect(neighbours.left).toEqual({x: 0, y: 1, item: 'w'})    
    expect(neighbours.right).toEqual({x: 2, y: 1, item: 'e'})    
    expect(neighbours.bottomLeft).toEqual({x: 0, y: 2, item: 'sw'})
    expect(neighbours.bottom).toEqual({x: 1, y: 2, item: 's'})
    expect(neighbours.bottomRight).toEqual({x: 2, y: 2, item: 'se'})

  it "should get undefined for three neighbours where the specified cell is on an edge", ->
    items = [ 1, 2, 3,   
              4, 5, 6,   
              7, 8, 9,   
              1, 2, 3]
    grid = new Grid(3, 4, null, items)
    neighbours = grid.getNeighbours(0, 1) # 4 on the left edge
    expect(neighbours.topLeft).toBeUndefined()
    expect(neighbours.top).toEqual({x: 0, y: 0, item: 1})
    expect(neighbours.topRight).toEqual({x: 1, y: 0, item: 2})
    expect(neighbours.left).toBeUndefined()
    expect(neighbours.right).toEqual({x: 1, y: 1, item: 5})
    expect(neighbours.bottomLeft).toBeUndefined()
    expect(neighbours.bottom).toEqual({x: 0, y: 2, item: 7})
    expect(neighbours.bottomRight).toEqual({x: 1, y: 2, item: 8})

  it "should get undefined for five neighbours where the specified cell is on a corner", ->
    items = [ 1, 2, 3,   
              4, 5, 6,   
              7, 8, 9,   
              1, 2, 3]
    grid = new Grid(3, 4, null, items)
    neighbours = grid.getNeighbours(2, 3) # 3 on bottom right corner
    expect(neighbours.topLeft).toEqual({x: 1, y: 2, item: 8})
    expect(neighbours.top).toEqual({x: 2, y: 2, item: 9})
    expect(neighbours.topRight).toBeUndefined()
    expect(neighbours.left).toEqual({x: 1, y: 3, item: 2})
    expect(neighbours.right).toBeUndefined()
    expect(neighbours.bottomLeft).toBeUndefined()
    expect(neighbours.bottom).toBeUndefined()
    expect(neighbours.bottomRight).toBeUndefined()
    








    

