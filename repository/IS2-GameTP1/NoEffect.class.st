Class {
	#name : #NoEffect,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #effect }
NoEffect >> applyTo: aPlayer in: board reversalMode: status [

]

{ #category : #effect }
NoEffect >> estimated: aPosition in: board reversalMode: status [
	^aPosition copy.
]
