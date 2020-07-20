Class {
	#name : #NoEffect,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
NoEffect >> applyTo: aPlayer in: board with: reversalMode [

]

{ #category : #effect }
NoEffect >> estimated: position in: board with: reversalMode [
	^position copy.
]
