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


!DistanceInterval methodsFor: 'enumerating' stamp: 'JG 5/28/2017 00:51:39'!
do: aBlock
	| currentValue |
	
	currentValue _ start.
	[ currentValue <= stop ]
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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceInterval class' category: #'Distance-Solution'!
DistanceInterval class
	instanceVariableNames: ''!

!DistanceInterval class methodsFor: 'instance creation' stamp: 'JG 5/28/2017 00:31:47'!
from: startDistance to: stopDistance

	^ self new 
		setFrom: startDistance 
		to: stopDistance
		by: (Distance withAmount: 1 withMeterMultiplier: startDistance meterMultiplier)! !

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

!TestDistancia methodsFor: 'Testing' stamp: 'AM 5/25/2017 15:09:06'!
test01AllMetersAreTheSame

	| unMetro otroMetro |
	
	unMetro _ Distance withAmount: 1 withMeterMultiplier: 1.
	otroMetro _ Distance withAmount: 1 withMeterMultiplier: 1.
	
	self assert: unMetro = otroMetro.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 5/25/2017 15:23:51'!
test02AMeterPlusAMeterEqualsTwoMeters

	| unMetro dosMetros |
	
	unMetro _ Distance withAmount: 1 withMeterMultiplier:1.
	dosMetros _ Distance withAmount: 2 withMeterMultiplier:1.
	
	self assert: (unMetro + unMetro) equals: dosMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 5/25/2017 15:12:09'!
test03AMeterEqualsAHundredCentimeters

	| unMetro cienCentimetros |
	
	unMetro _ Distance withAmount: 1 withMeterMultiplier: 1.
	cienCentimetros  _ Distance withAmount: 100 withMeterMultiplier: 1/100.
	
	self assert: unMetro = cienCentimetros.
	self assert: cienCentimetros = unMetro.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 5/25/2017 15:12:51'!
test04TwoMetersMinusAHundredCentimetersEqualsAThousandMilimeters

	| dosMetros cienCentimetros milMilimetros |
	
	dosMetros _ Distance withAmount: 2 withMeterMultiplier:1.
	cienCentimetros  _ Distance withAmount: 100 withMeterMultiplier:1/100.
	milMilimetros _ Distance withAmount: 1000 withMeterMultiplier:1/1000.
	
	self assert: dosMetros - cienCentimetros = milMilimetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 5/25/2017 18:57:01'!
test05AMeterTimesTwoEqualsTwoMetersAndViceversa

	| unMetro dosMetros |
	
	unMetro _ Distance withAmount: 1 withMeterMultiplier: 1.
	dosMetros _ Distance withAmount: 2 withMeterMultiplier: 1.
	
	self assert: unMetro * 2 = dosMetros.
	self assert: 2 * unMetro = dosMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 5/25/2017 15:32:34'!
test06AMeterDividedByTwoIsHalfAMeter

	| unMetro unMedioMetro |
	
	unMetro _ Distance withAmount: 1 withMeterMultiplier: 1.
	unMedioMetro _ Distance withAmount: 0.50 withMeterMultiplier: 1.

	self assert: unMetro / 2 = unMedioMetro.
! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 5/25/2017 15:33:14'!
test07TenKilometersAreLongerThanAMeter

	| unMetro tresMetros diezKilometros |
	
	unMetro _ Distance withAmount: 1 withMeterMultiplier: 1.
	tresMetros _ Distance withAmount: 3 withMeterMultiplier: 1.
	diezKilometros _ Distance withAmount: 10 withMeterMultiplier:1000.

	self assert: diezKilometros > unMetro.
	self assert: unMetro < tresMetros.
	self assert: diezKilometros >= unMetro.
	self assert: unMetro <= tresMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 5/25/2017 15:36:41'!
test08AMeterIsShorterThanThreeMeters

	| unMetro tresMetros diezKilometros |
	
	unMetro _ Distance withAmount: 1 withMeterMultiplier: 1.
	tresMetros _ Distance withAmount: 3 withMeterMultiplier: 1.
	diezKilometros _ Distance withAmount: 10 withMeterMultiplier: 1000.

	self assert: unMetro < tresMetros.
	self assert: diezKilometros >= unMetro.
	self assert: unMetro <= tresMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 5/25/2017 15:37:03'!
