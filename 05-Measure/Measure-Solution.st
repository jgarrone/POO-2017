!classDefinition: #Measure category: #'Measure-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'arithmetic' stamp: 'AM 6/5/2017 14:56:52'!
* anAmount

	^ Measure withAmount: (amount * anAmount) withUnit: unit! !

!Measure methodsFor: 'arithmetic' stamp: 'AM 6/5/2017 15:54:05'!
+ aMeasure 
	
	^ Measure withAmount: (((self absoluteAmount) + (aMeasure absoluteAmount)) / (unit unitMultiplier)) withUnit: unit! !

!Measure methodsFor: 'arithmetic' stamp: 'JG 5/30/2017 13:55:40'!
- aDistance 
	
	^ self + (aDistance * -1)	! !

!Measure methodsFor: 'arithmetic' stamp: 'AM 6/5/2017 14:57:15'!
/ anAmount

	^ Measure withAmount: amount / anAmount withUnit: unit! !

!Measure methodsFor: 'arithmetic' stamp: 'JG 6/4/2017 18:20:41'!
negated

	^ self * -1	! !

!Measure methodsFor: 'arithmetic' stamp: 'JG 6/4/2017 23:20:50'!
printString

	| stringWithoutAnSAtTheEnd |
	
	stringWithoutAnSAtTheEnd _ self amount asString , ' ' , self unit printString.
	(amount = 1) ifFalse: [stringWithoutAnSAtTheEnd _ stringWithoutAnSAtTheEnd , 's'].
	
	^ stringWithoutAnSAtTheEnd ! !


!Measure methodsFor: 'comparing' stamp: 'AM 6/5/2017 15:54:44'!
< aDistance 

	^ self absoluteAmount < (aDistance absoluteAmount)! !

!Measure methodsFor: 'comparing' stamp: 'AM 6/5/2017 15:55:13'!
= aMeasure
	
	^ (aMeasure isKindOf: self class)
		and: [self absoluteAmount  = (aMeasure absoluteAmount)]! !


!Measure methodsFor: 'converting' stamp: 'AM 5/25/2017 15:31:19'!
adaptToNumber: aSmallInteger andSend: aSymbol 
	
	^ self perform: aSymbol with: aSmallInteger
! !

!Measure methodsFor: 'converting' stamp: 'AM 6/5/2017 15:56:03'!
convertTo: aUnit

	^ Measure withAmount: ( amount * ( unit unitMultiplier / aUnit unitMultiplier ) ) withUnit: aUnit! !

!Measure methodsFor: 'converting' stamp: 'JG 5/27/2017 21:25:16'!
to: aDistance 
	
	^ DistanceInterval from: self to: aDistance ! !

!Measure methodsFor: 'converting' stamp: 'JG 5/30/2017 14:01:03'!
to: stopDistance by: stepDistance 
	
	^ DistanceInterval from: self to: stopDistance by: stepDistance ! !


!Measure methodsFor: 'accessing' stamp: 'AM 6/5/2017 16:00:45'!
absoluteAmount

	^ (amount + self amountToUnitCorrection) * self unitMultiplier! !

!Measure methodsFor: 'accessing' stamp: 'JG 5/23/2017 19:58:06'!
amount

	^ amount! !

!Measure methodsFor: 'accessing' stamp: 'AM 6/5/2017 16:01:04'!
amountToUnitCorrection
	^ unit amountToUnitCorrection! !

!Measure methodsFor: 'accessing' stamp: 'JG 6/4/2017 19:36:29'!
unit

	^ unit! !

!Measure methodsFor: 'accessing' stamp: 'AM 6/5/2017 15:25:47'!
unitMultiplier

	^ unit unitMultiplier! !


!Measure methodsFor: 'initialization' stamp: 'JG 6/4/2017 18:36:01'!
initializeWithAmount: anAmount withUnit: aUnit
	
	amount _ anAmount.
	unit _ aUnit.
	
	^ self! !


!Measure methodsFor: 'as yet unclassified' stamp: 'JG 6/4/2017 23:21:55'!
hash

	^ (amount * unit meterMultiplier) hash! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'instance creation' stamp: 'AM 6/5/2017 16:09:01'!
