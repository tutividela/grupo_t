Class {
	#name : #Repeat,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #operation }
Repeat >> applyEffectToThis: player inThe: game [
	game board lastEffectApplied
		ifNil: [ Error signal: 'No one rolled the dices yet.' ]
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
