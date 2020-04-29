Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IS2-GameTP1-Tests'
}

{ #category : #tests }
PlayerTest >> testCreateAPlayer [
	| player |
	player  := Player named: 'Tomas'.
	
	self assert: player name equals: 'Tomas'.
]

{ #category : #tests }
PlayerTest >> testNewSquare [
	| player dices dice1 dice2 |
	player := Player named: 'Exequiel'.
	dice1 := Die of: 6.
	dice2 := Die of: 6.
	dices := dice1 + dice2.
	
	player roll: dices. 
	
	self assert: (player square between: 1 and:12 ).
]

{ #category : #tests }
PlayerTest >> testPlayerRollDeterministicDices [
	| player dices dice1 dice2 |
	
	player := Player named: 'Exequiel'.
	dice1:= Die of: 6 rolling: #(1 2 3).
	dice2:= Die of: 6 rolling: #(4 5 6) .
	
	dices:= dice1 + dice2.
	
	player roll: dices.
	self assert: player square equals: 5.
	player roll: dices. 
	self assert: player square equals: 12.
	player roll: dices. 
	self assert: player square equals: 21.
]

{ #category : #tests }
PlayerTest >> testPlayerRollRandomDice [
	| player dice |
	dice := Die of: 6.

	player := Player named: 'Exequiel'.

	100 timesRepeat: (self assert: ( (player roll: dice) between: 1 and:12)).

]
