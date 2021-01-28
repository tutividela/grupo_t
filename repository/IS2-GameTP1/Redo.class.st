Class {
	#name : #Redo,
	#superclass : #Object,
	#instVars : [
		'represents'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #operation }
Redo >> applyEffectToThis: playerOrCard inThe: game [
	| effect |
	
	game lastCardIsValid
		ifFalse:[ Error signal: 'No one has played a card yet' ] 
		ifTrue:[ 
		
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
