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

{ #category : #initialization }
Square >> addPlayer: aPlayer [
	players add: aPlayer.
]

{ #category : #initialization }
Square >> checkpoint [
	^false.
]

{ #category : #initialization }
Square >> initializeWith: squareEffect players: listOfPlayers [
	effect := squareEffect .
	players := OrderedCollection withAll: listOfPlayers.
]

{ #category : #initialization }
Square >> players [
	^players.
]

{ #category : #initialization }
Square >> removePlayer: aPlayer [
	players remove: aPlayer.
]
