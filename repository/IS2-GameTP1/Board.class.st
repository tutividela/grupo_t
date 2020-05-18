Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Board class >> with: listOfSquares [
	^self new initializeWith: listOfSquares.
]

{ #category : #'instance creation' }
Board class >> with: nSquares players: listOfPlayers [
	^self new initializeWith: nSquares players: listOfPlayers.
]

{ #category : #private }
Board >> currentPosition [
	^ squares current
]

{ #category : #initialization }
Board >> initializeWith: listOfSquares [
	squares := CircularIterator cyclingOver: listOfSquares.
]

{ #category : #initialization }
Board >> initializeWith: nSquares players: listOfPlayers [
	| collection |
	
	collection := OrderedCollection new.
	 
	(nSquares * 0.48) asInteger timesRepeat: (collection addLast: (Square with: NoEffect new)).
	(nSquares * 0.20) asInteger timesRepeat: (collection addLast: (Square with: WormHole new)).
	(nSquares * 0.20) asInteger timesRepeat: (collection addLast: (Square with: SpeedUp new)).
	(nSquares * 0.10) asInteger timesRepeat: (collection addLast: (Square with: MoonWalk new)).
	(nSquares * 0.02) asInteger timesRepeat: (collection addLast: (Square with: AtomicBomb new)).
	
	collection shuffle.
	
	collection addFirst: (CheckPointSquare with: NoEffect new players: listOfPlayers).
	
	squares := CircularIterator cyclingOver: collection .
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
