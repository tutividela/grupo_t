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

{ #category : #initialization }
CheckPointSquare >> checkpoint [
	^true.
]

{ #category : #initialization }
CheckPointSquare >> effect [
	^effect.
]

{ #category : #initialization }
CheckPointSquare >> initializeWith: squareEffect players: listOfPlayers [
	effect := squareEffect .
	players := OrderedCollection withAll: listOfPlayers.
]

{ #category : #initialization }
CheckPointSquare >> leaves: aPlayer [
	players remove: aPlayer.
]

{ #category : #'as yet unclassified' }
CheckPointSquare >> leavesASet: setOfPlayers [
	players removeAll: setOfPlayers .
]

{ #category : #initialization }
CheckPointSquare >> players [
	^players.
]

{ #category : #initialization }
CheckPointSquare >> put: aPlayer [
	players add: aPlayer.
]

{ #category : #'as yet unclassified' }
CheckPointSquare >> putASet: setOfPlayers [ 
	players addAll: setOfPlayers .
]
