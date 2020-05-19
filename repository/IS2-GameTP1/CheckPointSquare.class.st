Class {
	#name : #CheckPointSquare,
	#superclass : #Object,
	#instVars : [
		'players',
		'effect'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
CheckPointSquare class >> with: anEffect [
	^self with: anEffect players: {}.
]

{ #category : #'instance creation' }
CheckPointSquare class >> with: anEffect players: listOfPlayers [
	^self new initializeWith: anEffect players: listOfPlayers.
]

{ #category : #accesing }
CheckPointSquare >> effect [
	^effect.
]

{ #category : #initialization }
CheckPointSquare >> initializeWith: squareEffect players: listOfPlayers [
	effect := squareEffect .
	players := OrderedCollection withAll: listOfPlayers.
]

{ #category : #query }
CheckPointSquare >> isCheckpoint [
	^true.
]

{ #category : #'process actions' }
CheckPointSquare >> leaves: aPlayer [
	players remove: aPlayer.
]

{ #category : #accesing }
CheckPointSquare >> players [
	^players.
]

{ #category : #'process actions' }
CheckPointSquare >> put: aPlayer [
	players addLast: aPlayer.
]

{ #category : #'process actions' }
CheckPointSquare >> putASet: ofPlayers [ 
	players addAllLast: ofPlayers .
]
