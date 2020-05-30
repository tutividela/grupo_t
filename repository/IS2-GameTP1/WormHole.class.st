Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
WormHole >> applyTo: aPlayer in: board [ 
	|playerPosition|
	playerPosition := board whereIs: aPlayer.

	board currentSquare leaves: aPlayer.

	(board positionOf: aPlayer ) currentLap  == 0 & (playerPosition < 4) ifTrue: [ board goToCheckpoint ] 
		ifFalse: [
			4 timesRepeat:  [ 
					board previousSquare . 
					(board currentSquare isCheckpoint) ifTrue: [ (board positionOf: aPlayer ) decreaseALap  ] 
					]. 
		].
	
		
	board currentSquare put: aPlayer .
	
]
