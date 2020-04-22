Class {
	#name : #BaselineOfIngSoft2,
	#superclass : #BaselineOf,
	#category : #BaselineOfIngSoft2
}

{ #category : #baselines }
BaselineOfIngSoft2 >> baseline: spec [

	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'IS2-GameTP1';
				package: 'IS2-GameTP1-Tests' with: [ spec requires: #('IS2-GameTP1')] .

			spec
				group: 'default' with: #('deployment');
				group: 'deployment' with: #('IS2-GameTP1');
				group: 'development' with: #('IS2-GameTP1-Tests') ]
]

{ #category : #accessing }
BaselineOfIngSoft2 >> projectClass [

	^ MetacelloCypressBaselineProject
]
