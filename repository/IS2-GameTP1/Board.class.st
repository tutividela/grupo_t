Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Board class >> with: nSquares players: listOfPlayers [
	^self new initializeWith: nSquares players: listOfPlayers.
]

{ #category : #'as yet unclassified' }
Board >> findPlayer: aPlayer [
	[  (squares current players asArray includes: aPlayer)  ] whileFalse: [ 
		squares next.
		].
]

{ #category : #initialization }
Board >> initializeWith: nSquares players: listOfPlayers [
	| collection |
	
	collection := OrderedCollection new.

	(nSquares * 0.48) asInteger timesRepeat: (collection add: (Square with: NoEffect new)).
	(nSquares * 0.20) asInteger timesRepeat: (collection add: (Square with: WormHole new)).
	(nSquares * 0.20) asInteger timesRepeat: (collection add: (Square with: SpeedUp new)).
	(nSquares * 0.10) asInteger timesRepeat: (collection add: (Square with: MoonWalk new)).
	(nSquares * 0.20) asInteger timesRepeat: (collection add: (Square with: AtomicBomb new)).
	
	collection shuffle.
	
	collection addFirst: (CheckPointSquare with: NoEffect new players: listOfPlayers).
	
	squares := CircularIterator cyclingOver: collection .
]

{ #category : #'as yet unclassified' }
Board >> move: aPlayer squares: rollResult [
	self findPlayer: aPlayer.
	
	squares current leaves: aPlayer.

	1 to: rollResult do: [:square | squares next.  squares current checkpoint  ifTrue: [ aPlayer registerLap ]  ].
	
	squares current put: aPlayer.
	
	squares current effect doEffectOver: squares.
	
	squares reset.
	
	
]
