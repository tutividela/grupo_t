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
Game2Test >> testAtomicBomb [
	|dice game|
	dice:= Die of: 8 rolling:#(5 4) .
	game:=Game with: 10 laps:2  players:{tomas.exequiel }  dices:dice .
	game playNextTurn .
	game playNextTurn .
	game board squares reset.
	self assert: (game board squares current players asArray includes:exequiel);
		assert:(game board squares current players asArray includes:tomas).
]

{ #category : #tests }
Game2Test >> testMoonWalk [
	|dice game|
	dice:= Die of: 8 rolling:#(8 3).
	game :=Game with: 10 laps:2  players:{exequiel.tomas}  dices:dice .
	game playNextTurn .
	game playNextTurn .
	self assert: ((game board findPlayer:exequiel) squares currentIndex)equals: 3;
		assert:((game board findPlayer: tomas) squares currentIndex )equals:3. 
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
