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

{ #category : #accessing }
Player >> cardsInHand [
	^cards size.
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

{ #category : #operation }
Player >> plays: aCard [
	cards remove: aCard ifAbsent: [ Error signal: 'This card is not in player s hand.' ].
]

{ #category : #rolling }
Player >> roll: dices [ 
	^ dices roll.

]

{ #category : #operation }
Player >> takes: theseCards [ 
	cards addAll: theseCards.

]

{ #category : #operation }
Player >> takesA: card [ 
	cards addLast: card.

]
