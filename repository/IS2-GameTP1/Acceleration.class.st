Class {
	#name : #Acceleration,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #operation }
Acceleration >> applyEffect: selfCard toThis: playerOrCard inThe: game [.
	game addThis: selfCard.
]

{ #category : #query }
Acceleration >> applysToAllPlayers [
	^true
]

{ #category : #effect }
Acceleration >> extraMoves [
	^1.
]

{ #category : #query }
Acceleration >> isPermanent [
	^true
]

{ #category : #query }
Acceleration >> isRedo [
	^false
]
