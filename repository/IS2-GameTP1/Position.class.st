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

{ #category : #'instance creation' }
Position class >> of: aPlayer [ 
	^self new initializeWith: aPlayer .
]

{ #category : #accessing }
Position >> currentLap [
	^currentLap. 
]

{ #category : #accessing }
Position >> currentSquare [
	^currentSquare .
]

{ #category : #'process operations' }
Position >> decreaseALap [
	currentLap := currentLap < 0 ifTrue: [ 0 ] ifFalse: [ currentLap - 1 ].
]

{ #category : #initialization }
Position >> initializeWith: aPlayer [
	currentLap := 0.
	currentSquare := 0.
	player :=aPlayer.
]

{ #category : #accessing }
Position >> player [
	^player
]

{ #category : #'process operations' }
Position >> registerLap [
	currentLap := currentLap + 1.
]

{ #category : #'process operations' }
Position >> registerSquare: square [
	currentSquare  := square.
]
