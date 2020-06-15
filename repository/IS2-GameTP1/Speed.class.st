Class {
	#name : #Speed,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
Speed >> applyEffectToThis: card inThe: game [
	game addThis: card.
]

{ #category : #testing }
Speed >> applysToAllPlayers [
	^false
]

{ #category : #testing }
Speed >> extraMoves [
	^1.
]

{ #category : #testing }
Speed >> isPermanent [
	^true
]

{ #category : #testing }
Speed >> isRedo [
	^false
]
