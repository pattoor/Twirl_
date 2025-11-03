Class {
	#name : #Juego,
	#superclass : #Object,
	#instVars : [
		'tablero',
		'estado'
	],
	#category : #Buscaminas
}

{ #category : #acccessing }
Juego >> estado [
    ^estado

]

{ #category : #testing }
Juego >> gano [
    ^ tablero todasLasCeldas allSatisfy: [:c |
        (c esMina not and: [c estaReveleada]) or: [c esMina and: [c estaMarcada]] ].
]

{ #category : #acccessing }
Juego >> imprimirTablero [
    ^ tablero imprimir

]

{ #category : #initialization }
Juego >> initializeFilas: f columnas: c minas: m [
    tablero := Tablero new initializeFilas: f columnas: c minas: m.
    estado := #jugando.
	"comment stating purpose of message"


]

{ #category : #actions }
Juego >> revelarFila: f columna: c [
    | resultado |
    estado = #jugando ifFalse: [ ^self ].
    resultado := tablero revelarCeldaEnFila: f columna: c.
    resultado = #minaExploto ifTrue: [ estado := #perdio ].
    (self gano) ifTrue: [ estado := #gano ].
]

{ #category : #acccessing }
Juego >> tablero [
    ^ tablero

]
