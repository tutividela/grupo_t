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
	board goAllOverTheBoard: [ 
		board playersOfCurrentPosition do: [ :player |
			player = aPlayer ifFalse: [
					board reversal 
						ifTrue: 	[ board moveForward: player this: recoilValue ]
						ifFalse: 	[ board moveBack: player this: recoilValue ].
			]
		].
	].

]

{ #category : #initialization }
MoonWalk >> initializeWith: value [
	recoilValue := value .
]
