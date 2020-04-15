Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'square'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
Player class >> create: aName [ 
	^self new withName: aName 
]

{ #category : #getter }
Player >> getName [
	^name.
]

{ #category : #getter }
Player >> getSquare [
	^square.
]

{ #category : #'instance creation' }
Player >> rollDice: dices [ 
	|result|
	result := dices roll.
	square := square + result.
	^result.
]

{ #category : #'instance creation' }
Player >> withName: aName [ 
	name:= aName. 
	square := 0.
]
