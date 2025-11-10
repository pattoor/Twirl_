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
    
	"Líneas añadidas para la separación visual de las fichas"
    self borderWidth: 1. 
    self borderColor: Color black.
    
	esBlanco := false.
	self updateColor.
]

{ #category : #operations }
Ficha >> toggle [
    esBlanco := esBlanco not.
    self updateColor.
]

{ #category : #visibility }
Ficha >> updateColor [
    esBlanco
        ifTrue: [ self color: Color white ]
        ifFalse: [ self color: Color darkGray ]
]
