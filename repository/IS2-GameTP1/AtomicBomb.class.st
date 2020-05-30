Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
AtomicBomb >> applyTo: aPlayer in: board [ 
	| players |
	
	players:= OrderedCollection new.
	board goToCheckpoint.
	[ board nextSquare isCheckpoint ] whileFalse: [ 
		players addAll: board playersOfCurrentPosition. 
		board playersOfCurrentPosition removeAll.
	].

	board currentSquare putASet: players.
	
	players do: [:player | (board positionOf: player ) registerSquare: 0. ]
	
		
	
	
]
