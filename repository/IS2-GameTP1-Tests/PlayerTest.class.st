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
PlayerTest >> testPlayerRoll [
	| player dices dice1 dice2 |
	
	player := Player named: 'Exequiel'.
	dice1:= Die of: 6 rolling: #(1 2 3).
	dice2:= Die of: 6 rolling: #(4 5 6) .
	
	dices:= dice1 + dice2.
	
	
	self assert: (player roll: dices) equals: 5.

	self assert: (player roll: dices) equals: 7.

	self assert: (player roll: dices) equals: 9.
]
