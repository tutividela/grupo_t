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

{ #category : #'as yet unclassified' }
Player >> choosesCard:aCard From: activeCards [
	^activeCards at: aCard .	
]

{ #category : #'as yet unclassified' }
Player >> choosesPlayerfromPosition: aPosition inSocreBoard: aScoreBoard [
	^aScoreBoard at: aPosition. 
	
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

{ #category : #accessing }
Player >> playsA: card [
	cards remove: card ifAbsent: [ Error signal: 'This card is not in player s hand.' ].
]

{ #category : #rolling }
Player >> roll: dices [ 
	^ dices roll.

]

{ #category : #rolling }
Player >> takes: theseCards [ 
	cards addAll: theseCards.

]

{ #category : #rolling }
Player >> takesA: card [ 
	cards addLast: card.

]
