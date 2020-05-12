Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
WormHole >> doEffectOver: squares [
]

{ #category : #'as yet unclassified' }
WormHole >> doEffectOver:squares to:aPlayer [
	|currentSquare |
	currentSquare  :=squares current.
	currentSquare  leaves: aPlayer .
	1 to: 4 do: [ :square |squares previous . (squares current checkpoint) ifTrue: [ aPlayer decreaseLap  . ] ]. 
	squares current put: aPlayer .
	
]
