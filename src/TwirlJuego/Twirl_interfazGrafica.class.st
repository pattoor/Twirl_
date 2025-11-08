Class {
	#name : #'Twirl_interfazGrafica',
	#superclass : #Object,
	#instVars : [
		'board',
		'cellMorph',
		'cellSize',
		'cellMorphs'
	],
	#category : #TwirlJuego
}

{ #category : #'event handling' }
Twirl_interfazGrafica >> cellClicked: event at: position [
    | row col |
    row := position first.
    col := position second.
    
    (row < 8 and: [ col < 8 ]) ifTrue: [
        board rotateAt: row and: col.
        self updateDisplay.
        board isSolved ifTrue: [ 
            self inform: '¡Ganaste! El puzzle está resuelto.'
        ]
    ]
]

{ #category : #'event handling' }
Twirl_interfazGrafica >> clickedRow: row col: col [
    (row < 8 and: [ col < 8 ]) ifTrue: [
        board rotateAt: row and: col.
        self updateDisplay.
        board isSolved ifTrue: [ 
            self inform: '¡Ganaste!'
        ]
    ]
]

{ #category : #initialization }
Twirl_interfazGrafica >> createCellAt: row and: col [
    | cell label |
    cell := BorderedMorph new.
    cell changeExtent: cellSize @ cellSize.
    cell position: self position + (((col - 1) * cellSize) @ ((row - 1) * cellSize)).
    cell fillStyle: Color lightGray.
    cell setBorderWidth: 1 borderColor: Color black.
    
    label := StringMorph new contents: (board at: row and: col) asString.
    cell addMorph: label.
    label position: cell center - (label extent // 2).
    
    ^ cell
]

{ #category : #initialization }
Twirl_interfazGrafica >> createCellMorphs [
    cellMorphs := OrderedCollection new.
    1 to: 8 do: [ :row |
        1 to: 8 do: [ :col |
            | cell |
            cell := self createCellAt: row and: col.
            cellMorphs add: cell.
            self addMorph: cell
        ]
    ]
]

{ #category : #initialization }
Twirl_interfazGrafica >> initialize [
    super initialize.
    board := Twirl_tablero new.
    cellSize := 50.
    self changeExtent: (cellSize * 8) @ (cellSize * 8).
    self setBorderWidth: 2 borderColor: Color black.
    self fillStyle: Color white.
    self createCellMorphs
]

{ #category : #updating }
Twirl_interfazGrafica >> updateDisplay [
    1 to: 8 do: [ :row |
        1 to: 8 do: [ :col |
            | index cell label |
            index := (row - 1) * 8 + col.
            cell := cell at: index.
            label := cell submorphs first.
            label contents: (board at: row and: col) printString.
            label position: cell center - (label extent / 2)
        ]
    ]
]