withAmount: anAmount withUnit: aUnit

	^ self new initializeWithAmount: anAmount withUnit: aUnit! !


!classDefinition: #DistanceInterval category: #'Measure-Solution'!
SequenceableCollection subclass: #DistanceInterval
	instanceVariableNames: 'start stop step'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

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

!classDefinition: 'DistanceInterval class' category: #'Measure-Solution'!
DistanceInterval class
	instanceVariableNames: ''!

!DistanceInterval class methodsFor: 'instance creation' stamp: 'AM 6/5/2017 14:57:29'!
from: startDistance to: stopDistance

	^ self new 
		setFrom: startDistance 
		to: stopDistance
		by: (Measure withAmount: 1 withUnit: startDistance unit)! !

!DistanceInterval class methodsFor: 'instance creation' stamp: 'JG 5/27/2017 23:47:26'!
from: startDistance to: stopDistance by: stepDistance
	
	^ self new
		setFrom: startDistance 
		to: stopDistance 
		by: stepDistance! !


!classDefinition: #TestDistancia category: #'Measure-Solution'!
TestCase subclass: #TestDistancia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!TestDistancia methodsFor: 'Testing' stamp: 'AM 6/5/2017 14:07:51'!
test01AllMetersAreTheSame

	| unMetro otroMetro |
	
	unMetro _ MeasureFactory new oneMeter.
	otroMetro _ MeasureFactory new oneMeter.
	
	self assert: unMetro = otroMetro.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 6/5/2017 14:12:19'!
test02AMeterPlusAMeterEqualsTwoMeters

	| unMetro dosMetros |
	
	unMetro _ MeasureFactory new oneMeter.
	dosMetros _ MeasureFactory new twoMeters.
	
	self assert: (unMetro + unMetro) equals: dosMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 6/5/2017 14:12:37'!
test03AMeterEqualsAHundredCentimeters

	| unMetro cienCentimetros |
	
	unMetro _ MeasureFactory new oneMeter.
	cienCentimetros  _ MeasureFactory new oneHundredCentimeters.
	
	self assert: unMetro = cienCentimetros.
	self assert: cienCentimetros = unMetro.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 6/5/2017 14:58:33'!
test04TwoMetersMinusAHundredCentimetersEqualsAThousandMilimeters

	| dosMetros cienCentimetros milMilimetros |
	
	dosMetros _ MeasureFactory new twoMeters.
	cienCentimetros  _ MeasureFactory new oneHundredCentimeters.
	milMilimetros _ Measure withAmount: 1000 withUnit: (MeasureFactory new milimeter).
	
	self assert: dosMetros - cienCentimetros = milMilimetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 6/5/2017 14:12:58'!
test05AMeterTimesTwoEqualsTwoMetersAndViceversa

	| unMetro dosMetros |
	
	unMetro _ MeasureFactory new oneMeter. 
	dosMetros _ MeasureFactory new twoMeters.
	
	self assert: unMetro * 2 = dosMetros.
	self assert: 2 * unMetro = dosMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 6/5/2017 14:58:02'!
test06AMeterDividedByTwoIsHalfAMeter

	| unMetro unMedioMetro |
	
	unMetro _ MeasureFactory new oneMeter.
	unMedioMetro _ Measure withAmount: 1/2 withUnit: (MeasureFactory new meter).

	self assert: unMetro / 2 = unMedioMetro.
! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 6/5/2017 14:13:15'!
test07TenKilometersAreLongerThanAMeter

	| unMetro tresMetros diezKilometros |
	
	unMetro _ MeasureFactory new oneMeter.
	tresMetros _ MeasureFactory new threeMeters.
	diezKilometros _ MeasureFactory new tenKilometers.

	self assert: diezKilometros > unMetro.
	self assert: unMetro < tresMetros.
	self assert: diezKilometros >= unMetro.
	self assert: unMetro <= tresMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 6/5/2017 14:13:23'!
