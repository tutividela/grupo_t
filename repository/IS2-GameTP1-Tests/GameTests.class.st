Class {
	#name : #GameTests,
	#superclass : #TestCase,
	#category : #'IS2-GameTP1-Tests'
}

{ #category : #tests }
GameTests >> testCreateOnePlayer [

	| jugador1 |
	jugador1  := Player create: 'Tom‚àö¬∞s'.
	
	self assert: (jugador1 getName) equals: 'Tom‚àö¬∞s'.
]

{ #category : #'as yet unclassified' }
GameTests >> testFinalPosition [ 
	| player1 player2 dice1 game |
	player1  := Player create: 'Tom√°s'.
	player2  := Player create: 'Tuti'.

	dice1 := Die of: 6 rolling: #(5 2 5 2 5).

		
	game := Game createWith: 10 players: {player1 . player2} dices: dice1.
	
	game completeGame.

	self assert: (player2 getSquare) equals: 4.
]

{ #category : #tests }
GameTests >> testPlayerRollDices [

	| player dice1 dice2 dices |
	dice1 := Die of: 6.
	dice2 := Die of: 6.
	player  := Player create: 'Tom‚àö¬∞s'.
	dices := dice1 + dice2.
	
	self assert: ((player rollDice: dices) between: 1 and: 12) .
]

{ #category : #tests }
GameTests >> testPlayerRollDices02 [

	| player dice1 dice2 dices |
	dice1 := Die of: 6 rolling: #(3 4 1).
	dice2 := Die of: 6 rolling: #(2 1 5).
	player := Player create: 'Tom‚àö¬∞s'.
	dices := dice1 + dice2.
	
	self assert: (player rollDice: dices) equals: 5.
]

{ #category : #tests }
GameTests >> testPlayerSequeance [

	| player1 player2 players |
	player1  := Player create: 'Tom‚àö¬∞s'.
	player2  := Player create: 'Tuti'.

	players := CircularIterator cyclingOver: {player1 . player2}.

	self
		assert: (players current getName)  equals: 'Tom‚àö¬∞s'.
		players next.
		
	self 
		assert: (players current getName)  equals: 'Tuti'.
		players next.
		

		
	
]

{ #category : #'as yet unclassified' }
GameTests >> testWinner [
	| player1 player2 dice game |
	player1  := Player create: 'Tom√°s'.
	player2  := Player create: 'Tuti'.

	dice := Die of: 6 rolling: #(5 2 5 2 5).
	
	game := Game createWith: 10 players: {player1 . player2} dices: dice.
	
	game completeGame.


	self assert: (game winner getName) equals: 'Tom√°s'.
]

{ #category : #'as yet unclassified' }
GameTests >> testWinner02 [
	| player1 player2 dice1 dice2 game |
	player1  := Player create: 'Tom√°s'.
	player2  := Player create: 'Tuti'.

	dice1 := Die of: 6 rolling: #(2 5 2 5 2).
	dice2 := Die of: 4 rolling: #(2 2 2 2 2).
	
	game := Game createWith: 20 players: {player1 . player2} dices: (dice1 + dice2).
	
	game completeGame.


	self assert: (game winner getName) equals: 'Tuti'.
]

{ #category : #'as yet unclassified' }
GameTests >> testWinnerRandom [
	| player1 player2 dice game |
	player1  := Player create: 'Tom‚àö¬∞s'.
	player2  := Player create: 'Tuti'.

	dice := Die of: 6.
	
	game := Game createWith: 10 players: {player1 . player2} dices: dice.
	
	game completeGame.


	game winner getName .
]
