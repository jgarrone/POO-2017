!classDefinition: #Distance category: #'Distance-Solution'!
Magnitude subclass: #Distance
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'arithmetic' stamp: 'JG 6/4/2017 18:35:18'!
* anAmount

	^ Distance withAmount: (amount * anAmount) withUnit: unit! !

!Distance methodsFor: 'arithmetic' stamp: 'JG 6/4/2017 18:40:11'!
+ aDistance 
	
	^ Distance withAmount: ((amount * (unit meterMultiplier)) + (aDistance amount * aDistance meterMultiplier)) / (unit meterMultiplier) withUnit: unit! !

!Distance methodsFor: 'arithmetic' stamp: 'JG 5/30/2017 13:55:40'!
- aDistance 
	
	^ self + (aDistance * -1)	! !

!Distance methodsFor: 'arithmetic' stamp: 'JG 6/4/2017 18:40:29'!
/ anAmount

	^ Distance withAmount: amount / anAmount withUnit: unit! !

!Distance methodsFor: 'arithmetic' stamp: 'JG 6/4/2017 18:20:41'!
negated

	^ self * -1	! !

!Distance methodsFor: 'arithmetic' stamp: 'JG 6/4/2017 23:20:50'!
printString

	| stringWithoutAnSAtTheEnd |
	
	stringWithoutAnSAtTheEnd _ self amount asString , ' ' , self unit printString.
	(amount = 1) ifFalse: [stringWithoutAnSAtTheEnd _ stringWithoutAnSAtTheEnd , 's'].
	
	^ stringWithoutAnSAtTheEnd ! !


!Distance methodsFor: 'comparing' stamp: 'JG 6/4/2017 18:40:55'!
< aDistance 

	^ amount * (unit meterMultiplier) < (aDistance amount * aDistance meterMultiplier)! !

!Distance methodsFor: 'comparing' stamp: 'JG 6/4/2017 23:10:38'!
= aDistance 
	
	^ (aDistance isKindOf: self class)
		and: [amount * (unit meterMultiplier)  = (aDistance amount * aDistance meterMultiplier)]! !


!Distance methodsFor: 'converting' stamp: 'AM 5/25/2017 15:31:19'!
adaptToNumber: aSmallInteger andSend: aSymbol 
	
	^ self perform: aSymbol with: aSmallInteger
! !

!Distance methodsFor: 'converting' stamp: 'JG 6/4/2017 23:09:18'!
convertTo: aUnit

	^ Distance withAmount: ( amount * ( unit meterMultiplier / aUnit meterMultiplier ) ) withUnit: aUnit! !

!Distance methodsFor: 'converting' stamp: 'JG 5/27/2017 21:25:16'!
to: aDistance 
	
	^ DistanceInterval from: self to: aDistance ! !

!Distance methodsFor: 'converting' stamp: 'JG 5/30/2017 14:01:03'!
to: stopDistance by: stepDistance 
	
	^ DistanceInterval from: self to: stopDistance by: stepDistance ! !


!Distance methodsFor: 'accessing' stamp: 'JG 5/23/2017 19:58:06'!
amount

	^ amount! !

!Distance methodsFor: 'accessing' stamp: 'JG 6/4/2017 18:41:28'!
meterMultiplier

	^ unit meterMultiplier! !

!Distance methodsFor: 'accessing' stamp: 'JG 6/4/2017 19:36:29'!
unit

	^ unit! !


!Distance methodsFor: 'initialization' stamp: 'JG 6/4/2017 18:36:01'!
initializeWithAmount: anAmount withUnit: aUnit
	
	amount _ anAmount.
	unit _ aUnit.
	
	^ self! !


!Distance methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 23:21:55'!
hash

	^ (amount * unit meterMultiplier) hash! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'instance creation' stamp: 'JG 6/4/2017 18:34:51'!
withAmount: anAmount withUnit: aUnit

	^ self new initializeWithAmount: anAmount withUnit: aUnit! !


!classDefinition: #DistanceInterval category: #'Distance-Solution'!
SequenceableCollection subclass: #DistanceInterval
	instanceVariableNames: 'start stop step'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceInterval methodsFor: 'comparing' stamp: 'JG 5/28/2017 15:52:33'!
= otherDistanceInterval

	^ start = otherDistanceInterval start
		and: stop = otherDistanceInterval stop
			and: step = otherDistanceInterval step! !


!DistanceInterval methodsFor: 'enumerating' stamp: 'JG 6/4/2017 23:34:36'!
do: aBlock
	| currentValue |
	
	currentValue _ start.
	[ (start <= stop and: [ currentValue <= stop ]) or: (start > stop and: [ currentValue >= stop ]) ]
		whileTrue:
			[ aBlock value: currentValue.
			currentValue _ currentValue + step ]! !


