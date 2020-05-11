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
Game class >> playedBy: aSetOfPlayer throwing: dices onBoardOfLength: aNumberOfSquares during: aNumberOfLaps [
	^self new 
		initializeWith: aNumberOfSquares 
		lapsToWin: aNumberOfLaps 
		playersList: aSetOfPlayer 
		dicesList: dices 
]

{ #category : #initialization }
Game >> initializeWith: numberOfSquares lapsToWin: numberOfLaps playersList: listOfPlayers dicesList: listOfDices [ 
	players  := CircularIterator cyclingOver: listOfPlayers.
	dices := listOfDices.
	scoreboard := listOfPlayers copy.
	
	laps := numberOfLaps.
	board := Board with: numberOfSquares players: listOfPlayers.
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
