Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
WormHole >> applyTo: aPlayer in: board [ 
	board moveBack: aPlayer this: 4.	
	
]
