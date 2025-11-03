Class {
	#name : #Ficha,
	#superclass : #Morph,
	#instVars : [
		'esBlanco',
		'fil',
		'col'
	],
	#category : #twirl
}

{ #category : #accessing }
Ficha >> col [
	^col
]

{ #category : #accessing }
Ficha >> col: anInteger [
	col:= anInteger
]

{ #category : #accessing }
Ficha >> fil [
	^fil
]

{ #category : #accessing }
Ficha >> fil: anInteger [
	fil:= anInteger
]

{ #category : #initialization }
Ficha >> initialize [
    super initialize.
    self extent: 50@50.
    esBlanco := false.
    self updateColor.
]

{ #category : #operations }
Ficha >> toggle [
    esBlanco := esBlanco not.
    self updateColor.
]

{ #category : #Visuals }
Ficha >> updateColor [
    esBlanco
        ifTrue: [ self color: Color white ]
        ifFalse: [ self color: Color darkGray ]
]
