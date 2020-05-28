Class {
	#name : #Place,
	#superclass : #Object,
	#instVars : [
		'positions'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'instance creation' }
Place class >> with: aPlayersCopy [
	^self new initializeWith: aPlayersCopy .
]

{ #category : #initialization }
Place >> initializeWith: copyOfPlayers [
	|collection|
	collection := OrderedCollection new .
	collection addAll: copyOfPlayers .
	positions := collection .
]
