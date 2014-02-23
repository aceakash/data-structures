DataStructures.Grid
===================
Grid is an implementation of a two-dimensional grid in CoffeeScript (and thus JavaScript).

Usage
-----

* ```new Grid(width, height, blankValue, seedItems)```

Creates a grid object with the specified width and height. 

Cells not explicitly set with a value get assigned *blankValue* (default is *null*). 

Grid may be initialised with an optional array of values *seedItems* - this is assigned row by row.

``` 
var gameBoard = new Grid(3, 4, null, [1,2,3,4,5,6,7,8,9]);
```
will create this grid 
```
1     2     3
4     5     6
7     8     9
null  null  null
```
---
* ``` grid.getDimensions() ```

Returns an object containing the height and width of the grid.
```
gameBoard.getDimensions(); 
```
will return the following for the above grid:
```
{ height: 4, width: 3 }
```
---
* ```grid.getItems()```

Gets an array representation of the grid, row by row.

```
gameBoard.getItems(); 
```
returns
```
[1,2,3,4,5,6,7,8,9,null,null,null]
```
---
* ```grid.get(x, y)```

Gets the value at the cell specified by the x and y co-ordinates (column and row respectively).
```
gameBoard.get(0, 3); // null
gameBoard.get(2, 2); // 9
```
---
* ```grid.set(x, y, value)```

Sets the value of the cell specified by the x and y co-ordinates.

```
gameBoard.set(0, 3, 10);
gameBoard.set(2, 1, 16);
```
changes the grid to
```
  1     2     3
  4     5    *16*
  7     8     9
*10*   null  null
```
---
* ```grid.find(value)```

Finds the specified value in the grid. 

Returns an array of position objects.
```
gameBoard.find(5); // [{x: 1, y: 1}]
gameBoard.find(null); // [{x: 1, y: 3}, {x: 2, y: 3}]
```
---
* ```grid.getNeighbours(x, y)```

Gets the specified cell's eight neighbouring cells.

Returns an object with the neighbours specified as topLeft, top, bottomRight etc.

If the specified cell is on an edge or in a corner of the grid, some of the neighbours will be non-existent i.e. *undefined*
```
gameBoard.getNeighbours(1, 2);
```
will return
```
{ 
  topLeft: {x: 0, y: 1, item: 1},
  top: {x: 1, y: 1, item: 5},
  topRight: {x: 2, y: 1, item: 16},
  left: {x: 0, y: 2, item: 7},
  right: {x: 2, y: 2, item: 9},
  bottomLeft: {x: 0, y: 3, item: 10},
  bottom: {x: 1, y: 3, item: null},
  bottomRight: {x: 2, y: 3, item: null}
}
```

