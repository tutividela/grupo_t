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
	scoreboard := listOfPlayers copy.
	
	laps := numberOfLaps.
	board := aBoard.
	board setPlayersInCheckPoint: listOfPlayers.
]

{ #category : #game }
Game >> isStillOn [
	^scoreboard first lapsDone < laps.
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
	| aPlayer rollResult|
	self isStillOn
		ifFalse: [ ^ self ].
	
	aPlayer := self whoPlays .
	rollResult := aPlayer roll: dices.
	board move: rollResult  a:aPlayer  lapsToWin:laps. 
	
	self updateScoboard.
	self switchTurn.
	
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
	scoreboard sort: [ :p1 :p2 | p1 lapsDone >= p2 lapsDone ].
]

{ #category : #search }
Game >> whereIs: aPlayer [
	^board whereIs: aPlayer.
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
