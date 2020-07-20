Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
WormHole >> applyTo: aPlayer in: board with: reversalMode [
	reversalMode
	ifTrue: 	[ board moveForward: aPlayer this: 4. ]
	ifFalse: 	[ board moveBack: aPlayer this: 4. ].

	
]

{ #category : #effect }
WormHole >> estimated: position in: board with: reversalMode [
	reversalMode
	ifTrue: [ ^board estimatedMoveFoward: position this: 4 ]
	ifFalse:	[ ^board estimatedMoveBack: position this: 4 ].


	
]
