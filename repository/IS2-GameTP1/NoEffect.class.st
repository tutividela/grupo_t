Class {
	#name : #NoEffect,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
NoEffect >> applyTo: aPlayer in: board [ 

]

{ #category : #effect }
NoEffect >> estimated: aPosition in: board [ 
	^aPosition copy.
]
