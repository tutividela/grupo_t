Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#instVars : [
		'tomas',
		'exequiel'
	],
	#category : #'IS2-GameTP1-Tests'
}

{ #category : #running }
CardTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super.
	tomas := Player named: 'Tomas'.
	exequiel := Player named: 'Exequiel'.

]

{ #category : #tests }
CardTest >> testAccelerationAndOverloadTogether [
	| game aBoard dice accelerationCard overloadCard |

	dice := Die of: 6 rolling:#(6 1 1 4).
		
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: AtomicBomb new at: 4.
	aBoard with: WormHole new at: 6.
	aBoard with: Take randomCard at: 7.
	aBoard with: (MoonWalk withRecoil: 5) at: 9.

	accelerationCard := Card type: Acceleration new .
	overloadCard := Card type: Overload new .
	
	tomas takes: { accelerationCard . Card type: Overload new }.
	exequiel takes: { overloadCard . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: accelerationCard to: tomas .
	game playNextTurn.

	self assert: ( game whereIs: tomas ) equals: 7.
	
	game currentPlayerActivatesThis: overloadCard to: tomas .
	game playNextTurn.
	
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 7.
	



]

{ #category : #tests }
CardTest >> testAccelerationAndSpeedTogether [
	| game aBoard dice accelerationCard speedCard |

	dice := Die of: 6 rolling:#(6 2).	
		
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: AtomicBomb new at: 4.
	aBoard with: WormHole new at: 6.
	aBoard with: Take randomCard at: 7.
	aBoard with: (MoonWalk withRecoil: 5) at: 9.
							
	accelerationCard := Card type: Acceleration new .
	speedCard := Card type: Speed new .
	
	tomas takesA: accelerationCard.
	exequiel takesA: speedCard.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: accelerationCard to: tomas .
	game playNextTurn.

	self assert: ( game whereIs: tomas ) equals: 7.
	
	game currentPlayerActivatesThis: speedCard to: exequiel .
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 4.

	
	



]

{ #category : #tests }
CardTest >> testAccelerationCard [
	| game aBoard dice accelerationCard |

	dice := Die of: 6 rolling:#(6 6).	
		
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: AtomicBomb new at: 4.
	aBoard with: WormHole new at: 6.
	aBoard with: Take randomCard at: 7.
	aBoard with: (MoonWalk withRecoil: 5) at: 9.
	
	accelerationCard := Card type: Acceleration new .
	
	tomas takesA: accelerationCard.

	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: accelerationCard to: tomas .
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 7.
	
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 7.




]

{ #category : #tests }
CardTest >> testCancelAPermanentCard [
	| game dice aPermanentCard cancellationCard|

	dice := Die of: 6 rolling:#(6 6).	
		
	aPermanentCard := Card type: Speed new .
	cancellationCard := Card type: Cancellation new .	
		
	tomas takesA: aPermanentCard .
	exequiel  takesA: cancellationCard .
	
	game := Game playedBy: { tomas . exequiel } throwing: dice onBoardOfLength: 10 during: 1.
	
	game currentPlayerActivatesThis: aPermanentCard to: tomas .
	
	game activateThis: cancellationCard from: exequiel to: aPermanentCard.
	
	self assert: game activePermanentCards size equals: 0.



]

{ #category : #tests }
CardTest >> testCancellationCardIfThereIsNoActivePermanentCard [
	| game dice cancellation aPermanentCard |

	dice := Die of: 6 rolling:#(6 6).	

	aPermanentCard := Card type: Speed new.
	cancellation := Card type: Cancellation new .	

	tomas takesA: cancellation.
	exequiel  takesA: aPermanentCard.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice onBoardOfLength: 10 during: 1.
	
	self 	should: [ game activateThis: cancellation from: tomas to: aPermanentCard ]
			raise:  Error
			withMessageText: 'Permanent card not active.'.


]

{ #category : #tests }
CardTest >> testCardsCannotBePlayedWhenTheGameIsOver [
	| game  dice aPermanentCard anInstantCard |

	dice := Die of: 6 rolling:#(5).	
							
	aPermanentCard := Card type: Speed new.
	anInstantCard := Card type: Redo new .

	tomas takes: {aPermanentCard . anInstantCard}.

	game := Game playedBy: { tomas . exequiel } throwing: dice on: (Board withNoEffectOfLength: 10) during: 1.
	
	game playAllTurns.
	

	self 	should: [ game activateThis: aPermanentCard from: tomas to: tomas ]
			raise:  Error
			withMessageText: 'Cards cannot be played when the game is over.'.
			
	self 	should: [ game activateThis: anInstantCard from: tomas to: tomas ]
			raise:  Error
			withMessageText: 'Cards cannot be played when the game is over.'.


	



]

{ #category : #tests }
CardTest >> testCumulativeAccelerationCard [
	| game aBoard dice accelerationCard1 accelerationCard2 |

	dice := Die of: 6 rolling:#(6 6).	

	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: AtomicBomb new at: 4.
	aBoard with: WormHole new at: 6.
	aBoard with: Take randomCard at: 7.
	aBoard with: (MoonWalk withRecoil: 5) at: 9.
							
	accelerationCard1 := Card type: Acceleration new .
	accelerationCard2 := Card type: Acceleration new .
	
	tomas takesA: accelerationCard1 .
	exequiel  takesA: accelerationCard2.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: accelerationCard1 to: tomas .
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 7.
	
	game currentPlayerActivatesThis: accelerationCard2 to: exequiel .
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 8.




]

{ #category : #tests }
CardTest >> testCumulativeOverloadCard [
	| game aBoard dice overloadCard1 overloadCard2 |

	dice := Die of: 6 rolling:#(6 2 1 4).	
		
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: AtomicBomb new at: 4.
	aBoard with: WormHole new at: 6.
	aBoard with: Take randomCard at: 7.
	aBoard with: (MoonWalk withRecoil: 5) at: 9.
	
	overloadCard1 := Card type: Overload new .
	overloadCard2 := Card type: Overload new .
	
	tomas takes: { overloadCard1 . overloadCard2 }.

	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	game currentPlayerActivatesThis: overloadCard1 to: exequiel .
	game playNextTurn.
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 0.
	
	game currentPlayerActivatesThis: overloadCard2 to: exequiel .
	
	game playNextTurn.
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 0.
	



]

{ #category : #tests }
CardTest >> testCumulativeSpeedCard [
	| game aBoard dice speedCard1 speedCard2 |

	dice := Die of: 6 rolling:#(3 2).	
		
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: AtomicBomb new at: 4.
	aBoard with: WormHole new at: 6.
	aBoard with: Take randomCard at: 7.
	aBoard with: (MoonWalk withRecoil: 5) at: 9.
	
	speedCard1 := Card type: Speed new .
	speedCard2 := Card type: Speed new .
	
	tomas takes: { speedCard1 . speedCard2 }.

	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: speedCard1 to: tomas .
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 4.
	
	game playNextTurn.
	
	game currentPlayerActivatesThis: speedCard2 to: tomas .
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 9.




]

{ #category : #tests }
CardTest >> testNestedRedoCard [
	| game aBoard dice speedCard redoCard1 redoCard2 redoCard3 |

	dice := Die of: 6 rolling:#(5).	

	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: Take randomCard at: 7.
	aBoard with: (MoonWalk withRecoil: 5) at: 9.
							
	speedCard := Card type: Speed new .
	redoCard1 := Card type: Redo new .
	redoCard2 := Card type: Redo new .
	redoCard3 := Card type: Redo new .
		
	tomas takes: { speedCard . redoCard1 }.
	exequiel takes: { redoCard2 . redoCard3 }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: speedCard to: tomas .
	game currentPlayerActivatesThis: redoCard1 to: tomas .
	game activateThis: redoCard2 from: exequiel to: exequiel.

	
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 7.
	
	game playNextTurn.
	

	self 	assert: ( game board positionOf: exequiel ) currentSquare equals: 6;
			assert: ( game board positionOf: exequiel ) currentLap equals: 0.
	
	game activateThis: redoCard3 from: exequiel to: exequiel.
	
	game playNextTurn.
	game playNextTurn.
	
	self 	assert: ( game board positionOf: exequiel ) currentSquare equals: 3;
			assert: ( game board positionOf: exequiel ) currentLap equals: 1.




]

{ #category : #tests }
CardTest >> testOverloadCard [
	| game aBoard dice overloadCard |

	dice := Die of: 6 rolling:#(6 2 1 4 2 1).
	
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: AtomicBomb new at: 4.
	aBoard with: WormHole new at: 6.
	aBoard with: Take randomCard at: 7.
	aBoard with: (MoonWalk withRecoil: 5) at: 9.
		
	overloadCard := Card type: Overload new .
	
	tomas takesA: overloadCard .
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: overloadCard to: exequiel .
	game playNextTurn.
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 0.
	
	game playNextTurn.
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 2.
	
	game playNextTurn.
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 1.




]

{ #category : #tests }
CardTest >> testPlayAPermanentCardOnAnotherPlayersTurn [
	| game dice aPermanentCard |

	dice := Die of: 6 rolling:#(6 6).	

	aPermanentCard := Card type: Overload new .
	
	exequiel takesA: aPermanentCard.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice onBoardOfLength: 10 during: 1.
		
	self 
		should: [ game activateThis: aPermanentCard from: exequiel to: tomas ] 
		raise: Error 
		withMessageText: 'A player wants to play a permanent card on another turn.'.
]

{ #category : #tests }
CardTest >> testPlayerGetsANewCard [
	| dice game aBoard |
	dice := Die of: 6 rolling: #(6). 

	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: SpeedUp  new at: 2.
	aBoard with: (MoonWalk withRecoil: 5) at: 3.
	aBoard with: AtomicBomb new at: 4.
	aBoard with: WormHole new at: 6.
	aBoard with: Take randomCard at: 7.

	game := Game playedBy: {exequiel . tomas} throwing: dice on: aBoard during: 2.

	game playNextTurn .
	
	self 	assert: exequiel cardsInHand equals: 3.
]

{ #category : #tests }
CardTest >> testPlayersAlwaysStartWithTwoCards [
	| game dice card |

	dice := Die of: 6 rolling:#(6 6).	

	card := Card type: Speed new .
	
	tomas takesA: card.
		
	game := Game playedBy: { tomas . exequiel } throwing: dice onBoardOfLength: 10 during: 1.

	game players do: [:player | self assert: player cardsInHand equals: 2 ]
]

{ #category : #tests }
CardTest >> testRedoCard [
	| game aBoard dice card redoCard |

	dice := Die of: 6 rolling:#(5).	

	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: AtomicBomb new at: 4.
	aBoard with: Take randomCard at: 7.
	aBoard with: (MoonWalk withRecoil: 5) at: 9.
	
	card := Card type: Acceleration  new .
	redoCard := Card type: Redo new .
	
	tomas takes: { card . redoCard }.

	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	game currentPlayerActivatesThis: card to: tomas .
	game currentPlayerActivatesThis: redoCard to: tomas .
	
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 7.
	
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 7.




]

{ #category : #tests }
CardTest >> testRedoCardAsCancellationCard [
	| game  dice speedCard1 speedCard2 cancellationCard redoCard |

	dice := Die of: 6 rolling:#(5).	
							
	speedCard1 := Card type: Speed new.
	speedCard2 := Card type: Speed new.
	cancellationCard := Card type: Cancellation new.
	redoCard := Card type: Redo new .

		
	tomas takes: { speedCard1 . redoCard }.
	exequiel takes: {speedCard2. cancellationCard }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice onBoardOfLength: 10 during: 2.
	
	
	game currentPlayerActivatesThis: speedCard1 to: tomas .
	
	game playNextTurn .
	
	game currentPlayerActivatesThis: speedCard2 to: exequiel .
	
	self assert: game activePermanentCards size equals: 2.
		
	game activateThis: cancellationCard from: exequiel to: speedCard1.
	
	self assert: game activePermanentCards size equals: 1.
	
	game activateThis: redoCard from: tomas to: speedCard2.

	self assert: game activePermanentCards size equals: 0.


]

{ #category : #tests }
CardTest >> testRedoCardAsRepeatCard [
	| game aBoard dice  redoCard repeatCard |

	dice := Die of: 6 rolling:#(1).
	
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: SpeedUp new at: 2.
	aBoard with: Take randomCard at: 7.
	aBoard with: (MoonWalk withRecoil: 5) at: 9.	

	redoCard := Card type: Redo new .
	repeatCard := Card type: Repeat new .
		
	tomas takes: { repeatCard . redoCard }.

	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	game playNextTurn.
	
	self 	assert: ( game board positionOf: tomas ) currentSquare equals: 5;
			assert: ( game board positionOf: tomas ) currentLap equals: 0.
			
	game activateThis: repeatCard from: tomas to: nil.
	
	self 	assert: ( game board positionOf: tomas ) currentSquare equals: 9;
			assert: ( game board positionOf: tomas ) currentLap equals: 0.
			
	game activateThis: redoCard from: tomas to: nil.
	
	self 	assert: ( game board positionOf: tomas ) currentSquare equals: 3;
			assert: ( game board positionOf: tomas ) currentLap equals: 1.




]

{ #category : #tests }
CardTest >> testRedoCardIfNoOneHasPlayedACardYet [
	| game aBoard dice redoCard |

	dice := Die of: 6 rolling:#(5).	
		
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: AtomicBomb new at: 4.
	aBoard with: Take randomCard at: 7.
	aBoard with: (MoonWalk withRecoil: 5) at: 9.
							
	redoCard := Card type: Redo new .

	tomas takesA: redoCard.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	self 	should: [game currentPlayerActivatesThis: redoCard to: tomas .]
			raise: Error
			withMessageText: 'No one has played a card yet'.




]

{ #category : #tests }
CardTest >> testRepeatCard [
	| game aBoard dice repeatCard1 repeatCard2 |

	dice := Die of: 6 rolling:#(3 6).	

	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: SpeedUp new at: 4.
	aBoard with: Take randomCard at: 6.
	aBoard with: WormHole new at: 7.
	aBoard with: (MoonWalk withRecoil: 5) at: 9.

	repeatCard1 := Card type: Repeat new .
	repeatCard2 := Card type: Repeat new .
		
	tomas takes: { repeatCard1 . repeatCard2 }.

	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game playNextTurn.
	
	game activateThis: repeatCard1 from: tomas to: nil.
	
	self 	assert: ( game board positionOf: tomas ) currentSquare equals: 1;
			assert: ( game board positionOf: tomas ) currentLap equals: 1.
	
	game playNextTurn.
	
	self 	assert: ( game board positionOf: exequiel ) currentSquare equals: 2;
			assert: ( game board positionOf: exequiel ) currentLap equals: 0.
			
	game activateThis: repeatCard2 from: tomas to: nil.
	
	self 	assert: ( game board positionOf: exequiel ) currentSquare equals: 0;
			assert: ( game board positionOf: exequiel ) currentLap equals: 0.
	
	


]

{ #category : #tests }
CardTest >> testRepeatCardWhenNoOneRolledTheDicesYet [
	| game dice repeatCard |

	dice := Die of: 6 rolling:#(3 6).	
	repeatCard := Card type: Repeat new .
	
	tomas takesA: repeatCard.
	
	game := Game playedBy: { tomas } throwing: dice onBoardOfLength: 10 during: 1.

	game activateThis: repeatCard from: tomas to: tomas. 
	
	self 	assert: ( game board positionOf: tomas ) currentSquare equals: 0;
			assert: ( game board positionOf: tomas ) currentLap equals: 0;
			assert: tomas cardsInHand equals: 1.
			


]

{ #category : #tests }
CardTest >> testRepeatCardWithNoEffect [
	| game aBoard dice repeatCard |

	dice := Die of: 6 rolling:#(1).	
		
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: SpeedUp new at: 4.
	aBoard with: WormHole new at: 6.
	aBoard with: Take randomCard at: 7.
	aBoard with: (MoonWalk withRecoil: 5) at: 9.
					
	repeatCard := Card type: Repeat new .
	
	tomas takesA: repeatCard .
	
	game := Game playedBy: { tomas } throwing: dice on: aBoard during: 2.
	
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 1.
	
	game activateThis: repeatCard from: tomas to: tomas.
	
	self assert: ( game whereIs: tomas ) equals: 1.
	


]

{ #category : #tests }
CardTest >> testSpeedAndOverloadTogether [
	| game aBoard dice speedCard overloadCard |

	dice := Die of: 6 rolling:#(6 2 1 4).	

	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: AtomicBomb new at: 4.
	aBoard with: WormHole new at: 6.
	aBoard with: Take randomCard at: 7.
	aBoard with: (MoonWalk withRecoil: 5) at: 9.
	
	speedCard := Card type: Speed new .
	overloadCard := Card type: Overload new .
	
	tomas takesA: speedCard.
	exequiel takesA: overloadCard.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: speedCard to: tomas .
	game playNextTurn.

	self assert: ( game whereIs: tomas ) equals: 7.
	
	game currentPlayerActivatesThis: overloadCard to: tomas .
	game playNextTurn.
	
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 7.
	



]

{ #category : #tests }
CardTest >> testSpeedCard [
	| game aBoard dice speedCard |

	dice := Die of: 6 rolling:#(6 6).	
		
		
	aBoard := Board withNoEffectOfLength: 10.
	aBoard with: AtomicBomb new at: 4.
	aBoard with: WormHole new at: 6.
	aBoard with: Take randomCard at: 7.
	aBoard with: (MoonWalk withRecoil: 5) at: 9.
	
	speedCard := Card type: Speed new .
	
	tomas takesA: speedCard.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: speedCard to: tomas .
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 7.
	
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 6.




]

{ #category : #tests }
CardTest >> testUseOneCardFromPlayersHand [
	| game dice speedCard |

	dice := Die of: 6 rolling:#(6 6).	

	speedCard := Card type: Speed new .
	
	tomas takesA: speedCard.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice onBoardOfLength: 10 during: 1.
	
	game currentPlayerActivatesThis: speedCard to: tomas .
	
	self assert: tomas cardsInHand equals: 1.

]

{ #category : #tests }
CardTest >> testUseOneCardThatIsNotInPlayersHand [
	| game dice speedCard accelerationCard |

	dice := Die of: 6 rolling:#(6 6).	

	speedCard := Card type: Speed new .
	accelerationCard := Card type: Acceleration new .
	
	tomas takesA: speedCard.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice onBoardOfLength: 10 during: 1.
		
	self 
		should: [ game currentPlayerActivatesThis: accelerationCard to: tomas . ] 
		raise: Error 
		withMessageText: 'This card is not in player s hand.'.
]
