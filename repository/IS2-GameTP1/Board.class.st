Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
Board class >> size:nSquares players:listOfPlayers [
	^self new size: nSquares  with: listOfPlayers . 
]

{ #category : #'instance creation' }
Board class >> with: nSquares players: listOfPlayers [
	^self new initializeWith: nSquares players: listOfPlayers.
]

{ #category : #'as yet unclassified' }
Board >> anArrayOf: aSize [
	
]

{ #category : #'as yet unclassified' }
Board >> findPlayer: aPlayer [
	[  (squares current players asArray includes: aPlayer)  ] whileFalse: [ 
		squares next.
		].
]

{ #category : #initialization }
Board >> initializeWith2: nSquares  players: listOfPlayers [
	|collection noEffectSQ|
	collection :=OrderedCollection new.
	noEffectSQ :=Square with: NoEffect new.
	1 to: (0.48*nSquares) do: [ collection add: noEffectSQ  ].
	1 to: (0.20*nSquares) do: [ collection add: (Square with: WormHole  new) ].
	1 to: (0.20*nSquares) do: [ collection add: (Square with: SpeedUp  new) ].
	1 to: (0.10*nSquares) do: [ collection add: (Square with: MoonWalk  new) ].
	1 to: (0.02*nSquares) do: [ collection add: (Square with: AtomicBomb  new) ].
	
	collection shuffle .
	collection addFirst: (CheckPointSquare with: NoEffect new players: listOfPlayers).
	squares := CircularIterator cyclingOver: collection .
]

{ #category : #initialization }
Board >> initializeWith:nSquares players: listOfPlayers [
	| collection |
	
	collection := OrderedCollection new.
	 

	(nSquares * 0.48) asInteger timesRepeat: (collection add:(Square with: NoEffect new) ).
	(nSquares * 0.20) asInteger timesRepeat: (collection add: (Square with: WormHole new)).
	(nSquares * 0.20) asInteger timesRepeat: (collection add: (Square with: SpeedUp new)).
	(nSquares * 0.10) asInteger timesRepeat: (collection add: (Square with: MoonWalk new)).
	(nSquares * 0.02) asInteger timesRepeat: (collection add:(Square with: AtomicBomb new)).
	
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
	
	"squares current effect doEffectOver: squares."
	squares current effect doEffectOver: squares  to:aPlayer . 
	squares reset.
	
	
]

{ #category : #'as yet unclassified' }
Board >> size:nSquares with:listOfPlayers [
	|collection|
	collection :=OrderedCollection new.
	collection addFirst: (CheckPointSquare with: NoEffect new players: listOfPlayers).
	collection add: (Square with: SpeedUp new).
	collection add: (Square with: WormHole  new).
	collection add: (Square with: MoonWalk  new).
	collection add: (Square with: AtomicBomb  new).
	1 to: (nSquares -collection size) do: [ :s| collection add:(Square with: NoEffect new)].
	"(nSquares - 5) asInteger timesRepeat: (collection add: (Square with: NoEffect new))."
	"6 to: nSquares  do: [ collection add: (Square with: NoEffect new) ]."
	squares:=CircularIterator cyclingOver: collection.
]

{ #category : #accessing }
Board >> squares [
	^squares .
]
