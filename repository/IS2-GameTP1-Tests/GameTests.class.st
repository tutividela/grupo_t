Class {
	#name : #GameTests,
	#superclass : #TestCase,
	#category : #'IS2-GameTP1-Tests'
}

{ #category : #tests }
GameTests >> testFinalPosition [ 
	| player1 player2 dice1 game |
	player1  := Player create: 'Tomas'.
	player2  := Player create: 'Tuti'.

	dice1 := Die of: 6 rolling: #(5 2 5 2 5).

		
	game := Game createWith: 10 players: {player1 . player2} dices: dice1.
	
	game complete.

	self assert: (player2 getSquare) equals: 4.
]

{ #category : #tests }
GameTests >> testFinalScoreboard [
	| player1 player2 player3 dice1 dice2 game |
	
	player1:= Player create: 'Exequiel'.
	player2:= Player create: 'Tomas'.
	player3:= Player create: 'Marcos'.
	
	dice1:= Die of: 6 rolling: #(2 5 6).
	dice2:= Die of: 6 rolling: #(6 4 1).
	
	game:= Game createWith: 24 players:{player1 . player2 . player3} dices:(dice1 + dice2). 
	
	game complete.
	
	self
		assert: (game getScoreboard first getSquare) equals: 27;
		assert: (game getScoreboard first getName ) equals: 'Tomas';
		
		assert: (game getScoreboard second getSquare) equals: 24 ;
		assert: (game getScoreboard second getName )equals: 'Exequiel';
		
		assert: (game getScoreboard last getSquare) equals: 14;
		assert: (game getScoreboard last getName) equals: 'Marcos'.
		
]

{ #category : #tests }
GameTests >> testGameIsOver [

	| game player1 player2 dice1 dice2 |
	player1 := Player create: 'Tomas'.
	player2 := Player create: 'Exequiel'.
	dice1 := Die of: 6 rolling:#(3 4 1).
	dice2 := Die of: 6 rolling:#(2 5 2).
	game := Game createWith: 10 players: {player1 . player2} dices:(dice1 + dice2). 
	
	game complete.
	
	^self assert: game isStillOn equals: false.  
]

{ #category : #tests }
GameTests >> testGameIsStillOn [

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
	
	^self assert: game isStillOn equals: true.  
]

{ #category : #tests }
GameTests >> testNextPlayerToPlay [

	| game player1 player2 dice1 dice2 |
	player1 := Player create: 'Tomas'.
	player2 := Player create: 'Exequiel'.
	dice1 := Die of: 6 rolling:#(3 4 1).
	dice2 := Die of: 6 rolling:#(2 5 2).
	game := Game createWith: 10 players: {player1 . player2} dices:(dice1 + dice2). 
	
	game play.
	game nextPlayer.
	
	^self assert: game whoPlays getName equals: 'Exequiel'.  
]

{ #category : #tests }
GameTests >> testScoreboardGameIsInProgress [

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
GameTests >> testScoreboardGameIsInProgress02 [
	
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

{ #category : #tests }
GameTests >> testWinnerOneDice [
	| player1 player2 dice game |
	player1 := Player create: 'Tomas'.
	player2 := Player create: 'Tuti'.

	dice := Die of: 6 rolling: #(5 2 5 2 5).
	
	game := Game createWith: 10 players: {player1 . player2} dices: dice.
	
	game complete.


	self assert: (game winner getName) equals: 'Tomas'.
]

{ #category : #tests }
GameTests >> testWinnerRandom [
	| player1 player2 dice game |
	player1  := Player create: 'Tomas'.
	player2  := Player create: 'Tuti'.

	dice := Die of: 6.
	
	game := Game createWith: 10 players: {player1 . player2} dices: dice.
	
	game complete.


	game winner getName .
]

{ #category : #tests }
GameTests >> testWinnerTwoDices [
	| player1 player2 dice1 dice2 game |
	player1 := Player create: 'Tomas'.
	player2 := Player create: 'Tuti'.

	dice1 := Die of: 6 rolling: #(2 5 2 5 2).
	dice2 := Die of: 4 rolling: #(2 2 2 2 2).
	
	game := Game createWith: 20 players: {player1 . player2} dices: (dice1 + dice2).
	
	game complete.


	self assert: (game winner getName) equals: 'Tuti'.
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
	
	game complete.
	
	^self assert: game getScoreboard first equals: (game winner).  
]
