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
	"| game dice card card2 |

	dice := Die of: 6 rolling:#(6 6).	

	card := Card type: Speed new .
	card2 := Card type: Acceleration new .
	
	tomas takes: { card . Card type: Speed new }.
	exequiel  takes: { Card type: Overload new . Card type: Acceleration new }.
	
	game := Game playedBy: { tomas . exequiel } throwing: dice on: self aBoard during: 2.
		
	self 
		should: [ game currentPlayerActivatesThis: card2 to: tomas . ] 
		raise: Error 
		description: 'This card is not in player s hand.'."
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
