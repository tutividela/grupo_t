Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'squares',
		'dices',
		'players',
		'scoreboard'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Game class >> with: numberOfSquares players: listOfPlayers dices: listOfDices [
	
	^self new 
		initializeWith: numberOfSquares 
		playersList: listOfPlayers 
		dicesList: listOfDices 
]

{ #category : #initialization }
Game >> initializeWith: numberOfSquares playersList: listOfPlayers dicesList: listOfDices [ 
	scoreboard := listOfPlayers copy.
	squares := numberOfSquares.
	players  := CircularIterator cyclingOver: listOfPlayers.
	dices := listOfDices.
]

{ #category : #game }
Game >> isStillOn [
	^scoreboard first square <= squares.
]

{ #category : #private }
Game >> nextTurn [
	^players next.
]

{ #category : #game }
Game >> playAllTurns [
	[ self isStillOn ]
		whileTrue: [ 
			self playNextTurn.
		]
]

{ #category : #game }
Game >> playNextTurn [
	self isStillOn
		ifFalse: [ ^ 'se terminó' ].
		
	self whoPlays roll: dices.
	self updateScoboard.
	self nextTurn.
]

{ #category : #accesing }
Game >> scoreboard [
	^ scoreboard copy .
]

{ #category : #sorting }
Game >> updateScoboard [
	scoreboard sort: [ :p1 :p2 | p1 square >= p2 square ].
]

{ #category : #players }
Game >> whoPlays [
	^players current.
]

{ #category : #players }
Game >> winner [
	^scoreboard first.
]
