Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'cards'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Player class >> named: aName [ 
	^self new initializeWithName: aName 
]

{ #category : #accessing }
Player >> cards [
	^cards.
]

{ #category : #rolling }
Player >> give: firstTwoCards [ 
	cards addAll: firstTwoCards.

]

{ #category : #initialization }
Player >> initializeWithName: aName [ 
	name:= aName. 
	cards := OrderedCollection new.
]

{ #category : #accessing }
Player >> name [
	^name.
]

{ #category : #rolling }
Player >> roll: dices [ 
	^ dices roll.

]
