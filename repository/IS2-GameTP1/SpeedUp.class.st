Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
SpeedUp >> applyTo: aPlayer in: board [ 
	board moveForward: aPlayer this: 4.
	
]
