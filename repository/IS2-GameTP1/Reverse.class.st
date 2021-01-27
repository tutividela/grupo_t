Class {
	#name : #Reverse,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
Reverse >> applyEffectToThis: aPlayer inThe: aGame [ 
	aGame reverseTurns .
]

{ #category : #'as yet unclassified' }
Reverse >> isPermanent [
	^false.
]

{ #category : #'as yet unclassified' }
Reverse >> isRedo [
	^false.
]
