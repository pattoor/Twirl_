Class {
	#name : #Tablero,
	#superclass : #Morph,
	#instVars : [
		'fichas',
		'dim'
	],
	#category : #twirl
}

{ #category : #actions }
Tablero >> checkWinCondition [
    "Verifica si todas las fichas están 'apagadas' (esBlanco = false).
     Si encuentra UNA ficha blanca, sale de inmediato (return false)."

    fichas do: [:rowArray |
        rowArray do: [:ficha |
            "Recordatorio: Smalltalk asume que tienes un getter 'esBlanco' en Ficha.
             Si no lo tienes, deberías crearlo: Ficha>>esBlanco ^ esBlanco"
            ficha esBlanco 
                ifFalse: [ ^ false ] "Si encuentra una encendida, el juego NO ha terminado"
        ]
    ].

    "Si llegamos aquí, ¡todas las fichas están apagadas!"
    self notifyWin.
    ^ true
]

{ #category : #actions }
Tablero >> crearFichas [
    | ficha |
    "1. Creamos el 'Array' padre (para las filas)"
    fichas := Array new: 5.

    (1 to: 5) do: [:row |
        
        "2. Por CADA fila, creamos un 'Array' hijo (para las columnas)"
        fichas at: row put: (Array new: 5). 

        (1 to: 5) do: [:col |
            
            "3. Creamos la ficha"
            ficha := Ficha new.
            
            "4. Le decimos a la ficha su posición en la grilla"
            ficha fil: row.
            ficha col: col.

            "5. Calculamos su posición en píxeles"
            ficha position: ((col - 1) * 50) @ ((row - 1) * 50).

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
    self extent: 250@250.
	 self borderWidth: 1.
    self color: Color lightGray.
	 self crearFichas.
	 self randomizeFichas.
]

{ #category : #initialization }
Tablero >> initializeWith: aDimension [
	"Inicializa el tablero con la dimensión (ej: 3, 4, o 5)"
	super initialize.
	dim := aDimension. "Guardamos la dimensión"
	
	"Calculamos el tamaño en píxeles: dim * 50"
	self extent: (dim * 50) @ (dim * 50).
	self color: Color lightGray.
	
	self crearFichas.
	self randomizeFichas.
]

{ #category : #'event handling' }
Tablero >> mouseDown: anEvent [
    | posEnTablero col row |
    
    "1. Obtenemos la posición del clic RELATIVA al tablero"
    posEnTablero := anEvent position - self position.

    "2. Convertimos los píxeles (ej: 120, 80) a grilla (ej: 3, 2)"
    col := (posEnTablero x // 50) + 1.
    row := (posEnTablero y // 50) + 1.

    "3. Si el clic es válido, procesamos la lógica del juego"
    ((row between: 1 and: 5) and: [ col between: 1 and: 5 ])
        ifTrue: [ self procesarClicEn: row y: col ]
]

{ #category : #notifications }
Tablero >> notifyWin [
    "Muestra un mensaje de éxito al jugador y desactiva la interacción."

    self world 
        ifNotNil: [ 
            self world inform: '¡Felicidades! Has ganado el juego.'.
            
            "Deshabilitar la interacción: si ya ganaron, no deberían poder hacer más clics"
            self removeAllMorphs. "Opcional: puedes limpiar el tablero"
            self handlesMouseDown: false.
        ]
]

{ #category : #actions }
Tablero >> procesarClicEn: row y: col [
    "Esta es la regla del juego 'Lights Out' (patrón de cruz)"
    
    self toggleFichaEn: row y: col.         "La ficha misma"
    
    self toggleFichaEn: (row - 1) y: col. "La de arriba"
    self toggleFichaEn: (row + 1) y: col. "La de abajo"
    self toggleFichaEn: row y: (col - 1). "La de la izquierda"
    self toggleFichaEn: row y: (col + 1). "La de la derecha"
	 self checkWinCondition.
]

{ #category : #actions }
Tablero >> randomizeFichas [
    "Voltea un número aleatorio de fichas (simulando clics) para generar un estado inicial complejo."

    | numClicks randomGenerator |
    
    "CORRECCIÓN: Instanciamos un nuevo generador de números aleatorios."
    randomGenerator := Random new.
    
    "Decidimos cuántos clics aleatorios realizar (e.g., entre 5 y 15)"
    numClicks := 5 + (randomGenerator nextInteger: 10). 

    1 to: numClicks do: [:i |
        | randRow randCol |
        "Generamos una fila y columna aleatoria entre 1 y 5"
        randRow := randomGenerator nextInteger: 5.
        randCol := randomGenerator nextInteger: 5.
        
        self procesarClicEn: randRow y: randCol
    ]
]

{ #category : #actions }
Tablero >> toggleFichaEn: row y: col [
    "Este método voltea una ficha, PERO solo si está dentro del tablero"
    
    ((row between: 1 and: 5) and: [ col between: 1 and: 5 ])
        ifFalse: [ ^ self ]. "Si está fuera de la grilla, no hagas nada"

    ((fichas at: row) at: col) toggle.
]