test08AMeterIsShorterThanThreeMeters

	| unMetro tresMetros diezKilometros |
	
	unMetro _ MeasureFactory new oneMeter.
	tresMetros _ MeasureFactory new threeMeters.
	diezKilometros _ MeasureFactory new tenKilometers.

	self assert: unMetro < tresMetros.
	self assert: diezKilometros >= unMetro.
	self assert: unMetro <= tresMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 6/5/2017 14:13:31'!
test09TenKilometersAreLongerOrEqualThanAMeter

	| unMetro tresMetros diezKilometros |
	
	unMetro _ MeasureFactory new oneMeter.
	tresMetros _ MeasureFactory new threeMeters.
	diezKilometros _ MeasureFactory new tenKilometers.

	self assert: diezKilometros >= unMetro.
	self assert: unMetro <= tresMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 6/5/2017 14:13:38'!
test10AMeterIsShorterOrEqualThanThreeMeters

	| unMetro tresMetros |
	
	unMetro _ MeasureFactory new oneMeter.
	tresMetros _ MeasureFactory new threeMeters.

	self assert: unMetro <= tresMetros.! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 6/5/2017 14:13:46'!
test11ADistanceCanGenerateAnIntervalToAnotherDistance

	| unMetro tresMetros |
	
	unMetro _ MeasureFactory new oneMeter.
	tresMetros _ MeasureFactory new threeMeters.

	self assert: (unMetro to: tresMetros) equals: (DistanceInterval from: unMetro to: tresMetros)! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 6/5/2017 14:58:14'!
test12ADistanceCanGenerateAnIntervalToAnotherDistanceUsingAStepDistance

	| unMetro cincoCentimetros diezKilometros |
	
	unMetro _ MeasureFactory new oneMeter.
	diezKilometros _ MeasureFactory new tenKilometers.
	cincoCentimetros _ Measure withAmount: 5 withUnit: (MeasureFactory new centimeter).

	self assert: (unMetro to: diezKilometros by: cincoCentimetros) equals: (DistanceInterval from: unMetro to: diezKilometros by: cincoCentimetros)! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 6/5/2017 14:58:22'!
test13ADistanceIntervalCanBeTraveled

	| ceroMetros unMetro tresMetros distanceSum |
	
	ceroMetros _ MeasureFactory new zeroMeters.
	unMetro _ MeasureFactory new oneMeter.
	tresMetros _ MeasureFactory new threeMeters.

	distanceSum _ ceroMetros.
	(unMetro to: tresMetros) do: [ :aDistance | distanceSum  _ distanceSum + aDistance ].
				
	self assert: distanceSum equals: (Measure withAmount: 6 withUnit: (MeasureFactory new meter))! !

!TestDistancia methodsFor: 'Testing' stamp: 'AM 6/5/2017 14:57:50'!
test14ADistanceIntervalWithCustomStepCanBeTraveled

	| ceroMetros unMetro tresMetros veinteCentimetros distanceSum expectedDistanceAmount |
	
	ceroMetros _ MeasureFactory new zeroMeters.
	unMetro _ MeasureFactory new oneMeter.
	tresMetros _ MeasureFactory new threeMeters.
	veinteCentimetros _ Measure withAmount: 20 withUnit: (MeasureFactory new centimeter).

	distanceSum _ ceroMetros.
	(unMetro to: tresMetros by: veinteCentimetros) do: [ :aDistance | distanceSum  _ distanceSum + aDistance ].

	expectedDistanceAmount _	(1 + 1.2 + 1.4 + 1.6 + 1.8 + 2 + 2.2 + 2.4 + 2.6 + 2.8 + 3).
	
	self assert: distanceSum equals: (Measure withAmount: expectedDistanceAmount withUnit: (MeasureFactory new meter))	
	
	
	! !


!classDefinition: #TestTemperature category: #'Measure-Solution'!
TestCase subclass: #TestTemperature
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!TestTemperature methodsFor: 'as yet unclassified' stamp: 'AM 6/5/2017 14:27:37'!
test01AllCelsiusAreTheSame

	| unCelsius otroCelsius |
	
	unCelsius _ MeasureFactory new oneCelsius.
	otroCelsius _ MeasureFactory new oneCelsius.
	
	self assert: unCelsius = otroCelsius.! !