test09TenKilometersAreLongerOrEqualThanAMeter

	| unMetro tresMetros diezKilometros |
	
	unMetro _ Distance withAmount: 1 withMeterMultiplier: 1.
	tresMetros _ Distance withAmount: 3  withMeterMultiplier: 1.
	diezKilometros _ Distance withAmount: 10 withMeterMultiplier: 1000.

	self assert: diezKilometros >= unMetro.
	self assert: unMetro <= tresMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 5/25/2017 15:37:18'!
test10AMeterIsShorterOrEqualThanThreeMeters

	| unMetro tresMetros |
	
	unMetro _ Distance withAmount: 1 withMeterMultiplier: 1.
	tresMetros _ Distance withAmount: 3 withMeterMultiplier: 1.

	self assert: unMetro <= tresMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 5/30/2017 13:39:09'!
test11ADistanceCanGenerateAnIntervalToAnotherDistance

	| unMetro tresMetros |
	
	unMetro _ Distance withAmount: 1 withMeterMultiplier: 1.
	tresMetros _ Distance withAmount: 3 withMeterMultiplier: 1.

	self assert: (unMetro to: tresMetros) equals: (DistanceInterval from: unMetro to: tresMetros)! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 5/30/2017 13:40:02'!
test12ADistanceCanGenerateAnIntervalToAnotherDistanceUsingAStepDistance

	| unMetro cincoCentimetros diezKilometros |
	
	unMetro _ Distance withAmount: 1 withMeterMultiplier: 1.
	diezKilometros _ Distance withAmount: 10 withMeterMultiplier: 1000.
	cincoCentimetros _ Distance withAmount: 5 withMeterMultiplier: 1/100.

	self assert: (unMetro to: diezKilometros by: cincoCentimetros) equals: (DistanceInterval from: unMetro to: diezKilometros by: cincoCentimetros)! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 5/30/2017 13:49:31'!
test13ADistanceIntervalCanBeTraveled

	| ceroMetros unMetro tresMetros distanceSum |
	
	ceroMetros _ Distance withAmount: 0 withMeterMultiplier: 1.
	unMetro _ Distance withAmount: 1 withMeterMultiplier: 1.
	tresMetros _ Distance withAmount: 3 withMeterMultiplier: 1.

	distanceSum _ ceroMetros.
	(unMetro to: tresMetros) do: [ :aDistance | distanceSum  _ distanceSum + aDistance ].
				
	self assert: distanceSum equals: (Distance withAmount: 6 withMeterMultiplier: 1)! !

!TestDistancia methodsFor: 'Testing' stamp: 'JG 5/30/2017 13:51:59'!
test14ADistanceIntervalWithCustomStepCanBeTraveled

	| ceroMetros unMetro tresMetros veinteCentimetros distanceSum expectedDistanceAmount |
	
	ceroMetros _ Distance withAmount: 0 withMeterMultiplier: 1.
	unMetro _ Distance withAmount: 1 withMeterMultiplier: 1.
	tresMetros _ Distance withAmount: 3 withMeterMultiplier: 1.
	veinteCentimetros _ Distance withAmount: 20 withMeterMultiplier: 1/100.

	distanceSum _ ceroMetros.
	(unMetro to: tresMetros by: veinteCentimetros) do: [ :aDistance | distanceSum  _ distanceSum + aDistance ].

	expectedDistanceAmount _	(1 + 1.2 + 1.4 + 1.6 + 1.8 + 2 + 2.2 + 2.4 + 2.6 + 2.8 + 3).
	
	self assert: distanceSum equals: (Distance withAmount: expectedDistanceAmount withMeterMultiplier: 1)	
	
	
	! !


!classDefinition: #Distance category: #'Distance-Solution'!
Object subclass: #Distance
	instanceVariableNames: 'amount meterMultiplier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'arithmetic' stamp: 'AM 5/25/2017 15:10:29'!
* anAmount

	^ Distance withAmount: (amount * anAmount) withMeterMultiplier: meterMultiplier! !

!Distance methodsFor: 'arithmetic' stamp: 'AM 5/25/2017 15:10:24'!
+ aDistance 
	
	^ Distance withAmount: ((amount * meterMultiplier) + (aDistance amount * aDistance meterMultiplier)) / meterMultiplier withMeterMultiplier: meterMultiplier! !

