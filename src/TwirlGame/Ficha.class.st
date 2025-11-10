Class {
	#name : #Ficha,
	#superclass : #Morph,
	#instVars : [
		'esBlanco',
		'fil',
		'col'
	],
	#category : #TwirlGame
}

{ #category : #accessing }
Ficha >> col [

	^ col
]

{ #category : #accessing }
Ficha >> col: anObject [

	col := anObject
]

{ #category : #accessing }
Ficha >> esBlanco [

	^ esBlanco
]

{ #category : #accessing }
Ficha >> esBlanco: anObject [

	esBlanco := anObject
]

{ #category : #accessing }
Ficha >> fil [

	^ fil
]

{ #category : #accessing }
Ficha >> fil: anObject [

	fil := anObject
]

{ #category : #initialization }
Ficha >> initialize [
	"Configura el estado inicial y la apariencia básica de la ficha."
	super initialize.
	self extent: 50@50. "Tamaño fijo de 50x50 píxeles"
    
    "Añadido: Borde para la separación visual de la cuadrícula"
    self borderWidth: 1. 
    self borderColor: Color black.
    
	esBlanco := false. "Empieza en lado oscuro (gris)"
	self updateColor.
]

{ #category : #operations }
Ficha >> toggle [
	"Invierte el estado de la ficha y actualiza su color."
	esBlanco := esBlanco not.
	self updateColor.
]

{ #category : #visibility }
Ficha >> updateColor [
	"Establece el color visual: blanco para claro, gris oscuro para oscuro."
	esBlanco
		ifTrue: [ self color: Color white ]
		ifFalse: [ self color: Color darkGray ]
]
