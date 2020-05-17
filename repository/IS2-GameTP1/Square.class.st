Class {
	#name : #Square,
	#superclass : #Object,
	#instVars : [
		'players',
		'effect'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Square class >> with: anEffect [
	^self with: anEffect players: {}.
]

{ #category : #'instance creation' }
Square class >> with: anEffect players: listOfPlayers [
	^self new initializeWith: anEffect players: listOfPlayers.
]

{ #category : #accesing }
Square >> effect [
	^effect.
]

{ #category : #initialization }
Square >> initializeWith: squareEffect players: listOfPlayers [
	effect := squareEffect .
	players := OrderedCollection withAll: listOfPlayers.
]

{ #category : #query }
Square >> isCheckpoint [
	^false.
]

{ #category : #'process actions' }
Square >> leaves: aPlayer [
	players remove: aPlayer.
]

{ #category : #accesing }
Square >> players [
	^players.
]

{ #category : #'process actions' }
Square >> put: aPlayer [
	players addLast: aPlayer.
]

{ #category : #'process actions' }
Square >> putASet: ofPlayers [ 
	players addAllLast: ofPlayers .
]
