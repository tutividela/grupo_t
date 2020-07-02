Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares',
		'positions',
		'lastEffect'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Board class >> ofLength: nSquares [
	| collection |
	
	nSquares < 0 ifTrue:  [ Error signal: 'A Board cannot have negative amount of squares' ].
		
	collection := OrderedCollection new.
	
	collection addLast: Square asCheckpoint.
	(nSquares - 1) timesRepeat: [collection addLast: Square withRandomEffect ].
	
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

{ #category : #'process actions' }
Board >> applyLastEffectUsedTo: aPlayer [
	self goToTheSquareOf: aPlayer.
	
	lastEffect applyTo: aPlayer in: self . 
	
	self goToCheckpoint.
	
]

{ #category : #private }
Board >> currentSquare [
	^ squares current
]

{ #category : #private }
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

{ #category : #private }
Board >> goToTheSquareOf: aPlayer [
	[  self playersOfCurrentPosition asArray includes: aPlayer  ] whileFalse: [ 
		squares next.
		].
]

{ #category : #initialization }
Board >> initializeWith: listOfSquares [
	squares := CircularIterator cyclingOver: listOfSquares.
]

{ #category : #accessing }
Board >> lastEffectApplied [
	^lastEffect
]

{ #category : #'process actions' }
Board >> move: aPlayer this: rollResult [
	self goToTheSquareOf: aPlayer.
	
	rollResult >= 0 
		ifTrue: [ self moveForward: aPlayer this: rollResult]
		ifFalse: [ self moveBack: aPlayer this: rollResult * (-1) ].
		
	lastEffect := self currentSquare effect.
	
	lastEffect applyTo: aPlayer in: self . 
	
	self goToCheckpoint.
	
	
]

{ #category : #'process actions' }
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

{ #category : #'process actions' }
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
	^self currentSquare players .
]

{ #category : #accessing }
Board >> positionOf: aPlayer [
	^positions detect: [:position | position player == aPlayer ] ifNone: [ Error signal: 'This position does not exist.' ].
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
	[ (self playersOfCurrentPosition asArray includes: aPlayer) | (position > self amountOfSquares) ] whileFalse: [ 
		self nextSquare.
		position := position + 1.
		].
	
	(position > self amountOfSquares)
		ifTrue: [ ^Error signal: 'This player is not in the board.' ]
		ifFalse: [ ^position ].
	
]
