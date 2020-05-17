Class {
	#name : #MoonWalk,
	#superclass : #Object,
	#instVars : [
		'nValue'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
MoonWalk class >> withKnownNValue: n [
	^self new initializeWithKnownNValue: n.
]

{ #category : #'as yet unclassified' }
MoonWalk class >> withSizeBoard:nSquares [
	^self new initializeWithSize: nSquares .
]

{ #category : #'as yet unclassified' }
MoonWalk >> applyTo: aPlayer in: board [ 
	|restOfPlayers |
	restOfPlayers :=self searchPlayersOn: board squares except:aPlayer .
	[ restOfPlayers isEmpty  ]
		whileFalse: [ 
			self searchPositionOf: restOfPlayers first in: board squares.
			self nValue asInteger timesRepeat: [  
				(board squares current isCheckpoint) 
					ifTrue: [ restOfPlayers first ceroLaps ifTrue: [board squares reset. ] ifFalse: [board squares previous . restOfPlayers first decreaseLap .]]
					ifFalse: [ board squares previous . ]
				].
				board squares current players addLast: restOfPlayers first.
				restOfPlayers removeFirst . 
			 ] 
	
	
]

{ #category : #'as yet unclassified' }
MoonWalk >> doEffectOver: squares to: aPlayer [
	|restOfPlayers |
	restOfPlayers :=self searchPlayersOn: squares except:aPlayer .
	[ restOfPlayers isEmpty  ]
		whileFalse: [ 
			self searchPositionOf: restOfPlayers first in:squares.
			self nValue asInteger timesRepeat: [  
				(squares current isCheckpoint) 
					ifTrue: [ restOfPlayers first ceroLaps ifTrue: [squares reset. ] ifFalse: [squares previous . restOfPlayers first decreaseLap .]]
					ifFalse: [ squares previous . ]
				].
				squares current players addLast: restOfPlayers first.
				restOfPlayers removeFirst . 
			 ] 
	
	
]

{ #category : #initialization }
MoonWalk >> initializeWithKnownNValue:n [
	nValue :=n.
]

{ #category : #initialization }
MoonWalk >> initializeWithSize:nSquares [ 
	nValue := Random new nextInt:nSquares . 
]

{ #category : #accesing }
MoonWalk >> nValue [
	^nValue.
]

{ #category : #'as yet unclassified' }
MoonWalk >> searchPlayersOn:squares except:aPlayer [
	|playersCol|
	playersCol:= OrderedCollection new.
	squares reset.
	playersCol addAll: (squares current players).
	squares next.
	[ squares current isCheckpoint ]whileFalse: [ 
		playersCol addAll:(squares current players ).
		squares next.
	 ].
	playersCol := playersCol reject: [ :p| p == aPlayer ].
	^playersCol .
	
]

{ #category : #'as yet unclassified' }
MoonWalk >> searchPositionOf:aPlayer in:squares [
	squares reset.
	[ squares current players includes: aPlayer ]whileFalse: [ squares next. ].
	squares current leaves: aPlayer.
]
