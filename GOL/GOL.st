!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'Testing' stamp: 'HAW 5/11/2017 21:14:07'!
test01AliveCellWithLessThanTwoAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1 }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'Testing' stamp: 'AM 5/16/2017 00:13:59'!
test02AliveCellWithTwoAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isAliveAt: 1@1) ! !

!GOLTest methodsFor: 'Testing' stamp: 'AM 5/16/2017 00:13:48'!
test03AliveCellWithThreeAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isAliveAt: 1@1) ! !

!GOLTest methodsFor: 'Testing' stamp: 'HAW 5/11/2017 21:14:25'!
test04AliveCellWithMoreThanThreeAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. 0@1 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'Testing' stamp: 'AM 5/16/2017 00:13:36'!
test05DeadCellWithThreeAliveNeighResurects

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. 0@0 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isAliveAt: 1@1) ! !

!GOLTest methodsFor: 'Testing' stamp: 'JG 5/15/2017 21:40:46'!
test06CreateCellOutsideBounds

	self 
		should: [ GameOfLife withLiveCells: { 2@0. 1@0. 1@4 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: (GameOfLife outOfRangeError) ]! !

!GOLTest methodsFor: 'Testing' stamp: 'JG 5/13/2017 19:40:50'!
test07DeadCellWithMoreThanThreeAliveNeighRemainsDead

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. 0@0. 0@1 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'Testing' stamp: 'JG 5/13/2017 19:42:33'!
test08DeadCellWithLessThanThreeAliveNeighRemainsDead

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. 0@0 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 0@1) ! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells size deadCellsWithNeighbors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'accessing' stamp: 'JG 5/14/2017 19:10:49'!
aliveCellsNeighbors
		
	| neighbors |
	
	neighbors _ Set new.
	aliveCells do: [ :aCell | neighbors addAll: (aCell eightNeighbors select: [ :aCellNeighbor | self contains: aCellNeighbor ]) ].
			
	^ neighbors! !

!GameOfLife methodsFor: 'accessing' stamp: 'JG 5/15/2017 21:33:38'!
deadCellsWithAliveNeighbors
	" Reepmlaza a deadCells. Evita recorrer todo el tablero."
			
	| deadCells |
	
	deadCells _ Set new.
	self aliveCellsNeighbors do: [ :aCell | 
			(self isDeadAt: aCell) ifTrue: [ 
				deadCells add: aCell ] ].

	^ deadCells ! !

!GameOfLife methodsFor: 'accessing' stamp: 'HAW 5/10/2017 10:29:35'!
numberOfAliveNeighboursOf: aCell

	^(aCell eightNeighbors intersection: aliveCells) size! !


!GameOfLife methodsFor: 'inspecting' stamp: 'JG 5/14/2017 16:47:49'!
contains: aCell

	^ (aCell x between: 0 and: size x) and: [ aCell y between: 0 and: size y].! !

!GameOfLife methodsFor: 'inspecting' stamp: 'HAW 5/11/2017 21:11:17'!
hasToResurrect: aCell

	^(self numberOfAliveNeighboursOf: aCell) = 3! !

!GameOfLife methodsFor: 'inspecting' stamp: 'HAW 5/11/2017 19:57:05'!
hasToSurvive: aCell
	
	| numberOfAliveNeighbours|
	
	numberOfAliveNeighbours := self numberOfAliveNeighboursOf: aCell.
	
	^numberOfAliveNeighbours = 2 or:  [numberOfAliveNeighbours = 3]! !

!GameOfLife methodsFor: 'inspecting' stamp: 'AM 5/16/2017 00:13:15'!
isAliveAt: aCell

	^(aliveCells includes: aCell)! !

!GameOfLife methodsFor: 'inspecting' stamp: 'HAW 5/10/2017 10:28:24'!
isDeadAt: aCell

	^(aliveCells includes: aCell) not! !


!GameOfLife methodsFor: 'initialization' stamp: 'JG 5/15/2017 21:35:52'!
initializeWith: aCollectionOfAliveCells withSize: aSize

	size := aSize.
	aliveCells := aCollectionOfAliveCells.
	(aliveCells allSatisfy: [ :aCell | self contains: aCell ] ) ifFalse: [ self error: (GameOfLife outOfRangeError) ].! !


!GameOfLife methodsFor: 'stepping' stamp: 'JG 5/14/2017 16:33:32'!
nextGeneration
	
	aliveCells := (aliveCells select: [ :aCell | self hasToSurvive: aCell ]) union:
		(self deadCellsWithAliveNeighbors select: [ :aDeadCell | self hasToResurrect: aDeadCell ])! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'error descriptions' stamp: 'JG 5/15/2017 21:37:53'!
outOfRangeError

	 ^ 'The cell is out of range for this game'! !


!GameOfLife class methodsFor: 'initialization' stamp: 'HAW 5/11/2017 20:38:14'!
withLiveCells: aCollectionOfAliveCells withSize: aPoint 
	
	^self new initializeWith: aCollectionOfAliveCells withSize: aPoint ! !
