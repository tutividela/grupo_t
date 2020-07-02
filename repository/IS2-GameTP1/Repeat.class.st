Class {
	#name : #Repeat,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #operation }
Repeat >> applyEffect: selfCard toThis: playerOrCard inThe: game [
	game board lastEffectApplied
		ifNotNil: [ 
			game applyTheLastEffectOverTheLastPlayer.
		]
]

{ #category : #query }
Repeat >> isPermanent [
	^false
]

{ #category : #query }
Repeat >> isRedo [
	^false
]
