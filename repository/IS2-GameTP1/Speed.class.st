Class {
	#name : #Speed,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #operation }
Speed >> applyEffect: selfCard toThis: playerOrCard inThe: game [
	game addThis: selfCard .
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
