Class {
	#name : #GameTests,
	#superclass : #TestCase,
	#category : #'IS2-GameTP1-Tests'
}

{ #category : #tests }
GameTests >> testCreateOnePlayer [

	| player |
	player  := Player create: 'Tomas'.
	
	self assert: (player getName) equals: 'Tomas'.
]

{ #category : #'as yet unclassified' }
GameTests >> testFinalPosition [ 
	| player1 player2 dice1 game |
	player1  := Player create: 'Tomas'.
	player2  := Player create: 'Tuti'.

	dice1 := Die of: 6 rolling: #(5 2 5 2 5).

		
	game := Game createWith: 10 players: {player1 . player2} dices: dice1.
	
	game completeGame.

	self assert: (player2 getSquare) equals: 4.
]

{ #category : #tests }
GameTests >> testItsOrderedBySquare [
	| player1 player2 player3 dice1 dice2 game |
	
	player1:= Player create: 'Exequiel'.
	player2:= Player create: 'Tomas'.
	player3:= Player create: 'Marcos'.
	
	dice1:= Die of: 6 rolling: #(2 5 6).
	dice2:= Die of: 6 rolling: #(6 4 1).
	
	game:= Game createWith: 24 players:{player1 . player2 . player3} dices:(dice1 + dice2). 
	
	game completeGame.
	
	self
		assert: (game getScoreboard first getSquare) equals: 27;
		assert: (game getScoreboard first getName ) equals: 'Tomas';
		
		assert: (game getScoreboard second getSquare) equals: 24 ;
		assert: (game getScoreboard second getName )equals: 'Exequiel';
		
		assert: (game getScoreboard last getSquare) equals: 14;
		assert: (game getScoreboard last getName) equals: 'Marcos'.
		
]

{ #category : #tests }
GameTests >> testPlayerRollDices [

	| player dice1 dice2 dices |
	dice1 := Die of: 6.
	dice2 := Die of: 6.
	player  := Player create: 'Tomas'.
	dices := dice1 + dice2.
	
	self assert: ((player rollDice: dices) between: 1 and: 12) .
]

{ #category : #tests }
GameTests >> testPlayerRollDices02 [

	| player dice1 dice2 dices |
	dice1 := Die of: 6 rolling: #(3 4 1).
	dice2 := Die of: 6 rolling: #(2 1 5).
	player := Player create: 'Tomas'.
	dices := dice1 + dice2.
	
	self assert: (player rollDice: dices) equals: 5.
]

{ #category : #tests }
GameTests >> testPlayerSequeance [

	| player1 player2 players |
	player1  := Player create: 'Tomas'.
	player2  := Player create: 'Tuti'.

	players := CircularIterator cyclingOver: {player1 . player2}.

	self
		assert: (players current getName)  equals: 'Tomas'.
		players next.
		
	self 
		assert: (players current getName)  equals: 'Tuti'.
		players next.
		

		
	
]

{ #category : #tests }
GameTests >> testScoreboard [
	"testeo que el ganador sea el que de verdad gano y no otro"
	| game player1 player2 dice1 dice2 |
	player1 := Player create: 'Tomas'.
	player2 := Player create: 'Exequiel'.
	dice1 := Die of: 6 rolling:#(3 4 1).
	dice2 := Die of: 6 rolling:#(2 5 2).
	game := Game createWith: 10 players: {player1 . player2} dices:(dice1 + dice2). 
	
	game play.
	game nextPlayer.
	
	^self assert: game getScoreboard first getName equals: 'Tomas'.  
]

{ #category : #tests }
GameTests >> testScoreboard02 [
	"testeo que el ganador sea el que de verdad gano y no otro"
	| game player1 player2 dice1 dice2 |
	player1 := Player create: 'Tomas'.
	player2 := Player create: 'Exequiel'.
	dice1 := Die of: 6 rolling:#(3 4 1).
	dice2 := Die of: 6 rolling:#(2 5 2).
	game := Game createWith: 10 players: {player1 . player2} dices:(dice1 + dice2). 
	
	game play.
	game nextPlayer.
	game play.
	game nextPlayer.
	
	^self assert: game getScoreboard first getName equals: 'Exequiel'.  
]

{ #category : #'as yet unclassified' }
GameTests >> testWinner [
	| player1 player2 dice game |
	player1 := Player create: 'Tomas'.
	player2 := Player create: 'Tuti'.

	dice := Die of: 6 rolling: #(5 2 5 2 5).
	
	game := Game createWith: 10 players: {player1 . player2} dices: dice.
	
	game completeGame.


	self assert: (game winner getName) equals: 'Tomas'.
]

{ #category : #'as yet unclassified' }
GameTests >> testWinner02 [
	| player1 player2 dice1 dice2 game |
	player1 := Player create: 'Tomas'.
	player2 := Player create: 'Tuti'.

	dice1 := Die of: 6 rolling: #(2 5 2 5 2).
	dice2 := Die of: 4 rolling: #(2 2 2 2 2).
	
	game := Game createWith: 20 players: {player1 . player2} dices: (dice1 + dice2).
	
	game completeGame.


	self assert: (game winner getName) equals: 'Tuti'.
]

{ #category : #'as yet unclassified' }
GameTests >> testWinnerRandom [
	| player1 player2 dice game |
	player1  := Player create: 'Tomas'.
	player2  := Player create: 'Tuti'.

	dice := Die of: 6.
	
	game := Game createWith: 10 players: {player1 . player2} dices: dice.
	
	game completeGame.


	game winner getName .
]

{ #category : #tests }
GameTests >> testWinnerWithScoreboard [
	"testeo que el ganador sea el que de verdad gano y no otro"
	| game player1 player2 dice1 dice2 |
	player1 := Player create: 'Tomas'.
	player2 := Player create: 'Exequiel'.
	
	dice1 := Die of: 6 rolling:#(3 4 1).
	dice2 := Die of: 6 rolling:#(2 5 2).
	
	game := Game createWith: 10 players: {player1 . player2} dices:(dice1 + dice2). 
	
	game completeGame.
	
	^self assert: game getScoreboard first getName equals: 'Exequiel'.  
]
