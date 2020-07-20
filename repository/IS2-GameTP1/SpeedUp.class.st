Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
SpeedUp >> applyTo: aPlayer in: board reversalMode: status [
	status 
	ifTrue: 	[ board moveBack: aPlayer this: 4. ]
	ifFalse: [ board moveForward: aPlayer this: 4. ].

	
]

{ #category : #effect }
SpeedUp >> estimated: aPosition in: board reversalMode: status [
	status
	ifTrue: 	[ ^board estimatedMoveBack: aPosition this: 4 ]
	ifFalse: [ ^board estimatedMoveFoward: aPosition this: 4 ].

]
