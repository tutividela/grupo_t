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
	
	game := Game with: 6 laps: 2 players: {tomas . exequiel} dices: dice.
	
	game playAllTurns.


	self assert: game winner name equals: 'Tomas'.
]
