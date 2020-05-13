Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
SpeedUp >> doEffectOver: squares [
]

{ #category : #'as yet unclassified' }
SpeedUp >> doEffectOver:squares to:aPlayer [
	|position|
	position :=squares current.
	position leaves: aPlayer .
	1 to:4  do: [ :square |squares next. (squares current checkpoint) ifTrue: [ aPlayer registerLap  ]. ].
	squares current put: aPlayer . 
	
]
