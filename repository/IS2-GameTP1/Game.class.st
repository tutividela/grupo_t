Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'squares',
		'dices',
		'players',
		'scoreboard',
		'board',
		'laps'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Game class >> with: numberOfSquares laps: numberOfLaps players: listOfPlayers dices: listOfDices [
	
	^self new 
		initializeWith: numberOfSquares 
		lapsToWin: numberOfLaps 
		playersList: listOfPlayers 
		dicesList: listOfDices 
]

{ #category : #'instance creation' }
Game class >> with: numberOfSquares players: listOfPlayers dices: listOfDices [
	
	^self new 
		initializeWith: numberOfSquares 
		playersList: listOfPlayers 
		dicesList: listOfDices 
]

{ #category : #initialization }
Game >> initializeWith: numberOfSquares lapsToWin: numberOfLaps playersList: listOfPlayers dicesList: listOfDices [ 
	scoreboard := listOfPlayers copy.
	squares := numberOfSquares.
	
	laps := numberOfLaps.
	players  := CircularIterator cyclingOver: listOfPlayers.
	dices := listOfDices.
	board := Board with: numberOfSquares players: listOfPlayers.
]

{ #category : #initialization }
Game >> initializeWith: numberOfSquares playersList: listOfPlayers dicesList: listOfDices [ 
	scoreboard := listOfPlayers copy.
	squares := numberOfSquares.
	players  := CircularIterator cyclingOver: listOfPlayers.
	dices := listOfDices.
]

{ #category : #game }
Game >> isStillOn [
	^scoreboard first lapsDone < laps.
]

{ #category : #private }
Game >> nextTurn [
	^players next.
]

{ #category : #game }
Game >> playAllTurns [
	[ self isStillOn ]
		whileTrue: [ 
			self playNextTurn.
		]
]

{ #category : #game }
Game >> playNextTurn [
	| player rollResult |
	self isStillOn
		ifFalse: [ ^ 'game over' ].
	
	player := self whoPlays .
	rollResult := player roll: dices.
	board move: player squares: rollResult .
	
	self updateScoboard.
	self nextTurn.
]

{ #category : #accesing }
Game >> scoreboard [
	^ scoreboard copy .
]

{ #category : #sorting }
Game >> updateScoboard [
	scoreboard sort: [ :p1 :p2 | p1 lapsDone >= p2 lapsDone ].
]

{ #category : #players }
Game >> whoPlays [
	^players current.
]

{ #category : #players }
Game >> winner [
	^self isStillOn 
		ifTrue: [ Error signal: 'No winner yet' ]
		ifFalse: [ scoreboard first ].

]
