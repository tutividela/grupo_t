Class {
	#name : #PlayerTests,
	#superclass : #TestCase,
	#category : #'IS2-GameTP1-Tests'
}

{ #category : #tests }
PlayerTests >> testNewSquare [
	|jugador dados d1 d2|
	jugador := Player new withName: 'Exequiel'.
	d1:= Die of: 6.
	d2:= Die of: 6.
	dados:= Dice new initializeWithAll: {d1.d2}.
	jugador rollDice: dados. 
	self assert: ((jugador getSquare ) between: 1 and:12 ).
]

{ #category : #tests }
PlayerTests >> testRollPlayer [
	|dados jugador d4 d1|
	d4:= Die of: 6.
	d1:= Die of: 6.
	"dados:= #(1 2 3)."
	dados := Dice new initializeWithAll: { d4.d1 }.
	jugador := Player new withName: 'Exequiel'.
	1 to: 100 do: [ :iterator | self assert: [ (jugador rollDice: dados) between: 1 and:12  ] ]. 
	"self assert:((jugador rollDice: dados ) between: 1 and: 12)."
]

{ #category : #tests }
PlayerTests >> testRollPlayer2 [
	|jugador dados d1 d2|
	jugador := Player new withName: 'Exequiel'.
	d1:= Die of: 6 rolling: #(1 2 3).
	d2:= Die of: 6 rolling: #(4 5 6) .
	dados:= Dice new initializeWithAll: {d1.d2}.
	jugador rollDice: dados. 
	self assert: (jugador getSquare ) equals: 5.
	jugador rollDice: dados. 
	self assert: (jugador getSquare) equals: 12.
	jugador rollDice: dados. 
	self assert: (jugador getSquare) equals: 21.
]