!TestTemperature methodsFor: 'as yet unclassified' stamp: 'AM 6/5/2017 15:38:50'!
test02AllFahrenheitsAreTheSame

	| unFahrenheit otroFahrenheit |
	
	unFahrenheit _ MeasureFactory new oneFahrenheit.
	otroFahrenheit _ MeasureFactory new oneFahrenheit.
	
	self assert: unFahrenheit = otroFahrenheit.! !

!TestTemperature methodsFor: 'as yet unclassified' stamp: 'AM 6/5/2017 15:45:17'!
test03AllKelvinsAreTheSame

	| unKelvin otroKelvin |
	
	unKelvin _ MeasureFactory new oneKelvin.
	otroKelvin _ MeasureFactory new oneKelvin.
	
	self assert: unKelvin = otroKelvin.! !

!TestTemperature methodsFor: 'as yet unclassified' stamp: 'AM 6/5/2017 16:10:20'!
test04oneKelvinEquals274Celsius

	| unKelvin twoHundredSeventyFourCelsius |
	
	unKelvin _ MeasureFactory new oneKelvin.
	twoHundredSeventyFourCelsius _ (MeasureFactory new oneCelsius) * 274.
	
	self assert: unKelvin = twoHundredSeventyFourCelsius.! !


!classDefinition: #LabeledUnit category: #'Measure-Solution'!
Object subclass: #LabeledUnit
	instanceVariableNames: 'unitMultiplier amountToUnitCorrection label'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!LabeledUnit methodsFor: 'as yet unclassified' stamp: 'AM 6/5/2017 15:06:06'!
= anotherLabeledUnit

	^ (anotherLabeledUnit isKindOf: self class) 
		and: [ unitMultiplier = anotherLabeledUnit unitMultiplier]! !

!LabeledUnit methodsFor: 'as yet unclassified' stamp: 'AM 6/5/2017 16:04:50'!
amountToUnitCorrection

	^ amountToUnitCorrection! !

!LabeledUnit methodsFor: 'as yet unclassified' stamp: 'AM 6/5/2017 16:07:12'!
initializeWith: aUnitMultiplier withAmountToUnitCorrection: anAmountToUnitCorrection withLabel: aLabel

	unitMultiplier _ aUnitMultiplier.
	amountToUnitCorrection _ anAmountToUnitCorrection.
	label _ aLabel.
		
	^ self! !

!LabeledUnit methodsFor: 'as yet unclassified' stamp: 'AM 6/5/2017 14:54:10'!
printString

	^ label! !

!LabeledUnit methodsFor: 'as yet unclassified' stamp: 'AM 6/5/2017 15:22:41'!
unitMultiplier

	^ unitMultiplier! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LabeledUnit class' category: #'Measure-Solution'!
LabeledUnit class
	instanceVariableNames: ''!

!LabeledUnit class methodsFor: 'as yet unclassified' stamp: 'AM 6/5/2017 16:09:40'!
withUnitMultiplier: aUnitMultiplier withAmountToUnitCorrection: anAmountToUnitCorrection withLabel: aLabel


	^ self new initializeWith: aUnitMultiplier withAmountToUnitCorrection: anAmountToUnitCorrection withLabel: aLabel.	! !

!LabeledUnit class methodsFor: 'as yet unclassified' stamp: 'AM 6/5/2017 16:03:51'!
withUnitMultiplier: aUnitMultiplier withLabel: aLabel

	^ self new initializeWith: aUnitMultiplier withAmountToUnitCorrection: 0 withLabel: aLabel.
	
! !


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureFactory methodsFor: 'Distance Units' stamp: 'AM 6/5/2017 15:23:40'!
centimeter

	^ LabeledUnit withUnitMultiplier: 1/100 withLabel: 'centimeter'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'AM 6/5/2017 15:26:47'!
decameter

	^ LabeledUnit withUnitMultiplier: 10 withLabel: 'decameter'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'AM 6/5/2017 15:27:17'!
