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
	super.
	tomas := Player named: 'Tomas'.
	exequiel := Player named: 'Exequiel'.

]

{ #category : #tests }
GameTest >> testBoardWithNegativeAmountOfSquares [
	| dice |
	
	dice := Die of: 6 rolling: #(5 2 5 2 5).
	
	self 
		should: [ Game playedBy: { tomas . exequiel } throwing: dice onBoardOfLength: -10 during: 3 ] 
		raise: Error 
		withMessageText: 'A Board cannot have negative amount of squares'.
]

{ #category : #tests }
GameTest >> testFinalScoreboard [
	| player3 dice1 dice2 game |
	
	player3:= Player named: 'Marcos'.
	
	dice1:= Die of: 6 rolling: #(5 5 6).
	dice2:= Die of: 6 rolling: #(5 4 1).
	
	game := Game playedBy: {tomas . exequiel . player3} throwing: (dice1 + dice2) on: (Board withNoEffectOfLength: 10) during: 3.
	
	game playAllTurns.
	
	self
		assert: game scoreboard first currentLap  equals: 3;
		assert: game scoreboard first player name equals: 'Tomas';
		
		assert: game scoreboard second currentLap  equals: 1;
		assert: game scoreboard second player name equals: 'Exequiel';
		
		assert: game scoreboard last currentLap  equals: 1;
		assert: game scoreboard last player name equals: 'Marcos'.
		
]

{ #category : #tests }
GameTest >> testGameIsOver [
	| game dice1 dice2 |

	dice1 := Die of: 6 rolling:#(3 4 1).
	dice2 := Die of: 6 rolling:#(2 5 2).
	
	game := Game playedBy: { tomas . exequiel } throwing: (dice1 + dice2) on: (Board withNoEffectOfLength: 10) during: 1.
	
	game playAllTurns.
	
	self deny: game isStillOn.  
]

{ #category : #tests }
GameTest >> testGameIsStillOn [
	| game dice1 dice2 |

	dice1 := Die of: 6 rolling:#(3 4 1).
	dice2 := Die of: 6 rolling:#(2 5 2).
		
	game := Game playedBy: { tomas . exequiel } throwing: (dice1 + dice2) onBoardOfLength: 10 during: 3.
	
	game playNextTurn ; playNextTurn.
	
	self assert: game isStillOn.  
]

{ #category : #tests }
GameTest >> testNoWinnerYet [
	| dice game |
	
	dice := Die of: 6 rolling: #(5 2 5 2 5).
	
	game := Game playedBy: { tomas . exequiel } throwing: dice onBoardOfLength: 10 during: 1.
	
	self 
		should: [ game winner ] 
		raise: Error 
		withMessageText: 'No winner yet'.
]

{ #category : #tests }
GameTest >> testPlayerIsNotInTheBoard [
	| dice game |
	
	dice := Die of: 6 rolling: #(5 2 5 2 5).
	
	game := Game playedBy: { tomas } throwing: dice onBoardOfLength: 10 during: 3.
	
	self 
		should: [ game board whereIs: exequiel ] 
		raise: Error 
		withMessageText: 'This player is not in the board.'.
]

{ #category : #tests }
GameTest >> testScoreboardUpdated [
	| game dice1 dice2 |

	dice1 := Die of: 6 rolling:#(5 6 1).
	dice2 := Die of: 6 rolling:#(3 5 2).
	game := Game playedBy: { tomas . exequiel } throwing: (dice1 + dice2) on: (Board withNoEffectOfLength: 10) during: 3.
	
	game playNextTurn.
	
	self assert: game scoreboard first player name equals: 'Tomas'.  
	
	game playNextTurn.
	
	self assert: game scoreboard first player name equals: 'Exequiel'.  
]

{ #category : #tests }
GameTest >> testWinnerEndsInCheckPoint [
	| dice game |
	
	dice := Die of: 6 rolling: #(5 2).
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: (Board withNoEffectOfLength: 10) during: 1.
	
	game playAllTurns .
	
	self
		assert: game scoreboard first currentLap equals: 1;
		assert: (game whereIs: tomas) equals: 0.
]

{ #category : #tests }
GameTest >> testWinnerInFirstPlace [
	| game dice1 dice2 |
	
	dice1 := Die of: 6 rolling:#(3 4 1).
	dice2 := Die of: 6 rolling:#(2 5 2).
	
	game := Game playedBy: { tomas . exequiel } throwing: (dice1 + dice2) on: (Board withNoEffectOfLength: 10) during: 1.

	
	game playAllTurns.
	
	self assert: game winner equals: game scoreboard first player.  
]

{ #category : #tests }
GameTest >> testWinnerOneDice [
	| dice game |

	dice := Die of: 6 rolling: #(5 2 5 2 5).
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: (Board withNoEffectOfLength: 10) during: 3.
	
	game playAllTurns.

	self assert: game winner name equals: 'Tomas'.
]

{ #category : #tests }
GameTest >> testWinnerTwoDices [
	| dice1 dice2 game |

	dice1 := Die of: 6 rolling: #(2 5).
	dice2 := Die of: 6 rolling: #(2 2).
	
	game := Game playedBy: { tomas . exequiel } throwing: (dice1 + dice2) on: (Board withNoEffectOfLength: 10) during: 2.
	
	game playAllTurns.


	self assert: game winner name equals: 'Exequiel'.
]
