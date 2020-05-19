Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
AtomicBomb class >> withPlayers: listOfPlayers [
	^ self new initializeWith: listOfPlayers .
]

{ #category : #effect }
AtomicBomb >> applyTo: aPlayer in: board [ 
	| players |
	
	players:= OrderedCollection new.
	board resetIndex.
	[ board nextPosition isCheckpoint ] whileFalse: [ 
		players addAll: board playersOfCurrentPosition. 
		board playersOfCurrentPosition removeAll.
	].

	board currentPosition putASet: players.
	
	
]
