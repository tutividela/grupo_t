Class {
	#name : #Redo,
	#superclass : #Object,
	#instVars : [
		'represents'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #operation }
Redo >> applyEffect: selfCard toThis: playerOrCard inThe: game [
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

{ #category : #query }
Redo >> isPermanent [
	^false
]

{ #category : #query }
Redo >> isRedo [
	^true
]

{ #category : #accessing }
Redo >> represents [
	^represents.
]
