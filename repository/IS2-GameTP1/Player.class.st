Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'lapsDone'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Player class >> named: aName [ 
	^self new initializeWithName: aName 
]

{ #category : #'as yet unclassified' }
Player >> decreaseLap [
	lapsDone := lapsDone -1.
	lapsDone < 0 ifTrue: [ self resetLaps . ]
		
		
	
]

{ #category : #initialization }
Player >> initializeWithName: aName [ 
	name:= aName. 
	"lapsDone := 0."
	self resetLaps .
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

{ #category : #initialization }
Player >> resetLaps [
	lapsDone :=0.
]

{ #category : #rolling }
Player >> roll: dices [ 
	^ dices roll.

]
