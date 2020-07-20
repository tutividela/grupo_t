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
Board class >> assertAmountOf: squares [
	squares < 0
		ifTrue: [ Error signal: 'A Board cannot have negative amount of squares' ]
]

{ #category : #'instance creation' }
Board class >> ofLength: nSquares [
	| collection |
	
	self assertAmountOf: nSquares .
		
	collection := OrderedCollection new.
	
	collection addLast: Square asCheckpoint.
	(nSquares - 1) timesRepeat: [collection addLast: Square withRandomEffect ].
	
	^self with: collection
]

{ #category : #'instance creation' }
Board class >> with: listOfSquares [
	^self new initializeWith: listOfSquares.
]

{ #category : #'instance creation' }
Board class >> withNoEffectOfLength: nSquares [
	| collection |
	
	self assertAmountOf: nSquares .
		
	collection := OrderedCollection new.
	
	collection addLast: Square asCheckpoint.
	(nSquares - 1) timesRepeat: [collection addLast: (Square with: NoEffect new) ].
	
	^self with: collection
]

{ #category : #accessing }
Board >> amountOfSquares [
	^squares size .
]

{ #category : #'instance creation' }
Board >> assertExistenceOf: aSquare [
	aSquare > self amountOfSquares
		ifTrue: [ Error signal: 'It does not exist.' ]
		ifFalse: [ ^aSquare ]
]

{ #category : #private }
Board >> currentSquare [
	^ squares current
]

{ #category : #estimation }
Board >> estimatedFinalPositionFor: aPlayer moving: rollResult listOf: reversalCards [
	| position finalPosition status |
	
	position := (self positionOf: aPlayer) copy.
	
	self goToTheSquareOf: aPlayer.
	position := rollResult > 0
		ifTrue: [ self estimatedMoveFoward: position this: rollResult ]
		ifFalse: [ self estimatedMoveBack: position this: rollResult * -1 ].
		
	status := self reversalStatusWithThis: reversalCards.
	
	finalPosition := self currentSquare effect estimated: position in: self reversalMode: status.
	
	self goToCheckpoint.
	
	^ finalPosition.
]

{ #category : #estimation }
Board >> estimatedMoveBack: position this: rollResult [
	| aPosition num |
	aPosition := position copy.
	num := aPosition currentSquare.
	
	(aPosition currentLap  == 0 and: [ aPosition currentSquare < rollResult ])
				ifTrue: 	[ aPosition reset. num := 0] 
				ifFalse: [ rollResult timesRepeat:  [ num := num - 1. self previousSquare isCheckpoint ifTrue: [ aPosition decreaseALap. num := (self amountOfSquares) - 1 ] ] ].
	
	aPosition registerSquare: num.		
	
	^aPosition.
]

{ #category : #estimation }
Board >> estimatedMoveFoward: position this: rollResult [ 
	| aPosition num |
	aPosition := position copy.
	num := aPosition currentSquare.
	rollResult timesRepeat: [ num := num + 1. self nextSquare isCheckpoint ifTrue: [ aPosition registerLap. num := 0 ] ].
	
	aPosition registerSquare: num.
	
	^aPosition.
	
]

{ #category : #private }
Board >> goAllOverTheBoard: aBlock reversalMode: status [
	self goToCheckpoint.
	
	[ (status ifTrue: [ self previousSquare ] ifFalse: [ self nextSquare  ]) isCheckpoint ] whileFalse: [ 
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
Board >> move: aPlayer this: rollResult listOf: reversalCards [
	| status |

	self goToTheSquareOf: aPlayer.
	
	rollResult >= 0 
		ifTrue: [ self moveForward: aPlayer this: rollResult]
		ifFalse: [ self moveBack: aPlayer this: rollResult * (-1) ].
		
	lastEffect := self currentSquare effect.
	
	status := self reversalStatusWithThis: reversalCards.
	
	lastEffect applyTo: aPlayer in: self reversalMode: status. 
	
	self goToCheckpoint.
	
	
]

{ #category : #'process actions' }
Board >> moveBack: aPlayer this: amount [
	|playerPosition|
	playerPosition := self whereIs: aPlayer.
	
	self currentSquare leaves: aPlayer.

	((self positionOf: aPlayer ) currentLap  == 0 and: [ playerPosition < amount ])
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

{ #category : #'process actions' }
Board >> remainingSquaresFor: aPlayer [
	^self amountOfSquares  - (self positionOf: aPlayer) currentSquare.
]

{ #category : #estimation }
Board >> reversalStatusWithThis: reversalCards [
	^ (reversalCards collect: [ :card | card assignedTo at: 1 ]) includes: self currentSquare.
]

{ #category : #private }
Board >> setPlayersInCheckPoint: players [
	self goToCheckpoint.
	
	positions := players collect: [:player | Position of: player ].
	
	self currentSquare putASet: players.
	
]

{ #category : #private }
Board >> squareAt: index [ 
	self goToCheckpoint.
	
	(index - 1) timesRepeat: [ self nextSquare ].
	
	^self currentSquare.
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
	[ (self playersOfCurrentPosition asArray includes: aPlayer) or: [ position > self amountOfSquares ] ] whileFalse: [ 
		self nextSquare.
		position := position + 1.
		].
	
	^self assertExistenceOf: position .
	
]

{ #category : #'instance creation' }
Board >> with: effect at: position [
	self assertExistenceOf: position.
	squares replaceAt: position this: (Square with: effect)
]
