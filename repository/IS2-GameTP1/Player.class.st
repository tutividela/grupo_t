Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'square'
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
]

{ #category : #accessing }
Player >> name [
	^name.
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
