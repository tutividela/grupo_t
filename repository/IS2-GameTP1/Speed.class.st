Class {
	#name : #Speed,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #operation }
Speed >> applyEffectToThis: card inThe: game [
	game addThis: card.
]

{ #category : #query }
Speed >> applysToAllPlayers [
	^false
]

{ #category : #effect }
Speed >> extraMoves [
	^1.
]

{ #category : #query }
Speed >> isPermanent [
	^true
]

{ #category : #query }
Speed >> isRedo [
	^false
]
