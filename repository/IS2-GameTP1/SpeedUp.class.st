Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
SpeedUp >> applyTo: aPlayer in: board [ 
	board currentPosition leaves: aPlayer.
	4 timesRepeat: [  board nextPosition isCheckpoint ifTrue: [ aPlayer registerLap  ] ].
	board currentPosition put: aPlayer . 
	
]
