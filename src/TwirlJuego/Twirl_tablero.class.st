Class {
	#name : #'Twirl_tablero',
	#superclass : #Object,
	#instVars : [
		'tiles',
		'size'
	],
	#category : #TwirlJuego
}

{ #category : #accessing }
Twirl_tablero >> at: row and: col [
    ^ tiles at: (row - 1) * size + col


]

{ #category : #accessing }
Twirl_tablero >> at: row and: col put: value [
    tiles at: (row - 1) * size + col put: value


]

{ #category : #initialization }
Twirl_tablero >> initialize [
    super initialize.
    size := 8.
    self initializeTiles
]

{ #category : #initialization }
Twirl_tablero >> initializeTiles [
    tiles := (1 to: size * size) asArray.
    self shuffle
]

{ #category : #testing }
Twirl_tablero >> isSolved [
    ^ tiles = (1 to: size * size) asArray
]

{ #category : #printing }
Twirl_tablero >> printOn: aStream [
    1 to: size do: [ :row |
        1 to: size do: [ :col |
            aStream print: (self at: row and: col).
            aStream space
        ].
        aStream cr
    ]
"recorre cada celda filaxcolumna"
]

{ #category : #'game logic' }
Twirl_tablero >> rotateAt: row and: col [
    "Rota clockwise un grupo 2x2 empezando en row,col"
    | temp a b c d |
    
    "Validar que podemos rotar (no en los bordes derechos/inferiores)"
    (row >= size or: [ col >= size ]) ifTrue: [ ^ self ].
    
    "Obtener los 4 valores"
    a := self at: row and: col.
    b := self at: row and: col + 1.
    c := self at: row + 1 and: col + 1.
    d := self at: row + 1 and: col.
    
    "Rotar: a->b, b->c, c->d, d->a"
    self at: row and: col put: d.
    self at: row and: col + 1 put: a.
    self at: row + 1 and: col + 1 put: b.
    self at: row + 1 and: col put: c
]

{ #category : #'game logic' }
Twirl_tablero >> shuffle [
    "Hace rotaciones aleatorias para mezclar el tablero"
    | random |
    random := Random new.
    50 timesRepeat: [
        | row col |
        row := random nextInteger: size - 1.
        col := random nextInteger: size - 1.
        self rotateAt: row and: col
    ]
]

{ #category : #accessing }
Twirl_tablero >> size [
    ^ size
]
