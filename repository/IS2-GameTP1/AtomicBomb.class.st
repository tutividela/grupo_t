Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
AtomicBomb class >> withPlayers: listOfPlayers [
	^ self new initializeWith: listOfPlayers .
]

{ #category : #'as yet unclassified' }
AtomicBomb >> doEffectOver:squares to:aPlayer [
	|players|
	players:= OrderedCollection new.
	squares reset.
	squares next.
	[ squares current checkpoint ] whileFalse: [ 
	players addAll: squares current players. 
	squares current players removeAll .
	squares next.].

	squares current players addAllLast: players.
	
	
]
