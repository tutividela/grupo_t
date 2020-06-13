Class {
	#name : #EffectTest,
	#superclass : #TestCase,
	#instVars : [
		'tomas',
		'exequiel'
	],
	#category : #'IS2-GameTP1-Tests'
}

{ #category : #running }
EffectTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	tomas := Player named: 'Tomas'.
	exequiel := Player named: 'Exequiel'.

]

{ #category : #tests }
EffectTest >> testAtomicBombWhenNoLapsWereDone [
	| dice game aBoard|
	dice := Die of: 6 rolling: #(6 4). 

	aBoard := Board with: { 	Square asCheckpoint.
									Square with: SpeedUp new .
									Square with: WormHole  new .
						
									Square with: (MoonWalk withRecoil: 5) .
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
						
									Square with: NoEffect new.
									Square with: NoEffect new .
									Square with: NoEffect new .
						
									Square with: NoEffect new  				
								}.
								
	game := Game playedBy: {tomas . exequiel} throwing: dice on: aBoard during: 2.

	game playNextTurn .
	game playNextTurn .
	
	self 	assert: ( game whereIs: tomas ) equals: 0;
			assert: ( game whereIs: exequiel ) equals: 0.
]

{ #category : #tests }
EffectTest >> testAtomicBombWhenOneLapIsDone [
	| dice game aBoard|
	dice := Die of: 6 rolling: #(5 5 5 3 4). 
	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: SpeedUp new .
									Square with: WormHole  new .
						
									Square with: (MoonWalk withRecoil: 5) .
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
						
									Square with: NoEffect new.
									Square with: NoEffect new .
									Square with: NoEffect new .
						
									Square with: NoEffect new  				
								}.

	game := Game playedBy: {tomas . exequiel} throwing: dice on: aBoard during: 2.

	game playNextTurn .
	game playNextTurn .
	game playNextTurn .
	game playNextTurn .
	game playNextTurn .
	
	self 	assert: ( game board positionOf: tomas ) currentSquare equals: 0;
			assert: ( game board positionOf: tomas ) currentLap equals: 1;
			assert: ( game board positionOf: exequiel  ) currentSquare equals: 0;
			assert: ( game board positionOf: exequiel  ) currentLap equals: 0.
]

{ #category : #tests }
EffectTest >> testMoonWalk [
	| dice game player3 aBoard|
	
	dice := Die of: 8 rolling: #(8 7 3).
	player3:=Player named: 'Marcos'.
	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: SpeedUp new .
									Square with: WormHole  new .
						
									Square with: (MoonWalk withRecoil: 5) .
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
						
									Square with: NoEffect new.
									Square with: NoEffect new .
									Square with: NoEffect new .
						
									Square with: NoEffect new  				
								}.
								
	game := Game playedBy: {exequiel. player3 . tomas} throwing: dice on: aBoard during: 2.
	
	game playNextTurn.
	game playNextTurn.
	game playNextTurn .
	
	self 	assert: (game whereIs: exequiel ) equals: 3;
		  	assert: (game whereIs: tomas) equals: 3;
			assert: (game whereIs: player3 )equals:2.
]

{ #category : #tests }
EffectTest >> testSpeedUpEffect [
	| dice game aBoard |
	dice := Die of: 6 rolling: #(1). 
	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: SpeedUp new .
									Square with: WormHole  new .
						
									Square with: (MoonWalk withRecoil: 5) .
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
						
									Square with: NoEffect new.
									Square with: NoEffect new .
									Square with: NoEffect new .
						
									Square with: NoEffect new  				
								}.

	game := Game playedBy: {exequiel . tomas} throwing: dice on: aBoard during: 2.

	game playNextTurn .
	
	self assert: ( game whereIs: exequiel ) equals: 5.
]

{ #category : #tests }
EffectTest >> testWormHoleWhenCeroLapsAndRollResultGreaterThanFour [
	| dice game aBoard |
	dice := Die of: 6 rolling: #(6). 

	aBoard := Board with: { 	Square asCheckpoint.
									Square with: SpeedUp new .					
									Square with: (MoonWalk withRecoil: 5) .
						
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
									Square with: NoEffect new.
						
									Square with: WormHole  new .
									Square with: NoEffect new .
									Square with: NoEffect new .
						
									Square with: NoEffect new  				
							}.
	
	game := Game playedBy: {exequiel . tomas} throwing: dice on: aBoard during: 2.

	game playNextTurn .
	
	self assert: ( game whereIs: exequiel ) equals: 2.
]

{ #category : #tests }
EffectTest >> testWormHoleWhenCeroLapsAndRollResultLessThanFour [
	| dice game aBoard  |
	dice := Die of: 7 rolling: #(2). 
	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: SpeedUp new .
									Square with: WormHole  new .
						
									Square with: (MoonWalk withRecoil: 5) .
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
						
									Square with: NoEffect new.
									Square with: NoEffect new .
									Square with: NoEffect new .
						
									Square with: NoEffect new  				
								}.

	game := Game playedBy: {exequiel . tomas} throwing: dice on: aBoard during: 2.

	game playNextTurn .
	
	self assert: ( game whereIs: exequiel ) equals: 0.
]

{ #category : #tests }
EffectTest >> testWormHoleWhenOneLapIsDone [
	| dice game aBoard |
	dice := Die of: 6 rolling: #(6 6). 
	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: SpeedUp new .
									Square with: WormHole  new .
						
									Square with: (MoonWalk withRecoil: 5) .
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
						
									Square with: NoEffect new.
									Square with: NoEffect new .
									Square with: NoEffect new .
						
									Square with: NoEffect new  				
								}.

	game := Game playedBy: {tomas} throwing: dice on: aBoard during: 2.

	game playNextTurn .
	game playNextTurn .
	
	self assert: ( game whereIs: tomas ) equals: 8.
]
