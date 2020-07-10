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
ReversalTest >> testMoonWalkWithReversalCard [
	| dice game aBoard reversalCard |
	
	dice := Die of: 6 rolling: #(2 1 3).
	
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: (MoonWalk withRecoil: 5) at: 4.

	reversalCard := Card type: Reversal new.
	
	tomas takesA: reversalCard .

	game := Game playedBy: { marcos . tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	game playNextTurn.
	
	game activateThis: reversalCard from: tomas to: nil.
		
	game playNextTurn.
	game playNextTurn.
	
	self 	assert: ( game whereIs: exequiel )	equals: 3;
			assert: ( game whereIs: tomas ) 		equals: 6;
			assert: ( game whereIs: marcos ) 		equals: 7.

]

{ #category : #tests }
ReversalTest >> testSpeedUpEffectWithReversalCard [
	| dice game aBoard reversalCard |
	dice := Die of: 6 rolling: #(1). 
	
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: SpeedUp new at: 2.
	
	reversalCard := Card type: Reversal new.
	
	tomas takesA: reversalCard .

	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	game activateThis: reversalCard from: tomas to: nil.

	game playNextTurn .
	
	self assert: ( game whereIs: tomas ) equals: 0.
]

{ #category : #tests }
ReversalTest >> testWormHoleWithReversalCard [
	| dice game aBoard reversalCard |
	dice := Die of: 6 rolling: #(1). 

	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: WormHole new at: 2.
	
	reversalCard := Card type: Reversal new.
	
	tomas takesA: reversalCard .

	game := Game playedBy: { tomas } throwing: dice on: aBoard during: 2.
	
	game activateThis: reversalCard from: tomas to: nil.

	game playNextTurn .
	
	self assert: ( game whereIs: tomas ) equals: 5.
]
