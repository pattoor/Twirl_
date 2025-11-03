Class {
	#name : #JuegoUI,
	#superclass : #Object,
	#instVars : [
		'juego',
		'botones'
	],
	#category : #Buscaminas
}

{ #category : #ui }
JuegoUI >> actualizarVista [
    | index celda boton |
    index := 0.
    1 to: juego tablero filas do: [:i |
        1 to: juego tablero columnas do: [:j |
            index := index + 1.
            celda := (juego tablero celdas at: i) at: j.
            boton := botones at: index.
            celda estaReveleada
                ifTrue: [
                    celda esMina
                        ifTrue: [ boton label: '*' ]
                        ifFalse: [ boton label: celda alrededor asString ].
                    boton color: Color veryLightGray ]
                ifFalse: [ boton label: '#'. boton color: Color lightGray ] ]].

]

{ #category : #actions }
JuegoUI >> clicFila: f columna: c [
    juego revelarFila: f columna: c.
    self actualizarVista.
    (juego estado = #perdio) ifTrue: [
        self mostrarMensaje: 'perdiste burraso como no vas a saber jugar al buscaminas'].
    (juego estado = #gano) ifTrue: [
        self mostrarMensaje: 'menos mal'].

]

{ #category : #ui }
JuegoUI >> crearTableroVisual [
    | window gridMorph tamCelda |
    tamCelda := 30.
    window := (SystemWindow new model: self).
    window setLabel: 'Buscaminas'.

    gridMorph := Morph new color: Color gray.
    gridMorph extent: (juego tablero columnas * tamCelda) @ (juego tablero filas * tamCelda).

    1 to: juego tablero filas do: [:f |
        1 to: juego tablero columnas do: [:c |
            | boton |
            boton := SimpleButtonMorph new.
            boton label: '#'.
            boton target: self.
            boton actionSelector: #clicFila:columna:.
            boton arguments: { f. c }.
            boton extent: tamCelda @ tamCelda.
            boton position: ((c - 1) * tamCelda) @ ((f - 1) * tamCelda).
            gridMorph addMorph: boton.
            botones add: boton ]].

    window addMorph: gridMorph frame: (0@0 extent: gridMorph extent).
    window openInWorld.



]

{ #category : #initialization }
JuegoUI >> initialize [
    super initialize.
    juego := Juego new initializeFilas: 8 columnas: 8 minas: 10.
    botones := OrderedCollection new.
    self crearTableroVisual.

]

{ #category : #ui }
JuegoUI >> mostrarMensaje: texto [
    UIManager default inform: texto.

]
