Class {
	#name : #Acceleration,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
Acceleration >> applyEffectToThis: card inThe: game [
	game addThis: card.
]

{ #category : #testing }
Acceleration >> applysToAllPlayers [
	^true
]

{ #category : #testing }
Acceleration >> extraMoves [
	^1.
]

{ #category : #testing }
Acceleration >> isPermanent [
	^true
]

{ #category : #testing }
Acceleration >> isRedo [
	^false
]
