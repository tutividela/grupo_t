Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#instVars : [
		'tomas',
		'exequiel'
	],
	#category : #'IS2-GameTP1-Tests'
}

{ #category : #board }
CardTest >> aBoard [
	^Board with: { 	Square asCheckpoint.
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
]

{ #category : #board }
CardTest >> aBoard02 [
	^Board with: { 	Square asCheckpoint.
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
]

{ #category : #running }
CardTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	tomas := Player named: 'Tomas'.
	exequiel := Player named: 'Exequiel'.

]

{ #category : #tests }
CardTest >> testAccelerationAndOverloadTogether [
	| game aBoard dice card card2 |

	dice := Die of: 6 rolling:#(6 1 1 4).	
	aBoard := Board with: { 	Square asCheckpoint. 
									Square with: NoEffect new .
									Square with: NoEffect new .				
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
									Square with: WormHole  new .
									Square with: Take randomCard. 
									Square with: NoEffect new .
									Square with: (MoonWalk withRecoil: 5) .
									Square with: NoEffect new  				
							}.
							
	card := Card type: Acceleration new .
	card2 := Card type: Overload new .
	
	tomas takes: { card . Card type: Overload new }.
	exequiel takes: { card2 . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: card to: tomas .
	game playNextTurn.

	self assert: ( game whereIs: tomas ) equals: 7.
	
	game currentPlayerActivatesThis: card2 to: tomas .
	game playNextTurn.
	
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 7.
	



]

{ #category : #tests }
CardTest >> testAccelerationAndSpeedTogether [
	| game aBoard dice card card2 |

	dice := Die of: 6 rolling:#(6 2).	
	aBoard := Board with: { 	Square asCheckpoint. 
									Square with: NoEffect new .
									Square with: NoEffect new .				
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
									Square with: WormHole  new .
									Square with: Take randomCard. 
									Square with: NoEffect new .
									Square with: (MoonWalk withRecoil: 5) .
									Square with: NoEffect new  				
							}.
							
	card := Card type: Acceleration new .
	card2 := Card type: Speed new .
	
	tomas takes: { card . Card type: Overload new }.
	exequiel takes: { card2 . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: card to: tomas .
	game playNextTurn.

	self assert: ( game whereIs: tomas ) equals: 7.
	
	game currentPlayerActivatesThis: card2 to: exequiel .
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 4.

	
	



]

{ #category : #tests }
CardTest >> testAccelerationCard [
	| game aBoard dice card |

	dice := Die of: 6 rolling:#(6 6).	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: NoEffect new .
									Square with: NoEffect new .				
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
									Square with: WormHole  new .
									Square with: Take randomCard.
									Square with: NoEffect new .
									Square with: (MoonWalk withRecoil: 5) .
									Square with: NoEffect new  				
							}.
							
	card := Card type: Acceleration new .
	
	tomas takes: { card . Card type: Speed new }.
	exequiel  takes: { Card type: Overload new . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: card to: tomas .
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 7.
	
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 7.




]

{ #category : #tests }
CardTest >> testCancellationCard [
	| game dice card cancellation2|

	dice := Die of: 6 rolling:#(6 6).	
		
	card := Card type: Speed new .
	cancellation2 := Card type: Cancellation new .	
		
	tomas takes: { Card type: Acceleration new . card }.
	exequiel  takes: { Card type: Speed new . cancellation2 }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: self aBoard during: 2.
	
	game currentPlayerActivatesThis: card to: tomas .
	
	game activateThis: cancellation2 from: exequiel to: card.
	
	self assert: game amountOfActivePermanentCards equals: 0.



]

{ #category : #tests }
CardTest >> testCancellationCardIfThereIsNoActivePermanentCard [
	| game dice cancellation card |

	dice := Die of: 6 rolling:#(6 6).	

	card := Card type: Speed new.
	cancellation := Card type: Cancellation new .	

	tomas takes: { Card type: Speed new . cancellation }.
	exequiel  takes: { Card type: Speed new . card }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: self aBoard during: 2.
	
	self 	should: [ game activateThis: cancellation from: tomas to: card ]
			raise:  Error
			description: 'Permanent card not active.'.


]

{ #category : #tests }
CardTest >> testCumulativeAccelerationCard [
	| game aBoard dice card card2 |

	dice := Die of: 6 rolling:#(6 6).	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: NoEffect new .
									Square with: NoEffect new .				
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
									Square with: WormHole  new .
									Square with: Take randomCard.
									Square with: NoEffect new .
									Square with: (MoonWalk withRecoil: 5) .
									Square with: NoEffect new  				
							}.
							
	card := Card type: Acceleration new .
	card2 := Card type: Acceleration new .
	
	tomas takes: { card . Card type: Speed new }.
	exequiel  takes: { card2 . Card type: Overload new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: card to: tomas .
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 7.
	
	game currentPlayerActivatesThis: card2 to: exequiel .
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 8.




]

{ #category : #tests }
CardTest >> testCumulativeOverloadCard [
	| game aBoard dice card card2 |

	dice := Die of: 6 rolling:#(6 2 1 4).	
	aBoard := Board with: { 	Square asCheckpoint. 
									Square with: NoEffect new .
									Square with: NoEffect new .				
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
									Square with: WormHole  new .
									Square with: Take randomCard. 
									Square with: NoEffect new .
									Square with: (MoonWalk withRecoil: 5) .
									Square with: NoEffect new  				
							}.
							
	card := Card type: Overload new .
	card2 := Card type: Overload new .
	
	tomas takes: { card . card2 }.
	exequiel takes: { Card type: Overload new . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: card to: exequiel .
	game playNextTurn.
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 0.
	
	game currentPlayerActivatesThis: card2 to: exequiel .
	
	game playNextTurn.
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 0.
	



]

{ #category : #tests }
CardTest >> testCumulativeSpeedCard [
	| game aBoard dice card card2 |

	dice := Die of: 6 rolling:#(3 2).	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: NoEffect new .
									Square with: NoEffect new .				
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
									Square with: WormHole  new .
									Square with: Take randomCard.
									Square with: NoEffect new .
									Square with: (MoonWalk withRecoil: 5) .
									Square with: NoEffect new  				
							}.
							
	card := Card type: Speed new .
	card2 := Card type: Speed new .
	
	tomas takes: { card . card2 }.
	exequiel  takes: { Card type: Acceleration new . Card type: Overload new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: card to: tomas .
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 4.
	
	game playNextTurn.
	
	game currentPlayerActivatesThis: card2 to: tomas .
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 9.




]

{ #category : #tests }
CardTest >> testNestedRedoCard [
	| game aBoard dice card redo redo2 redo3 |

	dice := Die of: 6 rolling:#(5).	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: NoEffect new .
									Square with: NoEffect new .				
									Square with: NoEffect new .	
									Square with: NoEffect new .
									Square with: NoEffect new  .
									Square with: Take randomCard.
									Square with: NoEffect new .
									Square with: (MoonWalk withRecoil: 5) .
									Square with: NoEffect new  				
							}.
							
	card := Card type: Speed  new .
	redo := Card type: Redo new .
	redo2 := Card type: Redo new .
	redo3 := Card type: Redo new .
		
	tomas takes: { card . redo }.
	exequiel takes: { redo2 . redo3 }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: card to: tomas .
	game currentPlayerActivatesThis: redo to: tomas .
	game activateThis: redo2 from: exequiel to: exequiel.

	
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 7.
	
	game playNextTurn.
	

	self 	assert: ( game board positionOf: exequiel ) currentSquare equals: 6;
			assert: ( game board positionOf: exequiel ) currentLap equals: 0.
	
	game activateThis: redo3 from: exequiel to: exequiel.
	
	game playNextTurn.
	game playNextTurn.
	
	self 	assert: ( game board positionOf: exequiel ) currentSquare equals: 3;
			assert: ( game board positionOf: exequiel ) currentLap equals: 1.




]

{ #category : #tests }
CardTest >> testOverloadCard [
	| game aBoard dice card |

	dice := Die of: 6 rolling:#(6 2 1 4 2 1).	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: NoEffect new .
									Square with: NoEffect new .				
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
									Square with: WormHole  new .
									Square with: Take randomCard.
									Square with: NoEffect new .
									Square with: (MoonWalk withRecoil: 5) .
									Square with: NoEffect new  				
							}.
							
	card := Card type: Overload new .
	
	tomas takes: { card . Card type: Speed new }.
	exequiel  takes: { Card type: Overload new . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: card to: exequiel .
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
	| game dice card card2 |

	dice := Die of: 6 rolling:#(6 6).	

	card := Card type: Speed new .
	card2 := Card type: Overload new .
	
	tomas takes: { card . Card type: Speed new }.
	exequiel  takes: { card2 . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: self aBoard during: 2.
		
	self 
		should: [ game activateThis: card2 from: exequiel to: tomas ] 
		raise: Error 
		description: 'A player wants to play a permanent card on another turn.'.
]

{ #category : #tests }
CardTest >> testPlayerGetsANewCard [
	| dice game aBoard |
	dice := Die of: 6 rolling: #(6). 

	aBoard := Board with: { 	Square asCheckpoint.
									Square with: SpeedUp new .					
									Square with: (MoonWalk withRecoil: 5) .
						
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
									
									Square with: WormHole  new .
									
									Square with: Take randomCard.
									Square with: NoEffect new .
									Square with: NoEffect new .
						
									Square with: NoEffect new  				
							}.
	
	game := Game playedBy: {exequiel . tomas} throwing: dice on: aBoard during: 2.

	game playNextTurn .
	
	self 	assert: exequiel cardsInHand equals: 3.
]

{ #category : #tests }
CardTest >> testPlayerHasTwoCardsAtTheBeginning [
	| game dice1 dice2 |

	dice1 := Die of: 6 rolling:#(5 6 1).
	dice2 := Die of: 6 rolling:#(3 5 2).
	
	tomas takes: { Card type: Overload new . Card type: Speed new }.
	exequiel  takes: { Card type: Overload new . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: (dice1 + dice2) on: self aBoard02 during: 3.
	
	self 	assert: game players current cardsInHand equals: 2; 
			assert: game players next cardsInHand equals: 2.  
]

{ #category : #tests }
CardTest >> testPlayerHasTwoRandomCardsAtTheBeginning [
	| game dice1 dice2 |

	dice1 := Die of: 6 rolling:#(5 6 1).
	dice2 := Die of: 6 rolling:#(3 5 2).
	game := Game playedBy: { tomas . exequiel } throwing: (dice1 + dice2) on: self aBoard02 during: 3.
	
	self 	assert: game players current cardsInHand equals: 2; 
			assert: game players next cardsInHand equals: 2.  
]

{ #category : #tests }
CardTest >> testRedoCard [
	| game aBoard dice card redo |

	dice := Die of: 6 rolling:#(5).	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: NoEffect new .
									Square with: NoEffect new .				
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
									Square with: NoEffect new  .
									Square with: Take randomCard.
									Square with: NoEffect new .
									Square with: (MoonWalk withRecoil: 5) .
									Square with: NoEffect new  				
							}.
							
	card := Card type: Acceleration  new .
	redo := Card type: Redo new .

		
	tomas takes: { card . redo }.
	exequiel takes: { Card type: Speed new . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: card to: tomas .
	game currentPlayerActivatesThis: redo to: tomas .
	
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 7.
	
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 7.




]

{ #category : #tests }
CardTest >> testRedoCardAsCancellationCard [
	| game  dice speed speed2 cancel redo |

	dice := Die of: 6 rolling:#(5).	
							
	speed := Card type: Speed new.
	speed2 := Card type: Speed new.
	cancel := Card type: Cancellation new.
	redo := Card type: Redo new .

		
	tomas takes: { speed . redo }.
	exequiel takes: {speed2. cancel }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: self aBoard during: 2.
	
	
	game currentPlayerActivatesThis: speed to: tomas .
	
	game playNextTurn .
	
	game currentPlayerActivatesThis: speed2 to: exequiel .
	
	game activateThis: cancel from: exequiel to: speed.
	
	game activateThis: redo from: tomas to: speed2.

	
	self assert: game amountOfActivePermanentCards equals: 0.


]

{ #category : #tests }
CardTest >> testRedoCardAsRepeatCard [
	| game aBoard dice  redo repeat |

	dice := Die of: 6 rolling:#(1).	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: SpeedUp new .
									Square with: NoEffect new .				
									Square with: NoEffect new .
									Square with: NoEffect new .
									Square with: NoEffect new  .
									Square with: Take randomCard.
									Square with: NoEffect new .
									Square with: (MoonWalk withRecoil: 5) .
									Square with: NoEffect new  				
							}.
							

	redo := Card type: Redo new .
	repeat := Card type: Repeat new .
		
	tomas takes: { repeat . redo }.
	exequiel takes: { Card type: Speed new . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	game playNextTurn.
	
	self 	assert: ( game board positionOf: tomas ) currentSquare equals: 5;
			assert: ( game board positionOf: tomas ) currentLap equals: 0.
			
	game activateThis: repeat from: tomas to: nil.
	
	self 	assert: ( game board positionOf: tomas ) currentSquare equals: 9;
			assert: ( game board positionOf: tomas ) currentLap equals: 0.
			
	game activateThis: redo from: tomas to: nil.
	
	self 	assert: ( game board positionOf: tomas ) currentSquare equals: 3;
			assert: ( game board positionOf: tomas ) currentLap equals: 1.




]

{ #category : #tests }
CardTest >> testRedoCardIfNoOneHasPlayedACardYet [
	| game aBoard dice card redo |

	dice := Die of: 6 rolling:#(5).	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: NoEffect new .
									Square with: NoEffect new .				
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
									Square with: NoEffect new  .
									Square with: Take randomCard.
									Square with: NoEffect new .
									Square with: (MoonWalk withRecoil: 5) .
									Square with: NoEffect new  				
							}.
							
	card := Card type: Acceleration  new .
	redo := Card type: Redo new .

		
	tomas takes: { card . redo }.
	exequiel takes: { Card type: Speed new . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	self 	should: [game currentPlayerActivatesThis: redo to: tomas .]
			raise: Error
			description: 'No one has played a card yet'.




]

{ #category : #tests }
CardTest >> testRepeatCard [
	| game aBoard dice card card2 |

	dice := Die of: 6 rolling:#(3 6).	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: NoEffect new .
									Square with: NoEffect new .				
									Square with: SpeedUp  new.
									Square with: NoEffect new .
									Square with: Take randomCard.
									Square with: WormHole new .
									Square with: NoEffect new .
									Square with: (MoonWalk withRecoil: 5) .
									Square with: NoEffect new  				
							}.
							
	card := Card type: Repeat new .
	card2 := Card type: Repeat new .
		
	tomas takes: { card . card2 }.
	exequiel takes: { Card type: Acceleration new . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game playNextTurn.
	
	game activateThis: card from: tomas to: nil.
	
	self 	assert: ( game board positionOf: tomas ) currentSquare equals: 1;
			assert: ( game board positionOf: tomas ) currentLap equals: 1.
	
	game playNextTurn.
	
	self 	assert: ( game board positionOf: exequiel ) currentSquare equals: 2;
			assert: ( game board positionOf: exequiel ) currentLap equals: 0.
			
	game activateThis: card2 from: tomas to: nil.
	
	self 	assert: ( game board positionOf: exequiel ) currentSquare equals: 0;
			assert: ( game board positionOf: exequiel ) currentLap equals: 0.
	
	


]

{ #category : #tests }
CardTest >> testRepeatCardWhenNoOneRolledTheDicesYet [
	| game dice card |

	dice := Die of: 6 rolling:#(3 6).	
	card := Card type: Repeat new .
	
	tomas takes: { card . Card type: Speed new }.
	
	game := Game playedBy: { tomas } throwing: dice on: self aBoard during: 2.

	self 	should:  [ game activateThis: card from: tomas to: tomas. ]
			raise:  Error
			description: 'No one has rolled the dices yet.' .
	


]

{ #category : #tests }
CardTest >> testRepeatCardWithNoEffect [
	| game aBoard dice card |

	dice := Die of: 6 rolling:#(1).	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: NoEffect new .
									Square with: NoEffect new .				
									Square with: SpeedUp  new.
									Square with: NoEffect new .
									Square with: WormHole  new .
									Square with: Take randomCard.
									Square with: NoEffect new .
									Square with: (MoonWalk withRecoil: 5) .
									Square with: NoEffect new  				
							}.
							
	card := Card type: Repeat new .
	
	tomas takes: { card . Card type: Speed new }.
	
	game := Game playedBy: { tomas } throwing: dice on: aBoard during: 2.
	
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 1.
	
	game activateThis: card from: tomas to: tomas.
	
	self assert: ( game whereIs: tomas ) equals: 1.
	


]

{ #category : #tests }
CardTest >> testSpeedAndOverloadTogether [
	| game aBoard dice card card2 |

	dice := Die of: 6 rolling:#(6 2 1 4).	
	aBoard := Board with: { 	Square asCheckpoint. 
									Square with: NoEffect new .
									Square with: NoEffect new .				
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
									Square with: WormHole  new .
									Square with: Take randomCard. 
									Square with: NoEffect new .
									Square with: (MoonWalk withRecoil: 5) .
									Square with: NoEffect new  				
							}.
							
	card := Card type: Speed new .
	card2 := Card type: Overload new .
	
	tomas takes: { card . Card type: Overload new }.
	exequiel takes: { card2 . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: card to: tomas .
	game playNextTurn.

	self assert: ( game whereIs: tomas ) equals: 7.
	
	game currentPlayerActivatesThis: card2 to: tomas .
	game playNextTurn.
	
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 7.
	



]

{ #category : #tests }
CardTest >> testSpeedCard [
	| game aBoard dice card |

	dice := Die of: 6 rolling:#(6 6).	
	aBoard := Board with: { 	Square asCheckpoint.
									Square with: NoEffect new .
									Square with: NoEffect new .				
									Square with: AtomicBomb  new.
									Square with: NoEffect new .
									Square with: WormHole  new .
									Square with: Take randomCard.
									Square with: NoEffect new .
									Square with: (MoonWalk withRecoil: 5) .
									Square with: NoEffect new  				
							}.
							
	card := Card type: Speed new .
	
	tomas takes: { card . Card type: Speed new }.
	exequiel  takes: { Card type: Overload new . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: aBoard during: 2.
	
	
	game currentPlayerActivatesThis: card to: tomas .
	game playNextTurn.
	
	self assert: ( game whereIs: tomas ) equals: 7.
	
	game playNextTurn.
	
	self assert: ( game whereIs: exequiel ) equals: 6.




]

{ #category : #tests }
CardTest >> testUseOneCardFromPlayersHand [
	| game dice card |

	dice := Die of: 6 rolling:#(6 6).	

	card := Card type: Speed new .
	
	tomas takes: { card . Card type: Speed new }.
	exequiel  takes: { Card type: Overload new . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: self aBoard during: 2.
	
	
	game currentPlayerActivatesThis: card to: tomas .
	
	self assert: tomas cardsInHand equals: 1.

]

{ #category : #tests }
CardTest >> testUseOneCardThatIsNotInPlayersHand [
	| game dice card card2 |

	dice := Die of: 6 rolling:#(6 6).	

	card := Card type: Speed new .
	card2 := Card type: Acceleration new .
	
	tomas takes: { card . Card type: Speed new }.
	exequiel  takes: { Card type: Overload new . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: self aBoard during: 2.
		
	self 
		should: [ game currentPlayerActivatesThis: card2 to: tomas . ] 
		raise: Error 
		description: 'This card is not in player s hand.'.
]
