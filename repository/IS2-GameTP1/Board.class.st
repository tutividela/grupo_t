Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Board class >> ofLength: nSquares [
	| collection |
	
	collection := OrderedCollection new.
	 
	(nSquares * 0.48) asInteger timesRepeat: [collection addLast: (Square with: NoEffect new)].
	(nSquares * 0.20) asInteger timesRepeat: [collection addLast: (Square with: WormHole new)].
	(nSquares * 0.20) asInteger timesRepeat: [collection addLast: (Square with: SpeedUp new)].
	(nSquares * 0.10) asInteger timesRepeat: [collection addLast: (Square with: (MoonWalk withRecoil:(Random new nextInt:nSquares)))].
	(nSquares * 0.02) asInteger timesRepeat: [collection addLast: (Square with: AtomicBomb new)].
	
	collection shuffle.
	
	collection addFirst: Square asCheckpoint.
	
	^self with: collection
]

{ #category : #'instance creation' }
Board class >> with: listOfSquares [
	^self new initializeWith: listOfSquares.
]

{ #category : #accessing }
Board >> amountOfSquares [
	^squares size .
]

{ #category : #private }
Board >> currentPosition [
	^ squares current
]

{ #category : #initialization }
Board >> initializeWith: listOfSquares [
	squares := CircularIterator cyclingOver: listOfSquares.
	"places:= Place with: (listOfSquares players copy)."
]

{ #category : #'as yet unclassified' }
Board >> move:rollResult a:aPlayer lapsToWin:laps [
	|amountOfMoves |
	amountOfMoves := laps - aPlayer lapsDone  == 1 & (rollResult > (self squares size - (self whereIs: aPlayer)) )
				ifTrue:  [ self squares size - (self whereIs: aPlayer) ] 
				ifFalse: [ rollResult ].
	
	self move: aPlayer this: amountOfMoves .
]

{ #category : #'process actions' }
Board >> move: aPlayer this: rollResult [
	self moveCurrentPositionTo: aPlayer.
	
	self currentPosition leaves: aPlayer.

	rollResult timesRepeat: [ self nextPosition isCheckpoint ifTrue: [ aPlayer registerLap ]  ].
	
	self currentPosition put: aPlayer.

	self currentPosition effect applyTo: aPlayer in: self . 
	
	self resetIndex.
	
	
]

{ #category : #private }
Board >> moveCurrentPositionTo: aPlayer [
	[  self playersOfCurrentPosition asArray includes: aPlayer  ] whileFalse: [ 
		squares next.
		].
]

{ #category : #private }
Board >> nextPosition [
	^squares next.
]

{ #category : #accessing }
Board >> playersOfCurrentPosition [
	^self currentPosition players.
]

{ #category : #private }
Board >> previousPosition [
	^squares previous.
]

{ #category : #private }
Board >> resetIndex [
	squares reset.
]

{ #category : #accessing }
Board >> setPlayersInCheckPoint: players [
	self resetIndex.
	self currentPosition putASet: players.
	
]

{ #category : #accessing }
Board >> squares [
	^squares .
]

{ #category : #search }
Board >> whereIs: aPlayer [
	| position |
	
	position := 0.	
	self resetIndex.
	[ self playersOfCurrentPosition asArray includes: aPlayer ] whileFalse: [ 
		self nextPosition.
		position := position + 1.
		].
	
	^position.
]
