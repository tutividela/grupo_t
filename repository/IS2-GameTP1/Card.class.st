Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'type',
		'assignedTo',
		'represents'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Card class >> source: aNumberProvider [
	| card |
	card := { Overload new . Speed new . Acceleration new . Cancellation new . Redo new . Repeat new } atRandom: aNumberProvider.
		
	^self type: card.
]

{ #category : #'accessing structure variables' }
Card class >> type: card [
	^self new initializeAs: card.
]

{ #category : #operation }
Card >> applyTo: playerOrCard in: game [

		assignedTo addLast: playerOrCard.

		type applyEffect: self toThis: playerOrCard inThe: game.
]

{ #category : #accessing }
Card >> assignedTo [
	assignedTo 
		ifNil: [ Error signal: 'This card has not been assigned to a player yet.' ] 
		ifNotNil: [ ^assignedTo ].
]

{ #category : #'as yet unclassified' }
Card >> assignedToAnyPlayer [
	assignedTo := OrderedCollection new.
]

{ #category : #accessing }
Card >> extraMoves [ 
	^type extraMoves.
]

{ #category : #initialization }
Card >> initializeAs: cardType [
	type := cardType.
	assignedTo := OrderedCollection new.
	represents := self.
]

{ #category : #accessing }
Card >> isPermanent [ 
	^type isPermanent.
]

{ #category : #accessing }
Card >> represents [ 
	^represents.
]

{ #category : #accessing }
Card >> represents: thisCard [
	represents := thisCard.
]

{ #category : #'as yet unclassified' }
Card >> representsAssignedToAnyPlayer [
	| card |
	card := self represents copy.
	card assignedToAnyPlayer.

	^card.
]

{ #category : #highlighting }
Card >> reverse [
	^type reverse.
]

{ #category : #accessing }
Card >> type [
	^type
]
