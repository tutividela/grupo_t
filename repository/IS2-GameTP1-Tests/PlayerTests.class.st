Class {
	#name : #PlayerTests,
	#superclass : #TestCase,
	#category : #'IS2-GameTP1-Tests'
}

{ #category : #tests }
PlayerTests >> testCreateAPlayer [

	| player |
	player  := Player create: 'Tomas'.
	
	self assert: (player getName) equals: 'Tomas'.
]

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
PlayerTests >> testPlayerSequeance [

	| player1 player2 players |
	player1  := Player create: 'Tomas'.
	player2  := Player create: 'Tuti'.

	players := CircularIterator cyclingOver: {player1 . player2}.

	self
		assert: (players current getName)  equals: 'Tomas'.
		players next.
		
	self 
		assert: (players current getName)  equals: 'Tuti'.
		players next.
		

		
	
]

{ #category : #tests }
PlayerTests >> testRollPlayer [
	| dices player dice1 dice2 |
	dice1:= Die of: 6.
	dice2:= Die of: 6.
	
	dices := dice1 + dice2.
	player := Player new withName: 'Exequiel'.
	
	1 to: 100 do: [ :iterator | self assert: [ (player rollDice: dices) between: 1 and:12  ] ]. 

]

{ #category : #tests }
PlayerTests >> testRollPlayer2 [
	| player dices dice1 dice2 |
	
	player := Player new withName: 'Exequiel'.
	dice1:= Die of: 6 rolling: #(1 2 3).
	dice2:= Die of: 6 rolling: #(4 5 6) .
	
	dices:= dice1 + dice2.
	
	player rollDice: dices.
	self assert: (player getSquare ) equals: 5.
	player rollDice: dices. 
	self assert: (player getSquare) equals: 12.
	player rollDice: dices. 
	self assert: (player getSquare) equals: 21.
]
