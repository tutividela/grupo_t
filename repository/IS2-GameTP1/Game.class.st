Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dices',
		'players',
		'scoreboard',
		'board',
		'laps',
		'activePermanentCards',
		'lastCardPlayed'
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
		^self 
			playedBy: aSetOfPlayer  
			throwing: dices 
			on: (Board ofLength: aNumberOfSquares)
			during: aNumberOfLaps 

]

{ #category : #cards }
Game >> activateThis: card from: player to: aPlayerOrCard [.
	self isStillOn ifFalse: [ Error signal: 'Cards cannot be played when the game is over.' ].
	
	(player ~= self whoPlays and: [card isPermanent])
	
		ifTrue: [ Error signal: 'A player wants to play a permanent card on another turn.' ]
		ifFalse: [ 
			player playsA: card.
			card applyTo: aPlayerOrCard in: self .
			lastCardPlayed := card.
		]
		
	
]

{ #category : #accesing }
Game >> activePermanentCards [
	^activePermanentCards.
]

{ #category : #cards }
Game >> applyTheLastEffectOverTheLastPlayer [
	players previous .
	board applyLastEffectUsedTo: self whoPlays .
	self switchTurn.
]

{ #category : #accesing }
Game >> board [
	^board.
]

{ #category : #cards }
Game >> currentPlayerActivatesThis: card to: aPlayer [.
	self activateThis: card from: self whoPlays to: aPlayer  
		
	
]

{ #category : #initialization }
Game >> initialize: aBoard lapsToWin: numberOfLaps playersList: listOfPlayers dicesList: listOfDices [ 
	listOfPlayers do: [:player | (2 - player cardsInHand) timesRepeat: [ player takesA:Card randomFromDeck ]].
	
	players  := CircularIterator cyclingOver: listOfPlayers.
	dices := listOfDices.
	
	laps := numberOfLaps.
	board := aBoard.
	board setPlayersInCheckPoint: listOfPlayers.
	
	scoreboard := board positions copy.
	
	activePermanentCards := OrderedCollection new.
	lastCardPlayed := nil.
]

{ #category : #game }
Game >> isStillOn [
	^scoreboard first currentLap < laps.
]

{ #category : #accesing }
Game >> lastCardPlayed [
	lastCardPlayed 
		ifNil: [ Error signal: 'No one has played a card yet' ] 
		ifNotNil: [ ^lastCardPlayed  ].

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
	| aPlayer rollResult  amountOfMoves |
	self isStillOn ifFalse: [ ^ self ].
		
	aPlayer := self whoPlays.
	rollResult := aPlayer roll: dices.
	amountOfMoves := self possibleMovesFor: aPlayer withThis: rollResult .
	
	board move: aPlayer this: amountOfMoves.
	
	self updateScoboard.
	self switchTurn.
]

{ #category : #accesing }
Game >> players [
	^players.
]

{ #category : #game }
Game >> possibleMovesFor: aPlayer withThis: rollResult [ 
	| position extra |
	
	position := board positionOf: aPlayer.
	
	extra := 0.
	activePermanentCards do: [:card | 
		(card assignedTo includes: aPlayer)  ifTrue: [extra := extra + card type extraMoves] 
		].

	laps - position currentLap  == 1 & (rollResult + extra > (board amountOfSquares  - position currentSquare) )
				ifTrue:  [ ^ board amountOfSquares  - position currentSquare ] 
				ifFalse: [ ^ rollResult + extra ].
]

{ #category : #cards }
Game >> removeThis: activePermanentCard [
	activePermanentCards remove: activePermanentCard ifAbsent: [Error signal: 'Permanent card not active.'].
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
