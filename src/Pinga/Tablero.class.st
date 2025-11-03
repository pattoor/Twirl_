Class {
	#name : #Tablero,
	#superclass : #Object,
	#instVars : [
		'fila',
		'col'
	],
	#category : #Pinga
}

{ #category : #accessing }
Tablero >> col [

	^ col
]

{ #category : #accessing }
Tablero >> col: anObject [

	col := anObject
]

{ #category : #accessing }
Tablero >> fila [

	^ fila
]

{ #category : #accessing }
Tablero >> fila: anObject [

	fila := anObject
]
