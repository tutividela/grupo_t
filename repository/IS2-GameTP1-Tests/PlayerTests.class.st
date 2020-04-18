Class {
	#name : #PlayerTests,
	#superclass : #TestCase,
	#category : #'IS2-GameTP1-Tests'
}

{ #category : #tests }
PlayerTests >> testNewSquare [
	| player dices dice1 dice2 |
	player := Player new withName: 'Exequiel'.
	dice1 := Die of: 6.
	dice2 := Die of: 6.
	dices := dice1 + dice2.
	
	player rollDice: dices. 
	
	self assert: ((player getSquare ) between: 1 and:12 ).
]

{ #category : #tests }
PlayerTests >> testRollPlayer [
	| dices player dice1 dice2 |
	dice1:= Die of: 6.
	dice2:= Die of: 6.
	"dados:= #(1 2 3)."
	
	dices := Dice new initializeWithAll: { dice1.dice2 }.
	player := Player new withName: 'Exequiel'.
	
	1 to: 100 do: [ :iterator | self assert: [ (player rollDice: dices) between: 1 and:12  ] ]. 
	"self assert:((jugador rollDice: dados ) between: 1 and: 12)."
]

{ #category : #tests }
PlayerTests >> testRollPlayer2 [
	| player dices dice1 dice2 |
	
	player := Player new withName: 'Exequiel'.
	dice1:= Die of: 6 rolling: #(1 2 3).
	dice2:= Die of: 6 rolling: #(4 5 6) .
	
	dices:= Dice new initializeWithAll: {dice1 . dice2}.
	
	player rollDice: dices.
	self assert: (player getSquare ) equals: 5.
	player rollDice: dices. 
	self assert: (player getSquare) equals: 12.
	player rollDice: dices. 
	self assert: (player getSquare) equals: 21.
]