!DistanceInterval methodsFor: 'initialization' stamp: 'JG 5/28/2017 00:30:55'!
setFrom: startDistance to: stopDistance by: stepDistance

	start _ startDistance.
	stop _ stopDistance.	
	step _ stepDistance.

	^ self! !


!DistanceInterval methodsFor: 'accessing' stamp: 'JG 5/27/2017 21:52:34'!
start

	^ start! !

!DistanceInterval methodsFor: 'accessing' stamp: 'JG 5/28/2017 00:33:28'!
step

	^ step! !

!DistanceInterval methodsFor: 'accessing' stamp: 'JG 5/27/2017 21:52:08'!
stop

	^ stop! !


!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 23:25:21'!
by

	^ step! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 23:24:41'!
from

	^ start! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 23:25:08'!
to

	^ stop! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceInterval class' category: #'Distance-Solution'!
DistanceInterval class
	instanceVariableNames: ''!

!DistanceInterval class methodsFor: 'instance creation' stamp: 'JG 6/4/2017 19:36:19'!
from: startDistance to: stopDistance

	^ self new 
		setFrom: startDistance 
		to: stopDistance
		by: (Distance withAmount: 1 withUnit: startDistance unit)! !

!DistanceInterval class methodsFor: 'instance creation' stamp: 'JG 5/27/2017 23:47:26'!
from: startDistance to: stopDistance by: stepDistance
	
	^ self new
		setFrom: startDistance 
		to: stopDistance 
		by: stepDistance! !


!classDefinition: #TestDistancia category: #'Distance-Solution'!
TestCase subclass: #TestDistancia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!TestDistancia methodsFor: 'Testing' stamp: 'JG 6/4/2017 18:47:13'!
test01AllMetersAreTheSame

	| unMetro otroMetro |
	
	unMetro _ DistanceFactory new oneMeter.
	otroMetro _ DistanceFactory new oneMeter.
	
	self assert: unMetro = otroMetro.! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 6/4/2017 18:47:25'!
test02AMeterPlusAMeterEqualsTwoMeters

	| unMetro dosMetros |
	
	unMetro _ DistanceFactory new oneMeter.
	dosMetros _ DistanceFactory new twoMeters.
	
	self assert: (unMetro + unMetro) equals: dosMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 6/4/2017 18:48:46'!
test03AMeterEqualsAHundredCentimeters

	| unMetro cienCentimetros |
	
	unMetro _ DistanceFactory new oneMeter.
	cienCentimetros  _ DistanceFactory new oneHundredCentimeters.
	
	self assert: unMetro = cienCentimetros.
	self assert: cienCentimetros = unMetro.! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 6/4/2017 19:14:23'!
test04TwoMetersMinusAHundredCentimetersEqualsAThousandMilimeters

	| dosMetros cienCentimetros milMilimetros |
	
	dosMetros _ DistanceFactory new twoMeters.
	cienCentimetros  _ DistanceFactory new oneHundredCentimeters.
	milMilimetros _ Distance withAmount: 1000 withUnit: (DistanceUnitFactory new milimeter).
	
	self assert: dosMetros - cienCentimetros = milMilimetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 6/4/2017 19:15:30'!
test05AMeterTimesTwoEqualsTwoMetersAndViceversa

	| unMetro dosMetros |
	
	unMetro _ DistanceFactory new oneMeter. 
	dosMetros _ DistanceFactory new twoMeters.
	
	self assert: unMetro * 2 = dosMetros.
	self assert: 2 * unMetro = dosMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 6/4/2017 19:18:46'!
test06AMeterDividedByTwoIsHalfAMeter

	| unMetro unMedioMetro |
	
	unMetro _ DistanceFactory new oneMeter.
	unMedioMetro _ Distance withAmount: 1/2 withUnit: (DistanceUnitFactory new meter).

	self assert: unMetro / 2 = unMedioMetro.
! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 6/4/2017 19:23:51'!
test07TenKilometersAreLongerThanAMeter

	| unMetro tresMetros diezKilometros |
	
	unMetro _ DistanceFactory new oneMeter.
	tresMetros _ DistanceFactory new threeMeters.
	diezKilometros _ DistanceFactory new tenKilometers.

	self assert: diezKilometros > unMetro.
	self assert: unMetro < tresMetros.
	self assert: diezKilometros >= unMetro.
	self assert: unMetro <= tresMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 6/4/2017 19:24:11'!
