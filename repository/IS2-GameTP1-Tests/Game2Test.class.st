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
	"esto es una prueba"
	game := Game playedBy: {tomas . exequiel} throwing: dice onBoardOfLength: 10 during: 2.
	
	game playAllTurns.


	self assert: game winner name equals: 'Tomas'.
]
