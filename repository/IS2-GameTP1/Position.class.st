Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'player',
		'currentLap',
		'currentSquare'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #accessing }
Position >> currentLap [
	^currentLap. 
]

{ #category : #accessing }
Position >> currentSquare [
	^currentSquare .
]

{ #category : #initialization }
Position >> initializeWith: aPlayer [
	currentLap :=0.
	currentSquare :=0.
	player :=aPlayer.
]

{ #category : #accessing }
Position >> player [
	^player
]