test08AMeterIsShorterThanThreeMeters

	| unMetro tresMetros diezKilometros |
	
	unMetro _ DistanceFactory new oneMeter.
	tresMetros _ DistanceFactory new threeMeters.
	diezKilometros _ DistanceFactory new tenKilometers.

	self assert: unMetro < tresMetros.
	self assert: diezKilometros >= unMetro.
	self assert: unMetro <= tresMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 6/4/2017 19:22:45'!
test09TenKilometersAreLongerOrEqualThanAMeter

	| unMetro tresMetros diezKilometros |
	
	unMetro _ DistanceFactory new oneMeter.
	tresMetros _ DistanceFactory new threeMeters.
	diezKilometros _ DistanceFactory new tenKilometers.

	self assert: diezKilometros >= unMetro.
	self assert: unMetro <= tresMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 6/4/2017 19:24:28'!
test10AMeterIsShorterOrEqualThanThreeMeters

	| unMetro tresMetros |
	
	unMetro _ DistanceFactory new oneMeter.
	tresMetros _ DistanceFactory new threeMeters.

	self assert: unMetro <= tresMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 6/4/2017 19:24:40'!
test11ADistanceCanGenerateAnIntervalToAnotherDistance

	| unMetro tresMetros |
	
	unMetro _ DistanceFactory new oneMeter.
	tresMetros _ DistanceFactory new threeMeters.

	self assert: (unMetro to: tresMetros) equals: (DistanceInterval from: unMetro to: tresMetros)! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 6/4/2017 19:34:51'!
test12ADistanceCanGenerateAnIntervalToAnotherDistanceUsingAStepDistance

	| unMetro cincoCentimetros diezKilometros |
	
	unMetro _ DistanceFactory new oneMeter.
	diezKilometros _ DistanceFactory new tenKilometers.
	cincoCentimetros _ Distance withAmount: 5 withUnit: (DistanceUnitFactory new centimeter).

	self assert: (unMetro to: diezKilometros by: cincoCentimetros) equals: (DistanceInterval from: unMetro to: diezKilometros by: cincoCentimetros)! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 6/4/2017 19:32:54'!
test13ADistanceIntervalCanBeTraveled

	| ceroMetros unMetro tresMetros distanceSum |
	
	ceroMetros _ DistanceFactory new zeroMeters.
	unMetro _ DistanceFactory new oneMeter.
	tresMetros _ DistanceFactory new threeMeters.

	distanceSum _ ceroMetros.
	(unMetro to: tresMetros) do: [ :aDistance | distanceSum  _ distanceSum + aDistance ].
				
	self assert: distanceSum equals: (Distance withAmount: 6 withUnit: (DistanceUnitFactory new meter))! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 6/4/2017 19:48:58'!
test14ADistanceIntervalWithCustomStepCanBeTraveled

	| ceroMetros unMetro tresMetros veinteCentimetros distanceSum expectedDistanceAmount |
	
	ceroMetros _ DistanceFactory new zeroMeters.
	unMetro _ DistanceFactory new oneMeter.
	tresMetros _ DistanceFactory new threeMeters.
	veinteCentimetros _ Distance withAmount: 20 withUnit: (DistanceUnitFactory new centimeter).

	distanceSum _ ceroMetros.
	(unMetro to: tresMetros by: veinteCentimetros) do: [ :aDistance | distanceSum  _ distanceSum + aDistance ].

	expectedDistanceAmount _	(1 + 1.2 + 1.4 + 1.6 + 1.8 + 2 + 2.2 + 2.4 + 2.6 + 2.8 + 3).
	
	self assert: distanceSum equals: (Distance withAmount: expectedDistanceAmount withUnit: (DistanceUnitFactory new meter))	
	
	
	! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'generating' stamp: 'JG 6/4/2017 18:53:15'!
minusOneMeter

	^ Distance withAmount: -1 withUnit: (DistanceUnitFactory new meter)
	! !

!DistanceFactory methodsFor: 'generating' stamp: 'JG 6/4/2017 18:53:01'!
oneCentimeter

	^ Distance withAmount: 1 withUnit: (DistanceUnitFactory new centimeter)! !

!DistanceFactory methodsFor: 'generating' stamp: 'JG 6/4/2017 18:52:46'!
oneHundredCentimeters

	^ Distance withAmount: 100 withUnit: (DistanceUnitFactory new centimeter)! !

!DistanceFactory methodsFor: 'generating' stamp: 'JG 6/4/2017 18:53:21'!
oneMeter

	^ Distance withAmount: 1 withUnit: (DistanceUnitFactory new meter)! !

