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

{ #category : #'as yet unclassified' }
Game class >> createWith: numberOfSquares players: listOfPlayers dices: listOfDices [
	
	^self new 
		setWith: numberOfSquares 
		playersList: listOfPlayers 
		dicesList: listOfDices 
]

{ #category : #'as yet unclassified' }
Game >> completeGame [
	[ self gameContinues ]
		whileTrue: [ 
			self play.
			self nextPlayer 
		]
]

{ #category : #'as yet unclassified' }
Game >> gameContinues [
	| result |
	result := true.
	(players options) do: [ :player | (player getSquare > squares ) ifTrue: [result := false] ].
	^result.
]

{ #category : #'as yet unclassified' }
Game >> getPlayers [
	^players.
]

{ #category : #'as yet unclassified' }
Game >> getScoreboard [
	^ scoreboard .
]

{ #category : #'as yet unclassified' }
Game >> nextPlayer [
	^players next.
]

{ #category : #'as yet unclassified' }
Game >> play [
	self whoPlays rollDice: dices.
	self updateScoboard.
]

{ #category : #'as yet unclassified' }
Game >> setWith: numberOfSquares playersList: listOfPlayers dicesList: listOfDices [ 
	scoreboard := listOfPlayers collect: [:player | player].
	squares := numberOfSquares.
	players  := CircularIterator cyclingOver: listOfPlayers.
	dices := listOfDices.
]

{ #category : #sorting }
Game >> updateScoboard [
	scoreboard sort: [ :p1 :p2 | p1 getSquare >= p2 getSquare ].
]

{ #category : #'as yet unclassified' }
Game >> whoPlays [
	^players current.
]

{ #category : #'as yet unclassified' }
Game >> winner [
	| result |
	(players options) do: [ :player | (player getSquare > squares ) ifTrue: [result := player] ].
	^result.
]
