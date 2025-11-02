Class {
	#name : #MyClass,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'apellido'
	],
	#category : #prueba
}

{ #category : #accessing }
MyClass >> apellido: unApellido [
	apellido := unApellido 
]

{ #category : #accessing }
MyClass >> nombre: unNombre [
	nombre := unNombre 
]
