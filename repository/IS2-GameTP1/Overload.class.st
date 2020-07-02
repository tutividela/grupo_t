Class {
	#name : #Overload,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #operation }
Overload >> applyEffect: selfCard toThis: playerOrCard inThe: game [.
	game addThis: selfCard .
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
