Class {
	#name : #MoonWalk,
	#superclass : #Object,
	#instVars : [
		'recoilValue'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
MoonWalk class >> withRecoil: nValue [
	^self new initializeWith: nValue .
]

{ #category : #effect }
MoonWalk >> applyTo: aPlayer in: board [ 
	| position |
	position := 0.
	board squares reset.
	[ board nextSquare isCheckpoint ] whileFalse: [ 
	
		board playersOfCurrentPosition do: [ :player |
			player = aPlayer ifFalse: [
				board currentSquare leaves: player.

				(board positionOf: player ) currentLap  == 0 & (position < recoilValue) ifTrue: [ board goToCheckpoint ] 
				ifFalse: [
					recoilValue timesRepeat:  [ 
						board previousSquare . 
						(board currentSquare isCheckpoint) ifTrue: [ (board positionOf: aPlayer ) decreaseALap  ].
					]. 
				].
				board currentSquare put: player .
				(board positionOf: player ) registerSquare: (board whereIs: player).
			]
		].
		position := position + 1.
	].

]

{ #category : #initialization }
MoonWalk >> initializeWith: value [
	recoilValue := value .
]
