Class {
	#name : #Speed,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #operation }
Speed >> applyEffect: selfCard toThis: playerOrCard inThe: game [
	game activePermanentCards addLast: selfCard .
]

{ #category : #effect }
Speed >> extraMoves [
	^1.
]

{ #category : #query }
Speed >> isPermanent [
	^true
]
