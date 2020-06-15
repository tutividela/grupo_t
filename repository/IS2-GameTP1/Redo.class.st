Class {
	#name : #Redo,
	#superclass : #Object,
	#instVars : [
		'wildCardFrom',
		'isPermanent',
		'applyToAllPlayers',
		'extraMoves'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
Redo >> applyEffectToThis: playerOrCard inThe: game [
	| effect |
	
	game lastCardPlayed 
		ifNil: [ Error signal: 'No one has played a card yet' ] 
		ifNotNil: [ 
		
			represents := game lastCardPlayed type.
			effect := represents.
			
			[effect isRedo] whileTrue: [ 
				effect := effect represents .
				 ].
			
			(Card type: effect) applyTo: playerOrCard in: game.
		]
]

{ #category : #testing }
Redo >> isPermanent [
	^false
]

{ #category : #accessing }
Redo >> isRedo [
	^true
]

{ #category : #accessing }
Redo >> represents [
	^represents.
]
