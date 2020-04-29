Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'tomas',
		'exequiel'
	],
	#category : #'IS2-GameTP1-Tests'
}

{ #category : #running }
GameTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	tomas := Player named: 'Tomas'.
	exequiel := Player named: 'Exequiel'.
]

{ #category : #tests }
GameTest >> testFinalPosition [ 
	| dice game |

	dice := Die of: 6 rolling: #(5 2 5 2 5).

	game := Game with: 10 players: {tomas . exequiel} dices: dice.
	
	game playAllTurns.

	self assert: exequiel square equals: 4.
]

{ #category : #tests }
GameTest >> testFinalScoreboard [
	| player3 dice1 dice2 game |
	
	player3:= Player named: 'Marcos'.
	
	dice1:= Die of: 6 rolling: #(2 5 6).
	dice2:= Die of: 6 rolling: #(6 4 1).
	
	game:= Game with: 24 players:{exequiel  . tomas . player3} dices:(dice1 + dice2). 
	
	game playAllTurns.
	
	self
		assert: game scoreboard first square equals: 27;
		assert: game scoreboard first name equals: 'Tomas';
		
		assert: game scoreboard second square equals: 24 ;
		assert: game scoreboard second name equals: 'Exequiel';
		
		assert: game scoreboard last square equals: 14;
		assert: game scoreboard last name equals: 'Marcos'.
		
]

{ #category : #tests }
GameTest >> testGameIsOver [
	| game dice1 dice2 |

	dice1 := Die of: 6 rolling:#(3 4 1).
	dice2 := Die of: 6 rolling:#(2 5 2).
	game := Game with: 10 players: {tomas . exequiel} dices:(dice1 + dice2). 
	
	game playAllTurns.
	
	self deny: game isStillOn.  
]

{ #category : #tests }
GameTest >> testGameIsStillOn [
	| game dice1 dice2 |

	dice1 := Die of: 6 rolling:#(3 4 1).
	dice2 := Die of: 6 rolling:#(2 5 2).
	game := Game with: 10 players: {tomas . exequiel} dices:(dice1 + dice2). 
	
	game playNextTurn ; playNextTurn.
	
	self assert: game isStillOn.  
]

{ #category : #tests }
GameTest >> testIfTheScoreboardIsUpdated [
	| game dice1 dice2 |

	dice1 := Die of: 6 rolling:#(3 4 1).
	dice2 := Die of: 6 rolling:#(2 5 2).
	game := Game with: 10 players: {tomas . exequiel} dices:(dice1 + dice2). 
	
	game playNextTurn.
	
	self assert: game scoreboard first name equals: 'Tomas'.  
	
	game playNextTurn.
	
	self assert: game scoreboard first name equals: 'Exequiel'.  
]

{ #category : #tests }
GameTest >> testIfTheWinnerIsInFirstPlace [
	| game dice1 dice2 |
	
	dice1 := Die of: 6 rolling:#(3 4 1).
	dice2 := Die of: 6 rolling:#(2 5 2).
	
	game := Game with: 10 players: {tomas . exequiel } dices:(dice1 + dice2). 
	
	game playAllTurns.
	
	self assert: game winner equals: game scoreboard first.  
]

{ #category : #tests }
GameTest >> testWinnerOneDice [
	| dice game |

	dice := Die of: 6 rolling: #(5 2 5 2 5).
	
	game := Game with: 10 players: {tomas . exequiel} dices: dice.
	
	game playAllTurns.


	self assert: game winner name equals: 'Tomas'.
]

{ #category : #tests }
GameTest >> testWinnerTwoDices [
	| dice1 dice2 game |

	dice1 := Die of: 6 rolling: #(2 5 2 5 2).
	dice2 := Die of: 4 rolling: #(2 2 2 2 2).
	
	game := Game with: 20 players: {tomas . exequiel} dices: (dice1 + dice2).
	
	game playAllTurns.


	self assert: game winner name equals: 'Exequiel'.
]
