Class {
	#name : #Game2Test,
	#superclass : #TestCase,
	#instVars : [
		'tomas',
		'exequiel'
	],
	#category : #'IS2-GameTP1-Tests'
}

{ #category : #running }
Game2Test >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	tomas := Player named: 'Tomas'.
	exequiel := Player named: 'Exequiel'.

]

{ #category : #tests }
Game2Test >> testGame [
	| dice game |

	dice := Die of: 6 rolling: #(5 2 5 2 5).
	
	game := Game playedBy: {tomas.exequiel  }  throwing:dice  onBoardLength:10  during:2 .
	
	game playAllTurns.


	self assert: game winner name equals: 'Tomas'.
]

{ #category : #tests }
Game2Test >> testSpeedUp [
	|dice game|
	dice:= Die of: 6 rolling: #(1). 
	game:= Game with: 10 laps:2  players:{exequiel.tomas}  dices:dice.
	game playNextTurn .
	game board findPlayer: exequiel .
	self assert: game board squares currentIndex equals: 5.
	"self assert:(((game board squares) options at: 5) players first equals: exequiel)."
		
	
]

{ #category : #tests }
Game2Test >> testWormHole [
	|dice game|
	dice:= Die of: 7 rolling: #(7). 
	game:= Game with: 5 laps:2  players:{exequiel.tomas}  dices:dice.
	game playNextTurn .
	
	game board findPlayer: exequiel.
	self assert: game board squares currentIndex equals: 3.
]
