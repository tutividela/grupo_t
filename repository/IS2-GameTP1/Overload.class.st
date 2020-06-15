Class {
	#name : #Overload,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
Overload >> applyEffectToThis: card inThe: game [
	game addThis: card.
]

{ #category : #testing }
Overload >> applysToAllPlayers [
	^false
]

{ #category : #testing }
Overload >> extraMoves [
	^-2.
]

{ #category : #testing }
Overload >> isPermanent [
	^true
]

{ #category : #testing }
Overload >> isRedo [
	^false
]
