Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
WormHole >> applyTo: aPlayer in: board [ 
		board moveBack: aPlayer this: 4.

	
]

{ #category : #effect }
WormHole >> estimated: position in: board [ 
		^board estimatedMoveBack: position this: 4.


	
]
