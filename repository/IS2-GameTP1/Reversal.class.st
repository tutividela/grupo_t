Class {
	#name : #Reversal,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #operation }
Reversal >> applyEffect: selfCard toThis: square inThe: game [
	game activePermanentCards detect: [:card | card assignedTo includes: square  ] 
		ifFound: [ :card |	game removeThis: card ]
		ifNone: [ game activePermanentCards addLast: selfCard ].
]

{ #category : #effect }
Reversal >> extraMoves [
	^0.
]

{ #category : #query }
Reversal >> isPermanent [
	^true
]
