Class {
	#name : #Cancellation,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #operation }
Cancellation >> applyEffect: selfCard toThis: permanentCard inThe: game [.
	game removeThis: permanentCard .
]

{ #category : #query }
Cancellation >> isPermanent [
	^false
]
