Class {
	#name : #Tablero,
	#superclass : #Morph,
	#instVars : [
		'fichas',
		'size'
	],
	#category : #TwirlGame
}

{ #category : #'board creation' }
Tablero >> crearFichas [
	"Crea la matriz de Ficha de tamaño 'size' x 'size'. Garantiza que cada ficha es un objeto único."
	| ficha |
	
	fichas := Array new: size.
	
	1 to: size do: [:row | 
		"CRÍTICO: Inicializamos un NUEVO array para cada fila para evitar la corrupción de referencias."
		fichas at: row put: (Array new: size). 
		
		1 to: size do: [:col | 
			"CRÍTICO: Creamos una NUEVA instancia de Ficha para cada celda."
			ficha := Ficha new.
			ficha fil: row.
			ficha col: col.
			
			ficha position: (col - 1) * 50 @ ((row - 1) * 50). 
			
			self addMorph: ficha.
			(fichas at: row) at: col put: ficha.
		]
	]
]

{ #category : #checking }
Tablero >> estaGanado [
	"Verifica si todas las fichas del tablero están en el lado claro ('esBlanco = true')."
	
	"Iteramos sobre todas las filas..."
	1 to: size do: [:row |
		"e iteramos sobre todas las columnas de cada fila."
		1 to: size do: [:col |
			"Si encontramos una ficha que NO es blanca, devolvemos false inmediatamente."
			((fichas at: row) at: col) esBlanco ifFalse: [ ^ false ]
		]
	].
	
	"Si el bucle termina sin devolver false, todas las fichas son blancas."
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
	
	"1. Inicializar el generador de números aleatorios"
	randomGen := Random new. 

	"2. La dificultad se escala por el tamaño del tablero"
	cantidad := unInteger * size. 
	
	1 to: cantidad do: [ :i |
		| r c |
		"Generar coordenadas aleatorias entre 1 y size, usando el generador local"
		"El resultado de 'next' es un Float entre 0.0 y 1.0"
		r := 1 + (randomGen next * size) truncated. 
		c := 1 + (randomGen next * size) truncated. 
		
		"Usar procesarClicEn:y: garantiza que el puzle sea soluble."
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
	| localPoint row col |
	
	(self handlesMouseDown: anEvent) ifFalse: [^ self]. 
	
	localPoint := self globalPointToLocal: anEvent position.
	
	"Calcula la fila y columna. Usamos 'min: size' para que el clic justo en el borde no se pase."
	col := ((localPoint x // 50) + 1) min: size. 
	row := ((localPoint y // 50) + 1) min: size.
	
	"Llamamos a la lógica del juego. No necesitamos verificar límites aquí."
	self procesarClicEn: row y: col.
	
	self estaGanado ifTrue: [
		self inform: '¡Ganaste el Nivel!'.
	].
]

{ #category : #'game logic' }
Tablero >> procesarClicEn: row y: col [
	"Implementa la regla del juego Twirl/Lights Out (patrón de cruz)."
	
	self toggleFichaEn: row y: col.      "Central"
	self toggleFichaEn: (row - 1) y: col. "Arriba"
	self toggleFichaEn: (row + 1) y: col. "Abajo"
	self toggleFichaEn: row y: (col - 1). "Izquierda"
	self toggleFichaEn: row y: (col + 1). "Derecha"
]

{ #category : #initialization }
Tablero >> startWithSize: anInteger [
	"Configura el tamaño lógico y visual del tablero (ej. 3, 4, o 5)."
	size := anInteger.
	self extent: (size * 50) @ (size * 50). "Extensión visual basada en size * 50px"
	self color: Color lightGray.
	self crearFichas.
    
    "*** LÍNEA AÑADIDA PARA CENTRADO AUTOMÁTICO ***"
    "Se centra en el World, pero solo si ya ha sido añadido al World."
    "Como se añade al World *después* de esta llamada, la forma más segura es usar un mensaje"
    "que se ejecute cuando el morph es visible."
    
    "Usaremos una solución temporal simple, moviendo el centro al centro del World"
    "justo al crearse, aunque la mejor solución es hacer esto después de añadirlo."
    
    "Para cumplir con el requisito de automatizar el centrado en la creación, lo colocamos aquí, "
    "asumiendo que el World ya tiene sus límites definidos."
    self center: World center.
]

{ #category : #'game logic' }
Tablero >> toggleFichaEn: row y: col [
	"Método auxiliar: voltea una ficha si sus coordenadas están dentro de los límites del tablero (usando la variable de instancia 'size')."
	
	((row between: 1 and: size) and: [ col between: 1 and: size ])
		ifFalse: [ ^ self ]. 
		
	((fichas at: row) at: col) toggle.
]
