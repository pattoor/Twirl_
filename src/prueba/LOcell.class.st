Class {
	#name : #LOcell,
	#superclass : #SimpleSwitchMorph,
	#instVars : [
		'mouseAction'
	],
	#category : #prueba
}

{ #category : #initialize }
LOcell >> initialize [
	super initialize.
	self label: ''.
	self borderWidth: 2.
	bounds := 0 @ 0 corner: 16 @ 16.
	offColor := Color paleYellow.
	onColor := Color paleBlue darker.
	self useSquareCorners.
	self turnOff.
]

{ #category : #accesing }
LOcell >> mouseAction: aBlock [
	^ mouseAction := aBlock

]

{ #category : #'event handling' }
LOcell >> mouseUp: anEvent [
	mouseAction value
]
