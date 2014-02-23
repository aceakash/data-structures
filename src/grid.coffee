# Represents a 2-dimensional grid. Uses an array as a backing store.
# 
# Position co-ordinates are referenced as an (x, y) tuple, where x is
# the zero-based x-coordinate (column) and y is the zero-based y-coordinate (row).
#
# Cell values which are not set explicitly, default to null or a blankValue if
# it is passed to the constructor.
#
# The constructor function is exported as {global}.DataStructures.Grid, where
# {global} is the window or exports object.

gridModule = ->
  Grid = (width, height, blankValue = null, seedItems) ->
    if width < 1 or height < 1
      throw 'width and height both need to be greater than 0'
    self = this
    width = width
    height = height
    itemCount = width * height
    blankValue = blankValue
    
    #todo can this be written better?
    items = null
    if seedItems?
      items = seedItems
    else
      items = []    
      for i in [0...itemCount]
        items[i] = blankValue

    getIndexFromXY = (x, y) -> (y * width) + x

    getXYFromIndex = (index) ->
      x = index % width
      y = (index - x) / width
      {'x': x, 'y': y}

    isValidPosition = (x, y) -> (0 <= x < width) and (0 <= y < height)

    tryGet = (x, y) ->
      return undefined if not isValidPosition(x, y)
      {'x': x, 'y': y, 'item': self.get(x, y)}
    
    self.getDimensions = -> { 'height': height, 'width': width }

    self.getItems = -> item for item in items

    self.set = (x, y, value) ->
      # todo error codes and messages
      if (typeof x isnt 'number') or not (0 <= x < width)
        throw 'x should be from 0 to width-1'
      if (typeof y isnt 'number') or not (0 <= y < height)
        throw 'y should be from 0 to height-1'      
      items[getIndexFromXY(x, y)] = value

    self.get = (x, y) ->
      if (typeof x isnt 'number') or not (0 <= x < width)
        throw 'x should be from 0 to width-1'
      if (typeof y isnt 'number') or not (0 <= y < height)
        throw 'y should be from 0 to height-1'
      items[getIndexFromXY(x, y)]

    self.find = (itemToFind) ->      
      getXYFromIndex(i) for item, i in items when item is itemToFind

    self.getNeighbours = (x, y) ->
      if (typeof x isnt 'number') or not (0 <= x < width)
        throw 'x should be from 0 to width-1'
      if (typeof y isnt 'number') or not (0 <= y < height)
        throw 'y should be from 0 to height-1'
      
      {        
        topLeft: tryGet(x - 1, y - 1),
        top: tryGet(x, y - 1),
        topRight: tryGet(x + 1, y - 1),
        left: tryGet(x - 1, y),
        right: tryGet(x + 1, y),
        bottomLeft: tryGet(x - 1, y + 1),
        bottom: tryGet(x, y + 1),
        bottomRight: tryGet(x + 1, y + 1)
      }    

    return  

  return Grid

global = exports ? this
global.DataStructures ?= { } 
global.DataStructures.Grid = gridModule()



  
