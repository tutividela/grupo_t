Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
AtomicBomb >> applyTo: aPlayer in: board [ 
	| players |
	
	players:= OrderedCollection new.
	
	board goAllOverTheBoard: [ 
		players addAll: board playersOfCurrentPosition. 
		board playersOfCurrentPosition removeAll.
	].

	board currentSquare putASet: players.
	
	board positions do: [:position | position registerSquare: 0 ]
	
		
	
	
]

{ #category : #effect }
AtomicBomb >> estimated: aPosition in: board [ 
	^(aPosition registerSquare: 0) copy.
	
		
	
	
]
