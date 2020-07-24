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
				board moveBack: player this: recoilValue .
			]
		].
	] . 

]

{ #category : #effect }
MoonWalk >> estimated: position in: board [ 
	^position copy.
]

{ #category : #initialization }
MoonWalk >> initializeWith: value [
	recoilValue := value .
]
