Class {
	#name : #Tablero,
	#superclass : #Morph,
	#instVars : [
		'fichas',
		'size'
	],
	#category : #TwirlGame
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

{ #category : #'board creation' }
Tablero >> crearFichas [
	"CORRECCIÓN FINAL: Crea la matriz de Ficha, asegurando que cada Ficha y cada fila de Fichas sea un objeto único para evitar la corrupción de referencias."
	| ficha |
	
	fichas := Array new: size.
	
	1 to: size do: [:row |
		"CRÍTICO: Crea un NUEVO Array para cada fila"
		fichas at: row put: (Array new: size).
		
		1 to: size do: [:col |
			"Crea una NUEVA instancia de Ficha para cada celda"
			ficha := Ficha new.
			ficha fil: row.
			ficha col: col.
			
			"Posición en píxeles (50px por ficha)"
			ficha position: (col - 1) * 50 @ ((row - 1) * 50).
			
			self addMorph: ficha.
			(fichas at: row) at: col put: ficha.
		]
	]
]

{ #category : #checking }
Tablero >> estaGanado [
	"Verifica si todas las fichas están en el lado claro ('esBlanco = true')."
	
	"Método robusto para verificar cada ficha individualmente."
	1 to: size do: [:row |
		1 to: size do: [:col |
			"Si encontramos una ficha que NO es blanca, devolvemos false inmediatamente."
			((fichas at: row) at: col) esBlanco ifFalse: [ ^ false ]
		]
	].
	
	"Si el bucle termina, todas las fichas son blancas."
	^ true
]

{ #category : #'event handling' }
Tablero >> handlesMouseDown: anEvent [
	"Indica que el tablero responde a los clics del mouse."
	^ true
]

{ #category : #'board creation' }
Tablero >> iniciarNivel: unInteger [
	"Genera un estado inicial aleatorio aplicando movimientos para crear un puzle."
	| cantidad randomGen |
	
	"Usamos Random new para evitar el error #random"
	randomGen := Random new. 
	cantidad := unInteger * size. 
	
	1 to: cantidad do: [ :i |
		| r c |
		r := 1 + (randomGen next * size) truncated. 
		c := 1 + (randomGen next * size) truncated. 
		
		"Usar procesarClicEn:y: garantiza que el puzle sea soluble y usa el patrón de Cruz."
		self procesarClicEn: r y: c
	]
]

{ #category : #initialization }
Tablero >> initialize [
	"Inicialización base de Morph."
	super initialize.
]

{ #category : #'event handling' }
Tablero >> mouseDown: anEvent [
	"CORRECCIÓN FINAL: Procesa el clic. La lógica robusta del cálculo de coordenadas."
	| localPoint row col |
	
	(self handlesMouseDown: anEvent) ifFalse: [^ self].
	
	localPoint := self globalPointToLocal: anEvent position.
	
	"Calcula la fila y columna. Usamos 'min: size' para que el clic justo en el borde no se pase."
	col := ((localPoint x // 50) + 1) min: size. 
	row := ((localPoint y // 50) + 1) min: size.
	
	"*** Elige tu patrón aquí ***"
	"Usamos el patrón de Cruz por defecto:"
	self procesarClicEn: row y: col.
	
	"Si quieres probar la Variante L, cambia la línea anterior por esta:"
	"self procesarClicEnL: row y: col."
	
	"Verificar si se ganó"
	self estaGanado ifTrue: [
		self inform: '¡Ganaste el Nivel!'.
	]
]

{ #category : #notifications }
Tablero >> notifyWin [
    "Muestra un mensaje de éxito al jugador y desactiva la interacción."

    self world 
        ifNotNil: [ 
            self world alert: '¡Felicidades! Has ganado el juego.'.
            
            "Deshabilitar la interacción: si ya ganaron, no deberían poder hacer más clics"
            self removeAllMorphs. "Opcional: puedes limpiar el tablero"
            self handlesMouseDown: false.
        ]
]

{ #category : #'game logic' }
Tablero >> procesarClicEn: row y: col [
	"Patrón 1: Patrón de Cruz (Twirl/Lights Out clásico)."
	
	self toggleFichaEn: row y: col.      "Central"
	self toggleFichaEn: (row - 1) y: col. "Arriba"
	self toggleFichaEn: (row + 1) y: col. "Abajo"
	self toggleFichaEn: row y: (col - 1). "Izquierda"
	self toggleFichaEn: row y: (col + 1). "Derecha"
]

{ #category : #'game logic' }
Tablero >> procesarClicEnL: row y: col [
	"Patrón 2 (Variante): Patrón en 'L' (voltea la ficha central y sus 4 vecinas diagonales)."
	
	"Ficha Central"
	self toggleFichaEn: row y: col.      
	
	"Diagonales"
	self toggleFichaEn: (row - 1) y: (col - 1). "Arriba-Izquierda"
	self toggleFichaEn: (row - 1) y: (col + 1). "Arriba-Derecha"
	self toggleFichaEn: (row + 1) y: (col - 1). "Abajo-Izquierda"
	self toggleFichaEn: (row + 1) y: (col + 1). "Abajo-Derecha"
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

{ #category : #initialization }
Tablero >> startWithSize: anInteger [
	"Configura el tamaño lógico y visual del tablero (ej. 4x4)."
	size := anInteger.
	self extent: (size * 50) @ (size * 50). "Extensión visual basada en size * 50px"
	self color: Color lightGray.
	
	self crearFichas.
	
	"Centrado automático requerido por el usuario"
    self center: World center.
]

{ #category : #'game logic' }
Tablero >> toggleFichaEn: row y: col [
	"CRÍTICO: Voltea una ficha si sus coordenadas están dentro de los límites del tablero (usando 'size')."
	
	"Si la coordenada está fuera (ej. 0 o 5 en un 4x4), sale sin error."
	((row between: 1 and: size) and: [ col between: 1 and: size ])
		ifFalse: [ ^ self ].
		
	((fichas at: row) at: col) toggle.
]