!Distance methodsFor: 'arithmetic' stamp: 'JG 5/30/2017 13:55:40'!
- aDistance 
	
	^ self + (aDistance * -1)	! !

!Distance methodsFor: 'arithmetic' stamp: 'AM 5/25/2017 15:10:41'!
/ anAmount

	^ Distance withAmount: amount / anAmount withMeterMultiplier: meterMultiplier! !


!Distance methodsFor: 'comparing' stamp: 'AM 5/25/2017 15:10:49'!
< aDistance 

	^ amount * meterMultiplier < (aDistance amount * aDistance meterMultiplier)! !

!Distance methodsFor: 'comparing' stamp: 'AM 5/25/2017 15:05:44'!
<= aDistance 

	^ self < aDistance or: self = aDistance! !

!Distance methodsFor: 'comparing' stamp: 'AM 5/25/2017 15:11:01'!
= aDistance 
	
	^ amount * meterMultiplier  = (aDistance amount * aDistance meterMultiplier)! !

!Distance methodsFor: 'comparing' stamp: 'AM 5/25/2017 15:35:24'!
> aDistance 
	
	^ (self <= aDistance) not! !

!Distance methodsFor: 'comparing' stamp: 'AM 5/25/2017 15:35:36'!
>= aDistance 
	
	^ (self < aDistance) not! !


!Distance methodsFor: 'converting' stamp: 'AM 5/25/2017 15:31:19'!
adaptToNumber: aSmallInteger andSend: aSymbol 
	
	^ self perform: aSymbol with: aSmallInteger
! !

!Distance methodsFor: 'converting' stamp: 'JG 5/27/2017 21:25:16'!
to: aDistance 
	
	^ DistanceInterval from: self to: aDistance ! !

!Distance methodsFor: 'converting' stamp: 'JG 5/30/2017 14:01:03'!
to: stopDistance by: stepDistance 
	
	^ DistanceInterval from: self to: stopDistance by: stepDistance ! !


!Distance methodsFor: 'accessing' stamp: 'JG 5/23/2017 19:58:06'!
amount

	^ amount! !

!Distance methodsFor: 'accessing' stamp: 'AM 5/25/2017 14:53:11'!
meterMultiplier

	^ meterMultiplier! !


!Distance methodsFor: 'initialization' stamp: 'AM 5/25/2017 13:44:15'!
initializeWithAmount: anAmount withMeterMultiplier: aMeterMultiplier
	
	amount _ anAmount.
	meterMultiplier _ aMeterMultiplier.
	
	^ self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'instance creation' stamp: 'AM 5/25/2017 13:46:16'!
withAmount: anAmount withMeterMultiplier: aMeterMultiplier

	^ self new initializeWithAmount: anAmount withMeterMultiplier: aMeterMultiplier! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'generating' stamp: 'AM 5/25/2017 15:18:51'!
minusOneMeter

	^ Distance withAmount: -1 withMeterMultiplier: 1
	! !

!DistanceFactory methodsFor: 'generating' stamp: 'AM 5/25/2017 15:19:43'!
oneCentimeter

	^ Distance withAmount:1 withMeterMultiplier: 1/100! !

!DistanceFactory methodsFor: 'generating' stamp: 'AM 5/25/2017 15:19:38'!
oneHundredCentimeters

	^ Distance withAmount:100 withMeterMultiplier: 1/100! !

!DistanceFactory methodsFor: 'generating' stamp: 'AM 5/25/2017 15:19:33'!
oneMeter

	^ Distance withAmount:1 withMeterMultiplier: 1! !

!DistanceFactory methodsFor: 'generating' stamp: 'AM 5/25/2017 15:19:56'!
twoHundredCentimeters

	^ Distance withAmount:200 withMeterMultiplier: 1/100! !

!DistanceFactory methodsFor: 'generating' stamp: 'AM 5/25/2017 15:20:04'!
twoMeters

	^ Distance withAmount:2 withMeterMultiplier: 1! !

!DistanceFactory methodsFor: 'generating' stamp: 'AM 5/25/2017 15:20:13'!
zeroMeters

	^ Distance initializeWithAmount:0 withMeterMultiplier: 1! !
