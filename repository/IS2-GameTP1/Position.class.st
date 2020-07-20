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
	^self of: aPlayer at: 0 with: 0.
]

{ #category : #'as yet unclassified' }
Position class >> of: aPlayer at: square with: lapsDone [ 
	^self new initialize: aPlayer at: square with: lapsDone .
]

{ #category : #comparing }
Position >> > aPosition [ 
	^(currentLap > aPosition currentLap) or: [ (currentLap = aPosition currentLap) and: [currentSquare > aPosition currentSquare] ].

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
Position >> initialize: aPlayer at: square with: lapsDone [
	currentLap := lapsDone.
	currentSquare := square.
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
	currentSquare := square.
]

{ #category : #initialization }
Position >> reset [
	currentLap := 0.
	currentSquare := 0.

]
