Class {
	#name : #ReversalTest,
	#superclass : #TestCase,
	#instVars : [
		'tomas',
		'exequiel',
		'marcos'
	],
	#category : #'IS2-GameTP1-Tests'
}

{ #category : #running }
ReversalTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super.
	tomas := Player named: 'Tomas'.
	exequiel := Player named: 'Exequiel'.
	marcos := Player named: 'Marcos'.

]

{ #category : #tests }
ReversalTest >> testCancelReversalCard [
	| dice game aBoard reversalCard cancellationCard square |
	dice := Die of: 6 rolling: #(1). 

	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: WormHole new at: 2.
	
	reversalCard := Card type: Reversal new.
	cancellationCard := Card type: Cancellation new.
	
	tomas takes: { reversalCard . cancellationCard } .

	game := Game playedBy: { tomas } throwing: dice on: aBoard during: 2.
	
	square := game board squareAt: 2.
	
	game activateThis: reversalCard from: tomas to: square.
	
	game activateThis: cancellationCard from: tomas to: reversalCard.

	game playNextTurn .
	
	self assert: ( game whereIs: tomas ) equals: 0.
]

{ #category : #tests }
ReversalTest >> testMoonWalkWithNestedReversalCard [
	| dice game aBoard reversalCard reversalCard2  moonWalkSquare |
	
	dice := Die of: 6 rolling: #(2 1 3).
	
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: (MoonWalk withRecoil: 5) at: 4.

	reversalCard := Card type: Reversal new.
	reversalCard2 := Card type: Reversal new.
	
	tomas takes: {reversalCard . reversalCard2 } .

	game := Game playedBy: { marcos . tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	moonWalkSquare := game board squareAt: 4.
	
	game playNextTurn.
	
	game activateThis: reversalCard from: tomas to: moonWalkSquare .
	game activateThis: reversalCard2 from: tomas to: moonWalkSquare .
		
	game playNextTurn.
	game playNextTurn.
	
	self 	assert: ( game whereIs: exequiel )	equals: 3;
			assert: ( game whereIs: tomas ) 		equals: 0;
			assert: ( game whereIs: marcos ) 		equals: 0.

]

{ #category : #tests }
ReversalTest >> testMoonWalkWithReversalCard [
	| dice game aBoard reversalCard moonWalkSquare |
	
	dice := Die of: 6 rolling: #(2 1 3).
	
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: (MoonWalk withRecoil: 5) at: 4.

	reversalCard := Card type: Reversal new.
	
	tomas takesA: reversalCard .

	game := Game playedBy: { marcos . tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	moonWalkSquare := game board squareAt: 4.
	
	game playNextTurn.
	
	game activateThis: reversalCard from: tomas to: moonWalkSquare .
		
	game playNextTurn.
	game playNextTurn.
	
	self 	assert: ( game whereIs: exequiel )	equals: 3;
			assert: ( game whereIs: tomas ) 		equals: 6;
			assert: ( game whereIs: marcos ) 		equals: 7.

]

{ #category : #tests }
ReversalTest >> testRedoAReversalCardOverADifferentSquare [
	| dice game aBoard reversalCard redoCard square1 square2 |
	dice := Die of: 6 rolling: #(4). 

	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: WormHole new at: 2.
	aBoard with: WormHole new at: 5.
	
	reversalCard := Card type: Reversal new.
	redoCard := Card type: Redo new.
	
	tomas takes: { reversalCard . redoCard } .

	game := Game playedBy: { tomas } throwing: dice on: aBoard during: 2.
	
	square1 := game board squareAt: 2.
	
	square2 := game board squareAt: 5.
	
	game activateThis: reversalCard from: tomas to: square1.
	
	game activateThis: redoCard from: tomas to: square2.

	game playNextTurn .
	
	self assert: ( game whereIs: tomas ) equals: 8.
]

{ #category : #tests }
ReversalTest >> testRedoAReversalCardOverTheSameSquare [
	| dice game aBoard reversalCard redoCard square |
	dice := Die of: 6 rolling: #(1). 

	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: WormHole new at: 2.
	
	reversalCard := Card type: Reversal new.
	redoCard := Card type: Redo new.
	
	tomas takes: { reversalCard . redoCard } .

	game := Game playedBy: { tomas } throwing: dice on: aBoard during: 2.
	
	square := game board squareAt: 2.
	
	game activateThis: reversalCard from: tomas to: square.
	
	game activateThis: redoCard from: tomas to: square.

	game playNextTurn .
	
	self assert: ( game whereIs: tomas ) equals: 0.
]

{ #category : #tests }
ReversalTest >> testSpeedUpEffectWithNestedReversalCard [
	| dice game aBoard reversalCard reversalCard2 speedUpSquare |
	dice := Die of: 6 rolling: #(1). 
	
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: SpeedUp new at: 2.
	
	reversalCard := Card type: Reversal new.
	reversalCard2 := Card type: Reversal new.
	
	tomas takes: {reversalCard . reversalCard2 } .

	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	speedUpSquare := game board squareAt: 2.
	
	game activateThis: reversalCard from: tomas to: speedUpSquare.
	
	game activateThis: reversalCard2 from: tomas to: speedUpSquare.

	game playNextTurn .
	
	self assert: ( game whereIs: tomas ) equals: 5.
]

{ #category : #tests }
ReversalTest >> testSpeedUpEffectWithReversalCard [
	| dice game aBoard reversalCard speedUpSquare |
	dice := Die of: 6 rolling: #(1). 
	
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: SpeedUp new at: 2.
	
	reversalCard := Card type: Reversal new.
	
	tomas takesA: reversalCard .

	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	speedUpSquare := game board squareAt: 2.
	
	game activateThis: reversalCard from: tomas to: speedUpSquare.

	game playNextTurn .
	
	self assert: ( game whereIs: tomas ) equals: 0.
]

{ #category : #tests }
ReversalTest >> testWormHoleWithNestedReversalCard [
	| dice game aBoard reversalCard reversalCard2 wormHoleSquare |
	dice := Die of: 6 rolling: #(1). 

	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: WormHole new at: 2.
	
	reversalCard := Card type: Reversal new.
	reversalCard2 := Card type: Reversal new.
	
	tomas takes: {reversalCard . reversalCard2} .

	game := Game playedBy: { tomas } throwing: dice on: aBoard during: 2.
	
	wormHoleSquare := game board squareAt: 2.
	
	game activateThis: reversalCard from: tomas to: wormHoleSquare.
	game activateThis: reversalCard2 from: tomas to: wormHoleSquare.
	
	game playNextTurn .
	
	self assert: ( game whereIs: tomas ) equals: 0.
]

{ #category : #tests }
ReversalTest >> testWormHoleWithReversalCard [
	| dice game aBoard reversalCard wormHoleSquare |
	dice := Die of: 6 rolling: #(1). 

	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: WormHole new at: 2.
	
	reversalCard := Card type: Reversal new.
	
	tomas takesA: reversalCard .

	game := Game playedBy: { tomas } throwing: dice on: aBoard during: 2.
	
	wormHoleSquare := game board squareAt: 2.
	
	game activateThis: reversalCard from: tomas to: wormHoleSquare.

	game playNextTurn .
	
	self assert: ( game whereIs: tomas ) equals: 5.
]
