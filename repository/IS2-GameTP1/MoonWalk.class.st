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
MoonWalk >> applyTo: aPlayer in: board with: reversalMode [
	
	board goAllOverTheBoard: [ 
		board playersOfCurrentPosition do: [ :player |
			player = aPlayer ifFalse: [
					reversalMode  
						ifTrue: 	[ board moveForward: player this: recoilValue ]
						ifFalse: 	[ board moveBack: player this: recoilValue ].
			]
		].
	] with: reversalMode . 

]

{ #category : #effect }
MoonWalk >> estimated: position in: board with: reversalMode [
	^position copy.
]

{ #category : #initialization }
MoonWalk >> initializeWith: value [
	recoilValue := value .
]
