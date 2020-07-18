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

{ #category : #effect }
WormHole >> estimated: aPosition in: board [ 
	board reversal 
	ifTrue: [ ^board estimatedMoveFoward: aPosition this: 4 ]
	ifFalse:	[ ^board estimatedMoveBack: aPosition this: 4 ].


	
]
