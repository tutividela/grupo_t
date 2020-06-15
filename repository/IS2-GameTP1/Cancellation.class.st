Class {
	#name : #Cancellation,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
Cancellation >> applyEffectToThis: card inThe: game [
	game removeThis: card.
]

{ #category : #testing }
Cancellation >> isPermanent [
	^false
]

{ #category : #testing }
Cancellation >> isRedo [
	^false
]
