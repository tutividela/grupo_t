Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dices',
		'players',
		'scoreboard',
		'board',
		'laps'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Game class >> playedBy: aSetOfPlayer throwing: dices on: aBoard during: aNumberOfLaps [
	^self new 
		initialize: aBoard 
		lapsToWin: aNumberOfLaps 
		playersList: aSetOfPlayer 
		dicesList: dices 
]

{ #category : #'instance creation' }
Game class >> playedBy: aSetOfPlayer throwing: dices onBoardOfLength: aNumberOfSquares during: aNumberOfLaps [
	aNumberOfSquares < 0
		ifTrue:  [ Error signal: 'A Board cannot have negative amount of squares' ]
		ifFalse: [ ^self 
			playedBy: aSetOfPlayer  
			throwing: dices 
			on: (Board ofLength: aNumberOfSquares)
			during: aNumberOfLaps 
		]

]

{ #category : #accesing }
Game >> board [
	^board.
]

{ #category : #initialization }
Game >> initialize: aBoard lapsToWin: numberOfLaps playersList: listOfPlayers dicesList: listOfDices [ 
	players  := CircularIterator cyclingOver: listOfPlayers.
	dices := listOfDices.
	
	laps := numberOfLaps.
	board := aBoard.
	board setPlayersInCheckPoint: listOfPlayers.
	
	scoreboard := board positions.
]

{ #category : #game }
Game >> isStillOn [
	^scoreboard first currentLap < laps.
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
	| aPlayer rollResult |
	self isStillOn
		ifFalse: [ ^ self ].
		
	aPlayer := self whoPlays.
	rollResult := aPlayer roll: dices.
	board move: aPlayer this: rollResult lapsToWin: laps.
	
	self updateScoboard.
	self switchTurn
]

{ #category : #accesing }
Game >> scoreboard [
	^ scoreboard copy .
]

{ #category : #private }
Game >> switchTurn [
	^players next.
]

{ #category : #sorting }
Game >> updateScoboard [
	scoreboard sort: [ :pl1 :pl2 | pl1 currentLap > pl2 currentLap | (pl1 currentLap = pl2 currentLap & (pl1 currentSquare > pl2 currentSquare)) ].
]

{ #category : #search }
Game >> whereIs: aPlayer [
	^(board positionOf: aPlayer ) currentSquare.
]

{ #category : #players }
Game >> whoPlays [
	^players current.
]

{ #category : #players }
Game >> winner [
	^self isStillOn 
		ifTrue: [ Error signal: 'No winner yet' ]
		ifFalse: [ scoreboard first player ].

]
