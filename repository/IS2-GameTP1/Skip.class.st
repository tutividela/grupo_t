Class {
	#name : #Skip,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
Skip >> applyEffectToThis: aPlayer inThe: aGame [ 
	aGame switchTurn .
]

{ #category : #'as yet unclassified' }
Skip >> isPermanent [
	^false.
]

{ #category : #'as yet unclassified' }
Skip >> isRedo [
	^false.
]
