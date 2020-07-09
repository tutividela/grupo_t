Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
WormHole >> applyTo: aPlayer in: board [ 
	board reversal 
	ifTrue: 	[ board moveForward: aPlayer this: 4. ]
	ifFalse: 	[ board moveBack: aPlayer this: 4. ].

	
]
