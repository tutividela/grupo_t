Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'tomas',
		'exequiel'
	],
	#category : #'IS2-GameTP1-Tests'
}

{ #category : #board }
GameTest >> aBoard [
	^Board with: { 	CheckPointSquare with: NoEffect new.
						Square with: SpeedUp new .
						Square with: WormHole  new .
						
						Square with: (MoonW withRecoil: 5) .
						Square with: AtomicBomb  new.
						Square with: NoEffect new .
						
						Square with: NoEffect new.
						Square with: NoEffect new .
						Square with: NoEffect new .
						
						Square with: NoEffect new  				
						}.
]

{ #category : #board }
GameTest >> aBoard02 [
	^Board with: { 	CheckPointSquare with: NoEffect new.
						Square with: SpeedUp new .					
						Square with: (MoonW withRecoil: 5) .
						
						Square with: AtomicBomb  new.
						Square with: NoEffect new .
						Square with: NoEffect new.
						
						Square with: WormHole  new .
						Square with: NoEffect new .
						Square with: NoEffect new .
						
						Square with: NoEffect new  				
						}.
]

{ #category : #board }
GameTest >> aBoard03 [
	^Board with: { 	CheckPointSquare with: NoEffect new.
						Square with: SpeedUp new .
						Square with: WormHole  new .
						
						Square with: (MoonW withRecoil: 2) .
						Square with: AtomicBomb  new.
						Square with: NoEffect new .
						
						Square with: NoEffect new.
						Square with: NoEffect new .
						Square with: NoEffect new .
						
						Square with: NoEffect new  				
						}.
]

{ #category : #board }
GameTest >> aBoard04 [
	^Board with: { 	CheckPointSquare with: NoEffect new.
						Square with: SpeedUp new .
						Square with: WormHole  new .
						
						Square with: (MoonW withRecoil: 7) .
						Square with: AtomicBomb  new.
						Square with: NoEffect new .
						
						Square with: NoEffect new.
						Square with: NoEffect new .
						Square with: NoEffect new .
						
						Square with: NoEffect new  				
						}.
]

{ #category : #running }
GameTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	tomas := Player named: 'Tomas'.
	exequiel := Player named: 'Exequiel'.

]

{ #category : #tests }
GameTest >> testAtomicBombWhenNoLapsWereDone [
	| dice game |
	dice := Die of: 6 rolling: #(6 4). 

	game := Game playedBy: {tomas . exequiel} throwing: dice on: self aBoard during: 2.

	game playNextTurn .
	game playNextTurn .
	
	self 	assert: ( game whereIs: tomas ) equals: 0;
			assert: ( game whereIs: exequiel ) equals: 0.
]

{ #category : #tests }
GameTest >> testAtomicBombWhenOneLapIsDone [
	| dice game |
	dice := Die of: 6 rolling: #(5 5 5 3 4). 

	game := Game playedBy: {tomas . exequiel} throwing: dice on: self aBoard during: 2.

	game playNextTurn .
	game playNextTurn .
	game playNextTurn .
	game playNextTurn .
	game playNextTurn .
	
	self 	assert: ( game whereIs: tomas ) equals: 0;
			assert: (tomas lapsDone) equals: 1;
			assert: ( game whereIs: exequiel ) equals: 0;
			assert: (exequiel lapsDone)equals: 0.
]

{ #category : #tests }
GameTest >> testFinalScoreboard [
	| player3 dice1 dice2 game |
	
	player3:= Player named: 'Marcos'.
	
	dice1:= Die of: 6 rolling: #(5 5 6).
	dice2:= Die of: 6 rolling: #(5 4 1).
	
	game := Game playedBy: {tomas . exequiel . player3} throwing: (dice1 + dice2) on: self aBoard02 during: 3.
	
	game playAllTurns.
	
	self
		assert: game scoreboard first lapsDone  equals: 3;
		assert: game scoreboard first name equals: 'Tomas';
		
		assert: game scoreboard second lapsDone  equals: 1;
		assert: game scoreboard second name equals: 'Exequiel';
		
		assert: game scoreboard last lapsDone  equals: 1;
		assert: game scoreboard last name equals: 'Marcos'.
		
]

{ #category : #tests }
GameTest >> testGameIsOver [
	| game dice1 dice2 |

	dice1 := Die of: 6 rolling:#(3 4 1).
	dice2 := Die of: 6 rolling:#(2 5 2).
	
	game := Game playedBy: { tomas . exequiel } throwing: (dice1 + dice2) on: self aBoard02 during: 3.
	
	game playAllTurns.
	
	self deny: game isStillOn.  
]

{ #category : #tests }
GameTest >> testGameIsStillOn [
	| game dice1 dice2 |

	dice1 := Die of: 6 rolling:#(3 4 1).
	dice2 := Die of: 6 rolling:#(2 5 2).
	game := Game playedBy: { tomas . exequiel } throwing: (dice1 + dice2) on: self aBoard02 during: 3.
	
	game playNextTurn ; playNextTurn.
	
	self assert: game isStillOn.  
]

{ #category : #tests }
GameTest >> testIfTheScoreboardIsUpdated [
	| game dice1 dice2 |

	dice1 := Die of: 6 rolling:#(5 6 1).
	dice2 := Die of: 6 rolling:#(3 5 2).
	game := Game playedBy: { tomas . exequiel } throwing: (dice1 + dice2) on: self aBoard02 during: 3.
	
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
	
	game := Game playedBy: { tomas . exequiel } throwing: (dice1 + dice2) on: self aBoard02 during: 3.
	
	game playAllTurns.
	
	self assert: game winner equals: game scoreboard first.  
]

{ #category : #tests }
GameTest >> testMoonW [
	| dice game |
	dice := Die of: 6 rolling: #(1 3). 

	game := Game playedBy: {exequiel . tomas} throwing: dice on: self aBoard03 during: 2.

	game playNextTurn .
	game playNextTurn .
	
	self 	assert: ( game whereIs: tomas ) equals: 3;
			assert: ( game whereIs: exequiel ) equals: 3.
]

{ #category : #tests }
GameTest >> testMoonWalk [
	| dice game player3|
	
	dice := Die of: 8 rolling: #(8 7 3).
	player3:=Player named: 'Marcos'.
	game := Game playedBy: {exequiel. player3 . tomas} throwing: dice on: self aBoard during: 2.
	
	game playNextTurn.
	game playNextTurn.
	game playNextTurn .
	
	self 	assert: (game whereIs: exequiel ) equals: 3;
		  	assert: (game whereIs: tomas) equals: 3;
			assert: (game whereIs: player3 )equals:2.
]

{ #category : #tests }
GameTest >> testNoWinnerYet [
	| dice game |
	
	dice := Die of: 6 rolling: #(5 2 5 2 5).
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: self aBoard02 during: 3.
	
	self 
		should: [ game winner ] 
		raise: Error 
		description: 'No winner yet'.
]

{ #category : #tests }
GameTest >> testSpeedUpEffect [
	| dice game |
	dice := Die of: 6 rolling: #(1). 

	game := Game playedBy: {exequiel . tomas} throwing: dice on: self aBoard during: 2.

	game playNextTurn .
	
	self assert: ( game whereIs: exequiel ) equals: 5.
]

{ #category : #tests }
GameTest >> testWinnerEndsInCheckPoint [
	| dice game |
	
	dice := Die of: 6 rolling: #(5 2).
	
	game := Game playedBy: { tomas } throwing: dice on: self aBoard02 during: 1.
	
	game playAllTurns .
	
	self
		assert: game scoreboard first lapsDone  equals: 1;
		assert: (game whereIs: tomas) equals: 0.
]

{ #category : #tests }
GameTest >> testWinnerOneDice [
	| dice game |

	dice := Die of: 6 rolling: #(5 2 5 2 5).
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: self aBoard02 during: 3.
	
	game playAllTurns.

	self assert: game winner name equals: 'Tomas'.
]

{ #category : #tests }
GameTest >> testWinnerTwoDices [
	| dice1 dice2 game |

	dice1 := Die of: 6 rolling: #(2 5 2 5 2).
	dice2 := Die of: 4 rolling: #(2 2 2 2 2).
	
	game := Game playedBy: { tomas . exequiel } throwing: (dice1 + dice2) on: self aBoard02 during: 3.
	
	game playAllTurns.


	self assert: game winner name equals: 'Tomas'.
]

{ #category : #tests }
GameTest >> testWormHoleWhenCeroLapsAndRollResultGreaterThanFour [
	| dice game |
	dice := Die of: 6 rolling: #(6). 

	game := Game playedBy: {exequiel . tomas} throwing: dice on: self aBoard02 during: 2.

	game playNextTurn .
	
	self assert: ( game whereIs: exequiel ) equals: 2.
]

{ #category : #tests }
GameTest >> testWormHoleWhenCeroLapsAndRollResultLessThanFour [
	| dice game |
	dice := Die of: 7 rolling: #(2). 

	game := Game playedBy: {exequiel . tomas} throwing: dice on: self aBoard during: 2.

	game playNextTurn .
	
	self assert: ( game whereIs: exequiel ) equals: 0.
]

{ #category : #tests }
GameTest >> testWormHoleWhenOneLapIsDone [
	| dice game |
	dice := Die of: 6 rolling: #(6 6). 

	game := Game playedBy: {tomas} throwing: dice on: self aBoard during: 2.

	game playNextTurn .
	game playNextTurn .
	
	self assert: ( game whereIs: tomas ) equals: 8.
]
