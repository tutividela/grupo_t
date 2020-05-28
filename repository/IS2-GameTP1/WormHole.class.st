Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
WormHole >> applyTo: aPlayer in: board [ 
	|playerPosition|
	playerPosition := board whereIs: aPlayer.

	board currentPosition leaves: aPlayer.

	aPlayer lapsDone == 0 & (playerPosition < 4) ifTrue: [ board resetIndex ] 
		ifFalse: [
			4 timesRepeat:  [ 
					board previousPosition . 
					(board currentPosition isCheckpoint) ifTrue: [ aPlayer decreaseLap ] 
					]. 
		].
	
		
	board currentPosition put: aPlayer .
	
]
