Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
AtomicBomb >> applyTo: aPlayer in: board reversalMode: status [
	| players  |

	players:= OrderedCollection new.
	
	board goAllOverTheBoard: [ 
		players addAll: board playersOfCurrentPosition. 
		board playersOfCurrentPosition removeAll.
	] reversalMode: status .

	board currentSquare putASet: players.
	
	board positions do: [:position | position registerSquare: 0 ]
	
		
	
	
]

{ #category : #effect }
AtomicBomb >> estimated: aPosition in: board reversalMode: status [
	^(aPosition registerSquare: 0) copy.
	
		
	
	
]
