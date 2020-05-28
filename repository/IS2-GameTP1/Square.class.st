Class {
	#name : #Square,
	#superclass : #Object,
	#instVars : [
		'players',
		'effect',
		'checkpoint'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Square class >> as: checkpoint with: anEffect [
	^self new initializeAs: checkpoint  with: anEffect 

]

{ #category : #'instance creation' }
Square class >> asCheckpoint [
	^self as: true with: NoEffect new.
]

{ #category : #'instance creation' }
Square class >> with: anEffect [
	^self as: false with: anEffect
]

{ #category : #accesing }
Square >> effect [
	^effect.
]

{ #category : #initialization }
Square >> initializeAs: checkPoint with: anEffect [
	effect := anEffect .
	players := OrderedCollection new.
	checkpoint := checkPoint.
]

{ #category : #query }
Square >> isCheckpoint [
	^checkpoint.
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
