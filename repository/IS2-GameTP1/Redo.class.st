Class {
	#name : #Redo,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #operation }
Redo >> applyEffect: selfCard toThis: playerOrCard inThe: game [
	game lastCardPlayed 
		ifNotNil: [ 
			(selfCard = selfCard represents) ifTrue: [ selfCard represents: game lastCardPlayed].
			
			selfCard representsAssignedToAnyPlayer applyTo: playerOrCard in: game.
		]
]

{ #category : #query }
Redo >> isPermanent [
	^false
]
