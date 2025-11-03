Class {
	#name : #Celda,
	#superclass : #Object,
	#instVars : [
		'esMina',
		'revelada',
		'marcada',
		'alrededor'
	],
	#category : #Buscaminas
}

{ #category : #testing }
Celda >> alrededor [
	"comment stating purpose of message"

^alrededor 
]

{ #category : #accessing }
Celda >> alrededor: anObject [

	alrededor := anObject
]

{ #category : #accesing }
Celda >> desmarcar [
	"comment stating purpose of messag"
	
marcada:=false
]

{ #category : #accesing }
Celda >> esMina [
	"comment stating purpose of message"
^esMina
]

{ #category : #testing }
Celda >> estaMarcada [
	"comment stating purpose of message"
	^marcada
]

{ #category : #testing }
Celda >> estaReveleada [
	"comment stating purpose of message"

^revelada 

]

{ #category : #testing }
Celda >> incrementarCont [
	"comment stating purpose of message"

alrededor:=alrededor+1
]

{ #category : #initialization }
Celda >> initialize [
	"comment stating purpose of message"

	esMina:=false.
	revelada :=false.
	marcada:=false.
	alrededor:=0.
]

{ #category : #accessing }
Celda >> lado [

	^ lado
]

{ #category : #accessing }
Celda >> lado: anObject [

	lado := anObject
]

{ #category : #accesing }
Celda >> marcarMina [

marcada:=true.
]

{ #category : #accesing }
Celda >> revelar [	"comment stating purpose of messag"
	
revelada:=true
]
