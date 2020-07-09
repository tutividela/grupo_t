Class {
	#name : #Take,
	#superclass : #Object,
	#instVars : [
		'card'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Take class >> cardOf: aType [
	^self this: (Card type: aType).
]

{ #category : #'instance creation' }
Take class >> randomCard [ 
	^self this: (Card source: Random new) .
]

{ #category : #'instance creation' }
Take class >> this: newCard [
	^self new initializeGiving: newCard.
]

{ #category : #effect }
Take >> applyTo: aPlayer in: board [ 
	aPlayer takesA: card copy.
]

{ #category : #initialization }
Take >> initializeGiving: aCard [ 
	card := aCard.
]
