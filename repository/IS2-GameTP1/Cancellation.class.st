Class {
	#name : #Cancellation,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #operation }
Cancellation >> applyEffectToThis: card inThe: game [
	game removeThis: card.
]

{ #category : #query }
Cancellation >> isPermanent [
	^false
]

{ #category : #query }
Cancellation >> isRedo [
	^false
]
