Class {
	#name : #Tablero,
	#superclass : #Object,
	#instVars : [
		'filas',
		'columnas',
		'minas',
		'celdas',
		'cantMinas'
	],
	#category : #Buscaminas
}

{ #category : #initialization }
Tablero >> calcAlrededor [
	"comment stating purpose of message"
    1 to: filas do: [:i |
        1 to: columnas do: [:j |
            | c |
            c := (celdas at: i) at: j.
            c esMina ifFalse: [
                c instVarNamed: 'alrededor' put: (self contarMinasAlrededorDeFilas: i columna: j) ] ] ].

]

{ #category : #accesing }
Tablero >> celdaEnFila: f columna: c [
^ (celdas at: f) at: c.
]

{ #category : #accesing }
Tablero >> celdas [
    ^ celdas

]

{ #category : #accessing }
Tablero >> col [

	^ col
]

{ #category : #accessing }
Tablero >> col: anObject [

	col := anObject
]

{ #category : #accesing }
Tablero >> columnas [
    ^ columnas


]

{ #category : #private }
Tablero >> contarMinasAlrededorDeFilas: f columna: c [
	"comment stating purpose of message"

	 | total |
    total := 0.
    (f - 1 to: f + 1) do: [:i |
        (c - 1 to: c + 1) do: [:j |
            (self dentroDeLimite: i columna: j) ifTrue: [
                ((celdas at: i) at: j) esMina ifTrue: [ total := total + 1 ] ] ] ].
    ^ total.
]

{ #category : #private }
Tablero >> dentroDeLimite: f columna: c [
	"comment stating purpose of message"

	 ^ (f between: 1 and: filas) and: [ c between: 1 and: columnas ].
]

{ #category : #initialization }
Tablero >> distribMinas [
	"comment stating purpose of message"
	|pos|
	pos:= (1 to: filas * columnas) shuffled copyFrom: 1 to: cantMinas .
	pos do:[:p|
		|i j|
		i:= ((p-1) // columnas) + 1.
		j:= ((p-1) \\ columnas) + 1.
		((celdas at:i) at:j) instVarNamed: 'esMina' put: 	true	].
	
]

{ #category : #accessing }
Tablero >> fila [

	^ fila
]

{ #category : #accessing }
Tablero >> fila: anObject [

	fila := anObject
]

{ #category : #accesing }
Tablero >> filas [
    ^ filas

]

{ #category : #printing }
Tablero >> imprimir [
    | salida |
    salida := ''.
    1 to: filas do: [:f |
        1 to: columnas do: [:c |
            | celda |
            celda := (celdas at: f) at: c.
            salida := salida , (celda estaReveleada
                ifTrue: [ celda esMina
                    ifTrue: ['*']
                    ifFalse: [celda alrededor asString] ]
                ifFalse: ['#']).
            salida := salida , ' ' ].
        salida := salida , String cr ].
    ^ salida

]

{ #category : #initialization }
Tablero >> initializeFilas: f columnas: c minas: m [ 
	"comment stating purpose of message"

	filas:= f.
	columnas:= c.
	cantMinas:= m.
	celdas := Array new: filas.
	1 to: filas do:[:i|
		celdas at:i put:(Array new: columnas).
		1 to: columnas do:[:j|
			(celdas at:i) at:j put: Celda new
				]
			].
	self distribMinas.
	self calcAlrededor.
]

{ #category : #actions }
Tablero >> revelarCeldaEnFila: f columna: c [
    | celda |
    celda := self celdaEnFila: f columna: c.
    (celda estaReveleada or: [celda estaMarcada]) ifTrue: [ ^self ].
    celda revelar.
    celda esMina ifTrue: [ ^#minaExploto ].
    celda alrededor = 0 ifTrue: [
        (f - 1 to: f + 1) do: [:i |
            (c - 1 to: c + 1) do: [:j |
                (self dentroDeLimite: i columna: j) ifTrue: [
                    self revelarCeldaEnFila: i columna: j ] ] ] ].

]

{ #category : #accesing }
Tablero >> todasLasCeldas [
    "Devuelve una colección con todas las celdas del tablero"
    ^ celdas flatCollect: [:fila | fila asArray ].

]
