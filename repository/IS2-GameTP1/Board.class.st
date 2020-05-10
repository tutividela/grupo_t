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
	| array |
	
	array := Array new: nSquares .
	array at: 1 put: (CheckPointSquare with: NoEffect new players: listOfPlayers) .
	
	"esto hay que arreglarlo: para insertar en el array los Square's con los efectos en las proporciones
	necesarias y mezclados "	
	2 to: nSquares do: [:index | array at: index put: (Square with: NoEffect new)].


	squares := CircularIterator cyclingOver: array .
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
