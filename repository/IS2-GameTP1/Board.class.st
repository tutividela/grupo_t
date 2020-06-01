Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares',
		'positions'
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
Board >> currentSquare [
	^ squares current
]

{ #category : #accessing }
Board >> goAllOverTheBoard: aBlock [
	self goToCheckpoint.
	[ self nextSquare isCheckpoint ] whileFalse: [ 
		aBlock value.
	].
]

{ #category : #private }
Board >> goToCheckpoint [
	squares reset.
]

{ #category : #initialization }
Board >> initializeWith: listOfSquares [
	squares := CircularIterator cyclingOver: listOfSquares.
]

{ #category : #'process actions' }
Board >> move: aPlayer this: rollResult [
	self moveCurrentPositionTo: aPlayer.
	
	self moveForward: aPlayer this: rollResult.

	self currentSquare effect applyTo: aPlayer in: self . 
	
	self goToCheckpoint.
	
	
]

{ #category : #'process actions' }
Board >> move:aPlayer this:rollResult lapsToWin:laps [
	|amountOfMoves position|
	
	position := self positionOf: aPlayer.
	amountOfMoves := laps - position currentLap  == 1 & (rollResult > (self amountOfSquares  - position currentSquare) )
				ifTrue:  [ self amountOfSquares  - position currentSquare ] 
				ifFalse: [ rollResult ].
	
	self move: aPlayer this: amountOfMoves .
]

{ #category : #accessing }
Board >> moveBack: aPlayer this: amount [
	|playerPosition|
	playerPosition := self whereIs: aPlayer.
	
	self currentSquare leaves: aPlayer.

	(self positionOf: aPlayer ) currentLap  == 0 & (playerPosition < amount ) 
		ifTrue: [ self  goToCheckpoint ] 
		ifFalse: [
			amount  timesRepeat:  [ 
				self  previousSquare . 
				(self currentSquare isCheckpoint) ifTrue: [ (self positionOf: aPlayer ) decreaseALap  ].
			]. 
		].
	
	self currentSquare put: aPlayer .
	
	(self positionOf: aPlayer ) registerSquare: (self whereIs: aPlayer).

				
]

{ #category : #private }
Board >> moveCurrentPositionTo: aPlayer [
	[  self playersOfCurrentPosition asArray includes: aPlayer  ] whileFalse: [ 
		squares next.
		].
]

{ #category : #accessing }
Board >> moveForward: aPlayer this: amount [
	self currentSquare leaves: aPlayer.

	amount timesRepeat: [ self nextSquare isCheckpoint ifTrue: [ (self positionOf: aPlayer ) registerLap ] ].
	
	self currentSquare put: aPlayer.
	
	(self positionOf: aPlayer ) registerSquare: (self whereIs: aPlayer ).

				
]

{ #category : #private }
Board >> nextSquare [
	^squares next.
]

{ #category : #accessing }
Board >> playersOfCurrentPosition [
	^self currentSquare players.
]

{ #category : #accessing }
Board >> positionOf: aPlayer [
	^positions detect: [: position | position player == aPlayer ] .
]

{ #category : #accessing }
Board >> positions [
	^positions .
]

{ #category : #private }
Board >> previousSquare [
	^squares previous.
]

{ #category : #private }
Board >> setPlayersInCheckPoint: players [
	self goToCheckpoint.
	
	positions := players collect: [:player | Position of: player ].
	
	self currentSquare putASet: players.
	
]

{ #category : #accessing }
Board >> squares [
	^squares .
]

{ #category : #search }
Board >> whereIs: aPlayer [
	| position |
	
	position := 0.	
	self goToCheckpoint.
	[ self playersOfCurrentPosition asArray includes: aPlayer ] whileFalse: [ 
		self nextSquare.
		position := position + 1.
		].
	
	^position.
]
