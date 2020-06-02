Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name'
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
]

{ #category : #accessing }
Player >> name [
	^name.
]

{ #category : #rolling }
Player >> roll: dices [ 
	^ dices roll.

]
