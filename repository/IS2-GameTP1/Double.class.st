Class {
	#name : #Double,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
Double >> applyEffectToThis: aPlayer inThe: aGame [ 
	aGame playNextTurn .
	aGame reverseTurns .
	aGame playNextTurn .
]

{ #category : #'as yet unclassified' }
Double >> isPermanent [
	^false.
]

{ #category : #'as yet unclassified' }
Double >> isRedo [
	^false.
]
