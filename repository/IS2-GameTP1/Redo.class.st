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
Redo class >> actsLikeCard: aCard [
	^self new initializeLike: aCard. 
]

{ #category : #accessing }
Redo >> applyToAllPlayers [ 
	^applyToAllPlayers .
]

{ #category : #accessing }
Redo >> extraMoves [
	^extraMoves .
]

{ #category : #'as yet unclassified' }
Redo >> initializeLike: aCard [
	wildCardFrom := aCard type.
	isPermanent := aCard isPermanent .
	extraMoves := aCard extraMoves .
	applyToAllPlayers := aCard applyToAllPlayers .
]

{ #category : #testing }
Redo >> isPermanent [
	^isPermanent 
]
