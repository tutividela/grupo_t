Class {
	#name : #Square,
	#superclass : #Object,
	#instVars : [
		'players',
		'effect',
		'checkpoint'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Square class >> as: checkpoint with: anEffect [
	^self new initializeAs: checkpoint  with: anEffect 

]

{ #category : #'instance creation' }
Square class >> asCheckpoint [
	^self as: true with: NoEffect new.
]

{ #category : #'instance creation' }
Square class >> with: anEffect [
	^self as: false with: anEffect
]

{ #category : #'instance creation' }
Square class >> withRandomEffect [
	| number effect |
	number := Random new nextInt: 100.
	
	(number between: 1 and: 38) 	ifTrue: [ effect := NoEffect new ].
	(number between: 39 and: 48) 	ifTrue: [ effect := Take randomCard ].
	(number between: 49 and: 68) 	ifTrue: [ effect := WormHole new ].
	(number between: 69 and: 88) 	ifTrue: [ effect := SpeedUp new ].
	(number between: 89 and: 98) 	ifTrue: [ effect := MoonWalk withRecoil:(Random new nextInt: 10) ].
	(number between: 99 and: 100)	ifTrue: [ effect := AtomicBomb new ].
	
	^self as: false with: effect.
]

{ #category : #accesing }
Square >> effect [
	^effect.
]

{ #category : #initialization }
Square >> initializeAs: checkPoint with: anEffect [
	effect := anEffect .
	players := OrderedCollection new.
	checkpoint := checkPoint.
]

{ #category : #query }
Square >> isCheckpoint [
	^checkpoint.
]

{ #category : #'process actions' }
Square >> leaves: aPlayer [
	players remove: aPlayer.
]

{ #category : #accesing }
Square >> players [
	^players.
]

{ #category : #'process actions' }
Square >> put: aPlayer [
	players addLast: aPlayer.
]

{ #category : #'process actions' }
Square >> putASet: ofPlayers [ 
	players addAllLast: ofPlayers .
]
