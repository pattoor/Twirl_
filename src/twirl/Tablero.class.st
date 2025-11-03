Class {
	#name : #Tablero,
	#superclass : #Morph,
	#instVars : [
		'fichas'
	],
	#category : #twirl
}

{ #category : #actions }
Tablero >> crearFichas [
    | ficha |
    "1. Creamos el 'Array' padre (para las filas)"
    fichas := Array new: 5.

    1 to: 5 do: [:row |
        
        "2. Por CADA fila, creamos un 'Array' hijo (para las columnas)"
        fichas at: row put: (Array new: 5). 

        1 to: 5 do: [:col |
            
            "3. Creamos la ficha"
            ficha := Ficha new.
            
            "4. Le decimos a la ficha su posición en la grilla"
            ficha fil: row.
            ficha col: col.

            "5. Calculamos su posición en píxeles"
            ficha position: (col - 1) * 50 @ (row - 1) * 50.

            "6. La añadimos visualmente al tablero"
            self addMorph: ficha.
            
            "7. La guardamos en nuestra matriz (¡ESTA ES LA LÍNEA CORREGIDA!)"
            (fichas at: row) at: col put: ficha.
        ]
    ]

]

{ #category : #'event handling' }
Tablero >> handlesMouseDown: anEvent [
    ^ true
]

{ #category : #initialization }
Tablero >> initialize [
    super initialize.
    
    "Definimos el tamaño del tablero: 5 fichas de 50px cada una"
    self extent: 250@250. 
    self color: Color lightGray. "Un fondo para que se vea"

    self crearFichas.
]

{ #category : #actions }
Tablero >> procesarClicEn: row y: col [
    "Esta es la regla del juego 'Lights Out' (patrón de cruz)"
    
    self toggleFichaEn: row y: col.         "La ficha misma"
    
    self toggleFichaEn: (row - 1) y: col. "La de arriba"
    self toggleFichaEn: (row + 1) y: col. "La de abajo"
    self toggleFichaEn: row y: (col - 1). "La de la izquierda"
    self toggleFichaEn: row y: (col + 1). "La de la derecha"
]

{ #category : #actions }
Tablero >> toggleFichaEn: row y: col [
    "Este método voltea una ficha, PERO solo si está dentro del tablero"
    
    ((row between: 1 and: 5) and: [ col between: 1 and: 5 ])
        ifFalse: [ ^ self ]. "Si está fuera de la grilla, no hagas nada"

    ((fichas at: row) at: col) toggle.
]
