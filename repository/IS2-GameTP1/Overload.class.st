Class {
	#name : #Overload,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #operation }
Overload >> applyEffectToThis: card inThe: game [
	game addThis: card.
]

{ #category : #query }
Overload >> applysToAllPlayers [
	^false
]

{ #category : #effect }
Overload >> extraMoves [
	^-2.
]

{ #category : #query }
Overload >> isPermanent [
	^true
]

{ #category : #query }
Overload >> isRedo [
	^false
]
