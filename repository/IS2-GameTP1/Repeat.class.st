Class {
	#name : #Repeat,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #accessing }
Repeat >> applyEffectToThis: player inThe: game [
	game board lastEffectApplied
		ifNil: [ Error signal: 'No one rolled the dices yet.' ]
		ifNotNil: [ 
			game applyTheLastEffectOverTheLastPlayer.
		]
]

{ #category : #testing }
Repeat >> isPermanent [
	^false
]

{ #category : #testing }
Repeat >> isRedo [
	^false
]
