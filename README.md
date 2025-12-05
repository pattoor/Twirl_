## 🧩  TWIRL: Un Desafío a Contrarreloj
Este proyecto es un Trabajo Práctico Integrador (TPI) para la materia Paradigmas de la Programación (UTN F.R.R.e). El enfoque principal fue la aplicación rigurosa de los conceptos de la Programación Orientada a Objetos (POO) en Pharo Smalltalk.

## 🎮 Descripción y Mecánica del 4
Twirl es una implementación del clásico rompecabezas binario "Lights Out".

#### Objetivo: Lograr que todas las fichas del tablero estén en el estado ganador (color blanco).

#### Mecánica: Al hacer clic en una ficha, se invierte el estado (color) de la ficha central y el de sus cuatro vecinas (arriba, abajo, izquierda, derecha).

#### POO: El desarrollo en Pharo sirvió para aplicar los pilares de la POO (Encapsulamiento, Herencia, Abstracción y Polimorfismo) en un ambiente de "prueba y error".

## ✨ Características Principales
Dificultad: Tableros de 3x3, 4x4, o 5x5.

Historial: Funcionalidades de Deshacer (<) y Rehacer (>) gestionadas mediante pilas.

Tiempo: Temporizador de 60 segundos que reinicia (desordenar) el tablero al agotarse.

Herramienta de Ayuda (Resolver):

Utiliza un algoritmo de barrido para encontrar la solución.

Resalta con un borde rojo las fichas que deben ser pulsadas.

## 🛠️ Requisitos y Ejecución
Para iniciar Twirl, se requiere el entorno Pharo Smalltalk.

1. Requisitos
Pharo 10.0 o superior.

2. Carga del Proyecto
Abre tu imagen de Pharo.

Carga el archivo .st del proyecto (twirl_9.st) usando el System Browser o la opción de File In.

3. Iniciar el Juego
Ejecuta el siguiente mensaje en el Playground o Transcript:

Smalltalk

JuegoTwirl abrir
### 👨‍💻 Equipo de Desarrollo
Lautaro Nahuel Keiser 

Patricio Oscar Romero

Emilio Rehwald

Ulises Gabriel Adolfo Revollar Ochatoma

Francisco Santiago Toledo