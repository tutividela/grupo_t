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
	self status ifFalse: [ Error signal: 'Cards cannot be played when the game is over.' ].
	
	(player ~= self whoPlays and: [card isPermanent])
	
		ifTrue: [ Error signal: 'A player wants to play a permanent card on another turn.' ]
		ifFalse: [ 
			player plays: card.
			card applyTo: aPlayerOrCard in: self .
			lastCardPlayed := card.
		]
		
	
]

{ #category : #accesing }
Game >> activePermanentCards [
	^activePermanentCards.
]

{ #category : #game }
Game >> amountOfMovesFor: aPlayer withThis: rollResult [ 
	| total amountOfSquares position |
	
	total := rollResult + (self extraMovesFor: aPlayer).
	amountOfSquares := board amountOfSquares.
	position := scoreboard detect: [:p | p player == aPlayer ] ifNone: [ Error signal: 'This position does not exist.' ].

	(laps - position currentLap  == 1 and: [ total > (amountOfSquares - position currentSquare) ])
				ifTrue:  [ ^ amountOfSquares  - position currentSquare ] 
				ifFalse: [ ^ total ].
]

{ #category : #cards }
Game >> applyTheLastEffectOverTheLastPlayer [
	players previous .
	board applyLastEffectUsedTo: self whoPlays .
	self switchTurn.
]

{ #category : #accesing }
Game >> board [
	^board copy.
]

{ #category : #cards }
Game >> currentPlayerActivatesThis: card to: aPlayer [.
	self activateThis: card from: self whoPlays to: aPlayer  
		
	
]

{ #category : #'as yet unclassified' }
Game >> extraMovesFor: aPlayer [
	| extra |

	extra := 0.
	activePermanentCards do: [:card | 
		(card assignedTo includes: aPlayer)  ifTrue: [extra := extra + card extraMoves] 
		].
	
	^extra.
	
]

{ #category : #initialization }
Game >> initialize: aBoard lapsToWin: numberOfLaps playersList: listOfPlayers dicesList: listOfDices [ 
	listOfPlayers do: [:player | (2 - player cardsInHand) timesRepeat: [ player takesA: (Card source: Random new) ]].
	
	players  := CircularIterator cyclingOver: listOfPlayers.
	dices := listOfDices.
	
	laps := numberOfLaps.
	board := aBoard.
	board setPlayersInCheckPoint: listOfPlayers.
	
	scoreboard := board positions copy.
	
	activePermanentCards := OrderedCollection new.
	lastCardPlayed := nil.
]

{ #category : #accesing }
Game >> lastCardPlayed [
	lastCardPlayed 
		ifNil: [ Error signal: 'No one has played a card yet' ] 
		ifNotNil: [ ^lastCardPlayed  ].

]

{ #category : #game }
Game >> playAllTurns [
	[ self status ]
		whileTrue: [ 
			self playNextTurn.
		]
]

{ #category : #game }
Game >> playNextTurn [
	| aPlayer rollResult  amountOfMoves |
	self status ifFalse: [ ^ self ].
		
	aPlayer := self whoPlays.
	rollResult := aPlayer roll: dices.
	amountOfMoves := self amountOfMovesFor: aPlayer withThis: rollResult .
	
	board move: aPlayer this: amountOfMoves reversalMode: self reversalMode .
	
	self updateScoboard.
	self switchTurn.
]

{ #category : #accesing }
Game >> players [
	^players.
]

{ #category : #cards }
Game >> removeThis: activePermanentCard [
	activePermanentCards remove: activePermanentCard ifAbsent: [Error signal: 'Permanent card not active.'].
]

{ #category : #'as yet unclassified' }
Game >> reversalMode [
	activePermanentCards detect: [:card | card extraMoves == 0 ] ifFound: [ ^true ] ifNone: [ ^false ].
]

{ #category : #accesing }
Game >> scoreboard [
	^ scoreboard copy .
]

{ #category : #game }
Game >> status [
	^scoreboard first currentLap < laps.
]

{ #category : #private }
Game >> switchTurn [
	^players next.
]

{ #category : #sorting }
Game >> updateScoboard [
	scoreboard sort: [ :pl1 :pl2 | pl1 currentLap > pl2 currentLap or: [pl1 currentLap = pl2 currentLap and: [pl1 currentSquare > pl2 currentSquare]] ].
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
	^self status 
		ifTrue: [ Error signal: 'No winner yet' ]
		ifFalse: [ scoreboard first player ].

]
