Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
SpeedUp >> applyTo: aPlayer in: board [ 
	board reversal 
	ifTrue: 	[ board moveBack: aPlayer this: 4. ]
	ifFalse: [ board moveForward: aPlayer this: 4. ].

	
]
