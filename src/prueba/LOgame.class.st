Class {
	#name : #LOgame,
	#superclass : #BorderedMorph,
	#instVars : [
		'cells'
	],
	#classVars : [
		'LOCell'
	],
	#category : #prueba
}

{ #category : #accesing }
LOgame >> cellsPerSide [
"The number of cells along each side of the game"
^ 10

]

{ #category : #initialize }
LOgame >> initialize [
| sampleCell width height n |
super initialize.
n := self cellsPerSide.
sampleCell := LOcell new.
width := sampleCell width.
height := sampleCell height.
self bounds: (5 @ 5 extent: (width * n) @ (height * n) + (2 * self
borderWidth)).
cells := Matrix new: n tabulate: [ :i :j | self newCellAt: i at: j ]
]

{ #category : #initialize }
LOgame >> newCellAt: i at: j [
	"Create a cell for position (i,j) and add it to my on-screen
	representation at the appropriate screen position. Answer the
	new cell"
	| c origin |
	c := LOcell new.
	origin := self innerBounds origin.
	self addMorph: c.
	c position: ((i - 1) * c width) @ ((j - 1) * c height) + origin.
	c mouseAction: [ self toggleNeighboursOfCellAt: i at: j ].
	^ c

]

{ #category : #'game logic' }
LOgame >> toggleNeighboursOfCellAt: i at: j [
	i > 1
	ifTrue: [ (cells at: i - 1 at: j) toggleState ].
	i < self cellsPerSide
	ifTrue: [ (cells at: i + 1 at: j) toggleState ].
	j > 1
	ifTrue: [ (cells at: i at: j - 1) toggleState ].
	j < self cellsPerSide
	ifTrue: [ (cells at: i at: j + 1) toggleState ].
]
