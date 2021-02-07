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

{ #category : #cards }
Game >> activateThis: card from: player to: aPlayerOrCard [.
	self assertGameIsOver .
	self assertThat: player playsInHisTurnPermanentCard:card.
	self triggerCard: card from:player  to:aPlayerOrCard . 
		
	
]

{ #category : #accesing }
Game >> activePermanentCards [
	^activePermanentCards.
]

{ #category : #cards }
Game >> addThis: activePermanentCard [
	activePermanentCards addLast: activePermanentCard.
]

{ #category : #accesing }
Game >> amountOfActivePermanentCards [
	^activePermanentCards size.
]

{ #category : #cards }
Game >> applyTheLastEffectOverTheLastPlayer [
	players previous .
	board applyLastEffectUsedTo: self whoPlays .
	self switchTurn.
]

{ #category : #asserting }
Game >> assertGameIsOver [
	self isStillOn ifFalse: [ Error signal: 'Cards cannot be played when the game is over.' ].
]

{ #category : #asserting }
Game >> assertThat:aPlayer playsInHisTurnPermanentCard:aCard [
	(aPlayer ~= self whoPlays) & aCard type isPermanent
		ifTrue: [ Error signal: 'A player wants to play a permanent card on another turn.' ] 
		
]

{ #category : #accesing }
Game >> board [
	^board.
]

{ #category : #cards }
Game >> currentPlayerActivatesThis: card to: aPlayer [.
	self activateThis: card from: self whoPlays to: aPlayer  
		
	
]

{ #category : #'as yet unclassified' }
Game >> examineAmountOfMoves: aRollResultAndExtra inPosition:aPosition [
	^laps - aPosition currentLap  == 1 & (aRollResultAndExtra > (board amountOfSquares  - aPosition currentSquare) )
	
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
	lastCardPlayed :=Card noValidCard .
]

{ #category : #game }
Game >> isStillOn [
	^scoreboard first currentLap < laps.
]

{ #category : #accessing }
Game >> lastCardIsValid [
	^lastCardPlayed validCard .
]

{ #category : #accesing }
Game >> lastCardPlayed [
	^lastCardPlayed .
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
	
	extra := self sumExtraMovesForPlayer: aPlayer.
	(self examineAmountOfMoves: rollResult +extra inPosition:position )
	"laps - position currentLap  == 1 & (rollResult + extra > (board amountOfSquares  - position currentSquare) )"
				ifTrue:  [ ^ board amountOfSquares  - position currentSquare ] 
				ifFalse: [ ^ rollResult + extra ].
]

{ #category : #cards }
Game >> removeThis: activePermanentCard [
	activePermanentCards remove: activePermanentCard ifAbsent: [Error signal: 'Permanent card not active.'].
]

{ #category : #accesing }
Game >> reverseTurns [
	players reverseOptionsOrder
]

{ #category : #accesing }
Game >> scoreboard [
	^ scoreboard copy .
]

{ #category : #'as yet unclassified' }
Game >> sumExtraMovesForPlayer:aPlayer [
	| cardsToSum |
	cardsToSum:= activePermanentCards select: [ :card | card player = aPlayer | card type applysToAllPlayers ].
	cardsToSum isEmpty 
		ifTrue: [ ^0 ]
		ifFalse: [ ^cardsToSum sum: [ :card | card type extraMoves . ]. ]
]

{ #category : #private }
Game >> switchTurn [
	^players next.
]

{ #category : #'as yet unclassified' }
Game >> triggerCard:aCard from:aPlayer to:aPlayerOrCard [
	aCard applyTo: aPlayerOrCard in: self .
	aPlayer playsA: aCard.
	lastCardPlayed := aCard.
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
