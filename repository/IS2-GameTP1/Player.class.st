Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'square',
		'lapsDone'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Player class >> named: aName [ 
	^self new initializeWithName: aName 
]

{ #category : #initialization }
Player >> initializeWithName: aName [ 
	name:= aName. 
	square := 0.
	lapsDone := 0.
]

{ #category : #accessing }
Player >> lapsDone [
	^lapsDone.
]

{ #category : #accessing }
Player >> name [
	^name.
]

{ #category : #accessing }
Player >> registerLap [
	lapsDone := lapsDone + 1.
]

{ #category : #rolling }
Player >> roll: dices [ 
	^ dices roll.

]

{ #category : #accessing }
Player >> square [
	^square.
]

{ #category : #rolling }
Player >> updateSquare: resultOfRoll [ 
	square := square + resultOfRoll.

]
