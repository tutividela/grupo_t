Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
SpeedUp >> applyTo: aPlayer in: board [ 
	board currentSquare leaves: aPlayer.
	4 timesRepeat: [  board nextSquare isCheckpoint ifTrue: [ (board positionOf: aPlayer ) registerLap ] ].
	board currentSquare put: aPlayer . 
	
]