!DistanceFactory methodsFor: 'generating' stamp: 'JG 6/4/2017 19:23:17'!
tenKilometers

	^ Distance withAmount: 10 withUnit: (DistanceUnitFactory new kilometer)
	! !

!DistanceFactory methodsFor: 'generating' stamp: 'JG 6/4/2017 19:23:06'!
threeMeters

	^ Distance withAmount: 3 withUnit: (DistanceUnitFactory new meter)
	! !

!DistanceFactory methodsFor: 'generating' stamp: 'JG 6/4/2017 18:52:52'!
twoHundredCentimeters

	^ Distance withAmount: 200 withUnit: (DistanceUnitFactory new centimeter)! !

!DistanceFactory methodsFor: 'generating' stamp: 'JG 6/4/2017 18:53:27'!
twoMeters

	^ Distance withAmount: 2 withUnit: (DistanceUnitFactory new meter)! !

!DistanceFactory methodsFor: 'generating' stamp: 'JG 6/4/2017 19:37:04'!
zeroMeters

	^ Distance withAmount: 0 withUnit: (DistanceUnitFactory new meter)! !


!classDefinition: #DistanceUnit category: #'Distance-Solution'!
Object subclass: #DistanceUnit
	instanceVariableNames: 'meterMultiplier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 22:54:57'!
= anotherDistanceUnit

	^ (anotherDistanceUnit isKindOf: self class) 
		and: [ meterMultiplier = anotherDistanceUnit meterMultiplier]! !

!DistanceUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 18:32:48'!
initializeWith: aMeterMultiplier

	meterMultiplier _ aMeterMultiplier.
		
	^ self! !

!DistanceUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 18:38:59'!
meterMultiplier

	^ meterMultiplier ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceUnit class' category: #'Distance-Solution'!
DistanceUnit class
	instanceVariableNames: ''!

!DistanceUnit class methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 18:31:57'!
withMeterMultiplier: aMeterMultiplier
	
	^ self new initializeWith: aMeterMultiplier! !


!classDefinition: #LabeledDistanceUnit category: #'Distance-Solution'!
DistanceUnit subclass: #LabeledDistanceUnit
	instanceVariableNames: 'label'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!LabeledDistanceUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 19:09:46'!
initializeWithLabel: aLabel

	label _ aLabel.

	^ self! !

!LabeledDistanceUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 19:05:28'!
printString

	^ label! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LabeledDistanceUnit class' category: #'Distance-Solution'!
LabeledDistanceUnit class
	instanceVariableNames: ''!

!LabeledDistanceUnit class methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 19:09:14'!
withMeterMultiplier: aMeterMultiplier withLabel: aLabel

	| aLabeledDistanceUnit |

	aLabeledDistanceUnit _ self new initializeWith: aMeterMultiplier.
	aLabeledDistanceUnit initializeWithLabel: aLabel.
	
	^ aLabeledDistanceUnit ! !


!classDefinition: #DistanceUnitFactory category: #'Distance-Solution'!
Object subclass: #DistanceUnitFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceUnitFactory methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 19:10:49'!
centimeter

	^ LabeledDistanceUnit withMeterMultiplier: 1/100 withLabel: 'centimeter'! !

!DistanceUnitFactory methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 19:50:36'!
decameter

	^ LabeledDistanceUnit withMeterMultiplier: 10 withLabel: 'decameter'! !

!DistanceUnitFactory methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 19:52:47'!
decimeter

	^ LabeledDistanceUnit withMeterMultiplier: 1/10 withLabel: 'decimeter'! !

!DistanceUnitFactory methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 19:50:15'!
hectometer

	^ LabeledDistanceUnit withMeterMultiplier: 100 withLabel: 'hectometer'! !

!DistanceUnitFactory methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 19:20:37'!
kilometer
	
	^ LabeledDistanceUnit withMeterMultiplier: 1000 withLabel: 'kilometer'! !

!DistanceUnitFactory methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 19:11:00'!
meter
	
	^ LabeledDistanceUnit withMeterMultiplier: 1 withLabel: 'meter'! !

!DistanceUnitFactory methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 21:11:03'!
milimeter

	^ LabeledDistanceUnit withMeterMultiplier: 1/1000 withLabel: 'milimeter'! !

!DistanceUnitFactory methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 19:54:31'!
millimeter

	^ self milimeter! !

!DistanceUnitFactory methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 18:59:37'!
withMeterMultiplier: aMeterMultiplier

	^ DistanceUnit withMeterMultiplier: aMeterMultiplier! !
