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
	aNumberOfSquares < 0
		ifTrue:  [ Error signal: 'A Board cannot have negative amount of squares' ]
		ifFalse: [ ^self 
			playedBy: aSetOfPlayer  
			throwing: dices 
			on: (Board ofLength: aNumberOfSquares)
			during: aNumberOfLaps 
		]

]

{ #category : #'as yet unclassified' }
Game >> activateThis: card from: player1 to: player2 [.
	(player1 ~= self whoPlays) & card type isPermanent
	
		ifTrue: [ Error signal: 'A player wants to play a permanent card on another turn.' ]
		ifFalse: [ 
			card type isPermanent 
				ifTrue: [ 
					self whoPlays playsA: card.
					card applyTo: player2.
					activePermanentCards addLast: card.
				]
		
				ifFalse: [ 
				 	player1 playsA: card.
					
				].
		
				lastCardPlayed := card.
		]
		
	
]

{ #category : #accesing }
Game >> board [
	^board.
]

{ #category : #'as yet unclassified' }
Game >> currentPlayerActivatesThis: card to: aPlayer [.
	self activateThis: card from: self whoPlays to: aPlayer  
		
	
]

{ #category : #initialization }
Game >> initialize: aBoard lapsToWin: numberOfLaps playersList: listOfPlayers dicesList: listOfDices [ 
	listOfPlayers do: [:player | player cardsInHand == 0 ifTrue: [player takes: {Card randomFromDeck . Card randomFromDeck }]].
	
	players  := CircularIterator cyclingOver: listOfPlayers.
	dices := listOfDices.
	
	laps := numberOfLaps.
	board := aBoard.
	board setPlayersInCheckPoint: listOfPlayers.
	
	scoreboard := board positions copy.
	
	activePermanentCards := OrderedCollection new.
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
	activePermanentCards do: [:card | card player = aPlayer | card type applysToAllPlayers   ifTrue: [extra := extra + card type extraMoves] ].

	laps - position currentLap  == 1 & (rollResult + extra > (board amountOfSquares  - position currentSquare) )
				ifTrue:  [ ^ board amountOfSquares  - position currentSquare ] 
				ifFalse: [ ^ rollResult + extra ].
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
