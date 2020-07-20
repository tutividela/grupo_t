Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
SpeedUp >> applyTo: aPlayer in: board with: reversalMode [
	reversalMode 
	ifTrue: 	[ board moveBack: aPlayer this: 4. ]
	ifFalse: [ board moveForward: aPlayer this: 4. ].

	
]

{ #category : #effect }
SpeedUp >> estimated: position in: board with: reversalMode [
	reversalMode
	ifTrue: 	[ ^board estimatedMoveBack: position this: 4 ]
	ifFalse: [ ^board estimatedMoveFoward: position this: 4 ].

]