decimeter

	^ LabeledUnit withUnitMultiplier: 1/10 withLabel: 'decimeter'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'AM 6/5/2017 15:27:29'!
hectometer

	^ LabeledUnit withUnitMultiplier: 100 withLabel: 'hectometer'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'AM 6/5/2017 15:27:39'!
kilometer
	
	^ LabeledUnit withUnitMultiplier: 1000 withLabel: 'kilometer'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'AM 6/5/2017 15:27:50'!
meter
	
	^ LabeledUnit withUnitMultiplier: 1 withLabel: 'meter'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'AM 6/5/2017 15:28:10'!
milimeter

	^ LabeledUnit withUnitMultiplier: 1/1000 withLabel: 'milimeter'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'AM 6/5/2017 14:00:11'!
millimeter

	^ self milimeter! !


!MeasureFactory methodsFor: 'Distance Measures' stamp: 'AM 6/5/2017 14:59:15'!
minusOneMeter

	^ Measure withAmount: -1 withUnit: (self meter)
	! !

!MeasureFactory methodsFor: 'Distance Measures' stamp: 'AM 6/5/2017 14:59:24'!
oneCentimeter

	^ Measure withAmount: 1 withUnit: (self centimeter)! !

!MeasureFactory methodsFor: 'Distance Measures' stamp: 'AM 6/5/2017 14:59:10'!
oneHundredCentimeters

	^ Measure withAmount: 100 withUnit: (self centimeter)! !

!MeasureFactory methodsFor: 'Distance Measures' stamp: 'AM 6/5/2017 14:59:39'!
oneMeter

	^ Measure withAmount: 1 withUnit: (self meter)! !

!MeasureFactory methodsFor: 'Distance Measures' stamp: 'AM 6/5/2017 14:58:55'!
tenKilometers

	^ Measure withAmount: 10 withUnit: (self kilometer)
	! !

!MeasureFactory methodsFor: 'Distance Measures' stamp: 'AM 6/5/2017 14:58:39'!
threeMeters

	^ Measure withAmount: 3 withUnit: (self meter)! !

!MeasureFactory methodsFor: 'Distance Measures' stamp: 'AM 6/5/2017 14:59:02'!
twoHundredCentimeters

	^ Measure withAmount: 200 withUnit: (self centimeter)! !

!MeasureFactory methodsFor: 'Distance Measures' stamp: 'AM 6/5/2017 14:59:44'!
twoMeters

	^ Measure withAmount: 2 withUnit: (self meter)! !

!MeasureFactory methodsFor: 'Distance Measures' stamp: 'AM 6/5/2017 14:58:45'!
zeroMeters

	^ Measure withAmount: 0 withUnit: (self meter)! !


!MeasureFactory methodsFor: 'Temperature Measures' stamp: 'AM 6/5/2017 16:08:36'!
oneCelsius

	^ Measure withAmount: 1 withUnit: (self celsius)! !

!MeasureFactory methodsFor: 'Temperature Measures' stamp: 'AM 6/5/2017 16:08:13'!
oneFahrenheit

	^ Measure withAmount: 1 withUnit: (self fahrenheit)! !

!MeasureFactory methodsFor: 'Temperature Measures' stamp: 'AM 6/5/2017 15:46:07'!
oneKelvin

	^ Measure withAmount: 1 withUnit: (self kelvin)! !


!MeasureFactory methodsFor: 'Temperature Units' stamp: 'AM 6/5/2017 16:10:59'!
celsius

	^ LabeledUnit withUnitMultiplier: 1 withAmountToUnitCorrection: -273 withLabel: 'celsius'! !

!MeasureFactory methodsFor: 'Temperature Units' stamp: 'AM 6/5/2017 16:11:51'!
fahrenheit

	^ LabeledUnit withUnitMultiplier: 5/9 withAmountToUnitCorrection: -460 withLabel: 'fahrenheit'! !

!MeasureFactory methodsFor: 'Temperature Units' stamp: 'AM 6/5/2017 15:45:49'!
kelvin

	^ LabeledUnit withUnitMultiplier: 1  withLabel: 'kelvin'! !
