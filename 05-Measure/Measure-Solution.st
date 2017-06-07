!classDefinition: #Measure category: #'Measure-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'arithmetic' stamp: 'AM 6/6/2017 17:50:37'!
* anAmountOrAMeasure
	^ (anAmountOrAMeasure isKindOf: self class) 
		ifTrue: [ self timesMeasure: anAmountOrAMeasure ]
		ifFalse: [ self timesAmount: anAmountOrAMeasure ]! !

!Measure methodsFor: 'arithmetic' stamp: 'JG 6/7/2017 11:23:15'!
+ aMeasure 
	
	^ (unit isOfTheSameTypeAs: aMeasure unit) 
		ifTrue: [ Measure withAmount: ((self absoluteAmount + aMeasure absoluteAmount) / unit unitMultiplier) withUnit: unit ]
		ifFalse: [ (CompoundMeasure with: self) + aMeasure ]! !

!Measure methodsFor: 'arithmetic' stamp: 'JG 5/30/2017 13:55:40'!
- aDistance 
	
	^ self + (aDistance * -1)	! !

!Measure methodsFor: 'arithmetic' stamp: 'AM 6/7/2017 14:56:50'!
/ anAmountOrAMeasure

	^ (anAmountOrAMeasure isKindOf: self class) 
		ifTrue: [ self perMeasure: anAmountOrAMeasure ]
		ifFalse: [ Measure withAmount: amount / anAmountOrAMeasure withUnit: unit ]
	
	! !

!Measure methodsFor: 'arithmetic' stamp: 'JG 6/4/2017 18:20:41'!
negated

	^ self * -1	! !

!Measure methodsFor: 'arithmetic' stamp: 'AM 6/7/2017 14:55:28'!
perMeasure: aMeasure

	^ Measure withAmount: amount / aMeasure amount withUnit: (unit / aMeasure unit)! !

!Measure methodsFor: 'arithmetic' stamp: 'JG 6/4/2017 23:20:50'!
printString

	| stringWithoutAnSAtTheEnd |
	
	stringWithoutAnSAtTheEnd _ self amount asString , ' ' , self unit printString.
	(amount = 1) ifFalse: [stringWithoutAnSAtTheEnd _ stringWithoutAnSAtTheEnd , 's'].
	
	^ stringWithoutAnSAtTheEnd ! !

!Measure methodsFor: 'arithmetic' stamp: 'JG 6/6/2017 01:05:22'!
timesAmount: anAmount

	^ Measure withAmount: (amount * anAmount) withUnit: unit! !

!Measure methodsFor: 'arithmetic' stamp: 'AM 6/6/2017 18:50:23'!
timesMeasure: aMeasure

	^ Measure withAmount: amount * aMeasure amount withUnit: (unit * aMeasure unit)! !


!Measure methodsFor: 'comparing' stamp: 'AM 6/5/2017 15:54:44'!
< aDistance 

	^ self absoluteAmount < (aDistance absoluteAmount)! !

!Measure methodsFor: 'comparing' stamp: 'JG 6/7/2017 11:39:00'!
= aMeasure

	^ ( (aMeasure isKindOf: self class)
		and: [(unit isCompatibleWith: aMeasure unit) or: [amount = 0 and: [aMeasure amount = 0] ]]
		and: [self absoluteAmount  = (aMeasure absoluteAmount)] )
	or: [ (aMeasure isKindOf: CompoundMeasure) and: [ aMeasure = self ] ]! !

!Measure methodsFor: 'comparing' stamp: 'JG 6/5/2017 19:57:19'!
hash

	^ self absoluteAmount hash! !

!Measure methodsFor: 'comparing' stamp: 'AM 6/6/2017 20:02:29'!
isCompatibleWith: anotherMeasure

	^ unit isCompatibleWith: anotherMeasure unit! !


!Measure methodsFor: 'converting' stamp: 'AM 5/25/2017 15:31:19'!
adaptToNumber: aSmallInteger andSend: aSymbol 
	
	^ self perform: aSymbol with: aSmallInteger
! !

!Measure methodsFor: 'converting' stamp: 'AM 6/6/2017 18:06:29'!
convertTo: aUnit

	^ (unit isCompatibleWith: aUnit) 
		ifTrue: [ Measure withAmount: ( self absoluteAmount + aUnit amountToUnitCorrection / aUnit unitMultiplier  ) withUnit: aUnit ]
		ifFalse: [ self error: Unit incompatibleUnitsErrorDescription]! !

!Measure methodsFor: 'converting' stamp: 'JG 5/27/2017 21:25:16'!
to: aDistance 
	
	^ DistanceInterval from: self to: aDistance ! !

!Measure methodsFor: 'converting' stamp: 'JG 5/30/2017 14:01:03'!
to: stopDistance by: stepDistance 
	
	^ DistanceInterval from: self to: stopDistance by: stepDistance ! !


!Measure methodsFor: 'accessing' stamp: 'AM 6/5/2017 16:00:45'!
absoluteAmount

	^ (amount + self amountToUnitCorrection) * self unitMultiplier! !

!Measure methodsFor: 'accessing' stamp: 'AM 6/7/2017 14:34:42'!
amount

	^ amount! !

!Measure methodsFor: 'accessing' stamp: 'AM 6/5/2017 16:01:04'!
amountToUnitCorrection
	^ unit amountToUnitCorrection! !

!Measure methodsFor: 'accessing' stamp: 'AM 6/7/2017 14:34:47'!
isZero 

	^ amount = 0! !

!Measure methodsFor: 'accessing' stamp: 'AM 6/6/2017 20:01:30'!
measures

	^ (CompoundMeasure with: self) measures! !

!Measure methodsFor: 'accessing' stamp: 'JG 6/4/2017 19:36:29'!
unit

	^ unit! !

!Measure methodsFor: 'accessing' stamp: 'AM 6/5/2017 15:25:47'!
unitMultiplier

	^ unit unitMultiplier! !

!Measure methodsFor: 'accessing' stamp: 'JG 6/6/2017 01:15:52'!
unitType

	^ unit type! !


!Measure methodsFor: 'initialization' stamp: 'JG 6/4/2017 18:36:01'!
initializeWithAmount: anAmount withUnit: aUnit
	
	amount _ anAmount.
	unit _ aUnit.
	
	^ self! !

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


!DistanceInterval methodsFor: 'accessing' stamp: 'JG 6/4/2017 23:25:21'!
by

	^ step! !

!DistanceInterval methodsFor: 'accessing' stamp: 'JG 6/4/2017 23:24:41'!
from

	^ start! !

!DistanceInterval methodsFor: 'accessing' stamp: 'JG 5/27/2017 21:52:34'!
start

	^ start! !

!DistanceInterval methodsFor: 'accessing' stamp: 'JG 5/28/2017 00:33:28'!
step

	^ step! !

!DistanceInterval methodsFor: 'accessing' stamp: 'JG 5/27/2017 21:52:08'!
stop

	^ stop! !

!DistanceInterval methodsFor: 'accessing' stamp: 'JG 6/4/2017 23:25:08'!
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


!classDefinition: #TestMeasures category: #'Measure-Solution'!
TestCase subclass: #TestMeasures
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!TestMeasures methodsFor: 'Testing' stamp: 'JG 6/5/2017 20:17:30'!
test01AddingGramsAndKilograms

	| oneHundredGrams oneKilogram elevenHundredGrams |
	
	oneKilogram _ MeasureFactory new oneKilogram.
	oneHundredGrams _ Measure withAmount: 100 withUnit: (MeasureFactory new gram).
	elevenHundredGrams _ Measure withAmount: 1100 withUnit: (MeasureFactory new gram).
	
	self assert: oneKilogram + oneHundredGrams equals: elevenHundredGrams.
	self assert: oneHundredGrams + oneKilogram equals: elevenHundredGrams.	
	! !

!TestMeasures methodsFor: 'Testing' stamp: 'JG 6/5/2017 20:28:11'!
test02SubstractingCentavosFromPesos

	| tenPesos fiveCentavos ninePesosAndNinetyfiveCentavos |
	
	tenPesos _ Measure withAmount: 10 withUnit: (MeasureFactory new peso).
	fiveCentavos _ Measure withAmount: 5 withUnit: (MeasureFactory new centavo).
	ninePesosAndNinetyfiveCentavos _ Measure withAmount: 995 withUnit: (MeasureFactory new centavo).
	
	self assert: tenPesos - fiveCentavos equals: ninePesosAndNinetyfiveCentavos.

	! !

!TestMeasures methodsFor: 'Testing' stamp: 'JG 6/5/2017 20:33:05'!
test03MultiplyingDollarsByANumber

	| fiftyDollars fiveHundredDollars |
	
	fiftyDollars _ Measure withAmount: 50 withUnit: (MeasureFactory new dollar).
	fiveHundredDollars _ Measure withAmount: 500 withUnit: (MeasureFactory new dollar).
	
	self assert: fiftyDollars * 10 equals: fiveHundredDollars.

	! !

!TestMeasures methodsFor: 'Testing' stamp: 'JG 6/5/2017 20:35:38'!
test04DividingLitersByANumber

	| thirtyLiters threeLiters |
	
	thirtyLiters _ Measure withAmount: 30 withUnit: (MeasureFactory new liter).
	threeLiters _ Measure withAmount: 3 withUnit: (MeasureFactory new liter).
	
	self assert: thirtyLiters / 10 equals: threeLiters.

	! !

!TestMeasures methodsFor: 'Testing' stamp: 'JG 6/5/2017 20:42:35'!
test05AddingPesosAndDollarsDoesntResultInAnAmountOfPesosOrDollars

	| tenPesos fiftyDollars sixtyDollars sixtyPesos |
	
	tenPesos _ Measure withAmount: 10 withUnit: (MeasureFactory new peso).
	fiftyDollars _ Measure withAmount: 50 withUnit: (MeasureFactory new dollar).
	sixtyPesos _ Measure withAmount: 60 withUnit: (MeasureFactory new peso).
	sixtyDollars _ Measure withAmount: 60 withUnit: (MeasureFactory new dollar).
	
	self deny: tenPesos + fiftyDollars = sixtyPesos.
	self deny: tenPesos + fiftyDollars = sixtyDollars.
	! !

!TestMeasures methodsFor: 'Testing' stamp: 'JG 6/7/2017 11:41:02'!
test06AddingPesosAndDollarsResultsInACollectionWithPesosAndDollars

	| tenPesos fiftyDollars |
	
	tenPesos _ Measure withAmount: 10 withUnit: (MeasureFactory new peso).
	fiftyDollars _ Measure withAmount: 50 withUnit: (MeasureFactory new dollar).
	
	self assert: (tenPesos + fiftyDollars includes: tenPesos).
	self assert: (tenPesos + fiftyDollars includes: fiftyDollars).
	self assert: tenPesos + fiftyDollars equals: fiftyDollars + tenPesos.

	! !

!TestMeasures methodsFor: 'Testing' stamp: 'JG 6/5/2017 21:44:19'!
test07SubstractingLitersFromKilogramsResultsInACollectionWithLitersAndNegativeKilograms

	| oneKilogram thirtyLiters minusThirtyLiters |
	
	oneKilogram _ Measure withAmount: 1 withUnit: (MeasureFactory new kilogram).
	thirtyLiters _ Measure withAmount: 30 withUnit: (MeasureFactory new liter).
	minusThirtyLiters _ Measure withAmount: -30 withUnit: (MeasureFactory new liter).
	
	self assert: (oneKilogram - thirtyLiters includes: oneKilogram).
	self assert: (oneKilogram - thirtyLiters includes: minusThirtyLiters).
	self assert: oneKilogram + thirtyLiters equals: thirtyLiters + oneKilogram.

	! !

!TestMeasures methodsFor: 'Testing' stamp: 'JG 6/5/2017 21:59:17'!
test08ConvertingKilogramsToGrams

	| oneKilogram oneThousandGrams oneKilogramConvertedToGrams |
	
	oneKilogram _ MeasureFactory new oneKilogram.
	oneThousandGrams _ Measure withAmount: 1000 withUnit: (MeasureFactory new gram).
	
	
	oneKilogramConvertedToGrams _ (oneKilogram convertTo: (MeasureFactory new gram)).
	
	self assert: oneKilogramConvertedToGrams equals: oneThousandGrams.
	self assert: oneKilogramConvertedToGrams unit equals: (MeasureFactory new gram).	! !

!TestMeasures methodsFor: 'Testing' stamp: 'AM 6/6/2017 18:06:36'!
test09ConvertingPesosToMetersRaisesAnError

	| tenPesos |
	
	tenPesos _ Measure withAmount: 10 withUnit: (MeasureFactory new peso).
	
	self should: [ (tenPesos convertTo: (MeasureFactory new meter)) ] raise: Error description: Unit incompatibleUnitsErrorDescription.! !

!TestMeasures methodsFor: 'Testing' stamp: 'JG 6/5/2017 22:17:37'!
test10ComparingNonZeroAmountsOfPesosAndDollars

	| tenPesos tenDollars |
	
	tenPesos _ Measure withAmount: 10 withUnit: (MeasureFactory new peso).
	tenDollars _ Measure withAmount: 10 withUnit: (MeasureFactory new dollar).
	
	self deny: tenPesos = tenDollars.! !

!TestMeasures methodsFor: 'Testing' stamp: 'JG 6/5/2017 22:18:34'!
test11ComparingZeroPesosToZeroDollars

	| zeroPesos zeroDollars |
	
	zeroPesos _ Measure withAmount: 0 withUnit: (MeasureFactory new peso).
	zeroDollars _ Measure withAmount: 0 withUnit: (MeasureFactory new dollar).
	
	self assert: zeroPesos = zeroDollars.! !

!TestMeasures methodsFor: 'Testing' stamp: 'JG 6/5/2017 22:20:07'!
test12ComparingZeroKelvinsToZeroKilograms

	| zeroKelvins zeroKilograms |
	
	zeroKelvins _ Measure withAmount: 0 withUnit: (MeasureFactory new peso).
	zeroKilograms _ Measure withAmount: 0 withUnit: (MeasureFactory new kilogram).
	
	self assert: zeroKelvins = zeroKilograms.! !

!TestMeasures methodsFor: 'Testing' stamp: 'JG 6/5/2017 22:23:04'!
test13ComparingZeroTemperatures

	| zeroKelvins zeroCelsius zeroFahrenheits|
	
	zeroKelvins _ Measure withAmount: 0 withUnit: (MeasureFactory new kelvin).
	zeroCelsius _ Measure withAmount: 0 withUnit: (MeasureFactory new celsius).
	zeroFahrenheits _ Measure withAmount: 0 withUnit: (MeasureFactory new fahrenheit).
	
	self deny: zeroKelvins = zeroCelsius.
	self deny: zeroKelvins = zeroFahrenheits.
	self deny: zeroCelsius = zeroFahrenheits.! !

!TestMeasures methodsFor: 'Testing' stamp: 'AM 6/7/2017 15:58:24'!
test14aSpeedAcceleratedDuringSometimeIsADifferentSpeed

	|anInitialSpeed aFinalEstimatedSpeed anAcceleration aTime|
	
	anInitialSpeed _ MeasureFactory new tenMetersPerSecond.
	anAcceleration _ MeasureFactory new tenMetersPerSquaredSecond.
	aTime _ MeasureFactory new oneSecond.
	
	aFinalEstimatedSpeed _ MeasureFactory new tenMetersPerSecond *2.
	
	self assert: aFinalEstimatedSpeed = (MeasureFactory new finalSpeedStartingAt: anInitialSpeed 
																			accelerating: anAcceleration 
																			during: aTime).! !


!TestMeasures methodsFor: 'Testing temperatures' stamp: 'JG 6/5/2017 20:12:53'!
testTemp01AllCelsiusAreTheSame

	| unCelsius otroCelsius |
	
	unCelsius _ MeasureFactory new oneCelsius.
	otroCelsius _ MeasureFactory new oneCelsius.
	
	self assert: unCelsius = otroCelsius.! !

!TestMeasures methodsFor: 'Testing temperatures' stamp: 'JG 6/5/2017 20:13:05'!
testTemp02AllFahrenheitsAreTheSame

	| unFahrenheit otroFahrenheit |
	
	unFahrenheit _ MeasureFactory new oneFahrenheit.
	otroFahrenheit _ MeasureFactory new oneFahrenheit.
	
	self assert: unFahrenheit = otroFahrenheit.! !

!TestMeasures methodsFor: 'Testing temperatures' stamp: 'JG 6/5/2017 20:13:14'!
testTemp03AllKelvinsAreTheSame

	| unKelvin otroKelvin |
	
	unKelvin _ MeasureFactory new oneKelvin.
	otroKelvin _ MeasureFactory new oneKelvin.
	
	self assert: unKelvin = otroKelvin.! !


!TestMeasures methodsFor: 'Testing CompoundUnits' stamp: 'AM 6/7/2017 14:50:27'!
test01ADistanceDividedByATimeGivesASpeed

	|  oneSecond tenMeters tenMetersPerSecond newMeasure |
	
	oneSecond _ Measure withAmount: 1 withUnit: MeasureFactory new second.
	tenMeters _ Measure withAmount: 10 withUnit: MeasureFactory new meter.
	tenMetersPerSecond _ MeasureFactory new tenMetersPerSecond.
	
	newMeasure _ tenMeters / oneSecond.
	
	self assert: newMeasure equals: tenMetersPerSecond.! !

!TestMeasures methodsFor: 'Testing CompoundUnits' stamp: 'AM 6/7/2017 15:47:20'!
test02ASpeedMultipliedByATimeGivesADistance

	|  oneSecond tenMeters tenMetersPerSecond newMeasure |
	
	oneSecond _ Measure withAmount: 1 withUnit: MeasureFactory new second.
	tenMeters _ Measure withAmount: 10 withUnit: MeasureFactory new meter.
	tenMetersPerSecond _ MeasureFactory new tenMetersPerSecond.
	
	newMeasure _ tenMetersPerSecond * oneSecond.
	
	self assert: newMeasure equals: tenMeters.! !


!TestMeasures methodsFor: 'Testing CompoundMeasures' stamp: 'JG 6/7/2017 11:40:35'!
test01OneMeterPlusOneSecondGivesACompoundMeasureContainingOneMeterAndOneSecond

	| oneMeter oneSecond oneMeterPlusOneSecond |

	oneMeter _ MeasureFactory new oneMeter.
	oneSecond _ MeasureFactory new oneSecond.
	oneMeterPlusOneSecond _ (CompoundMeasure with: oneMeter) + MeasureFactory new oneSecond.

	self assert: oneMeterPlusOneSecond equals: oneMeter + oneSecond.! !

!TestMeasures methodsFor: 'Testing CompoundMeasures' stamp: 'JG 6/7/2017 11:32:23'!
test02TwoSecondsIsTheSameAsACompoundMeasureWithTwoSeconds

	| oneSecondPlusAnotherSecond oneSecond twoSeconds |

	oneSecond _ MeasureFactory new oneSecond.
	twoSeconds _ CompoundMeasure with: MeasureFactory new oneSecond * 2.
	
	oneSecondPlusAnotherSecond _ oneSecond + oneSecond.

	self assert: twoSeconds equals: oneSecondPlusAnotherSecond.
	self assert: oneSecondPlusAnotherSecond equals: twoSeconds.! !

!TestMeasures methodsFor: 'Testing CompoundMeasures' stamp: 'JG 6/7/2017 11:44:33'!
test03ACompoundMeasureWithOneMeterMinusOneMeterEqualsZero

	| oneMeter aCompoundMeasureWithOneMeterMinusOneMeter anotherMeter |

	oneMeter _ MeasureFactory new oneMeter.
	anotherMeter _ MeasureFactory new oneMeter.
	
	aCompoundMeasureWithOneMeterMinusOneMeter _ oneMeter - anotherMeter.
	
	self assert: aCompoundMeasureWithOneMeterMinusOneMeter equals: MeasureFactory new zeroMeters.! !

!TestMeasures methodsFor: 'Testing CompoundMeasures' stamp: 'JG 6/7/2017 11:20:03'!
test04OneMeterPlusOneSecondMinusOneSecondGivesOneMeter

	| oneMeter oneSecond anotherMeter aMeterPlusASecondMinusASecond |

	oneMeter _ MeasureFactory new oneMeter.
	anotherMeter _ MeasureFactory new oneMeter.
	oneSecond _ MeasureFactory new oneSecond.

	aMeterPlusASecondMinusASecond _ oneMeter + oneSecond - oneSecond.

	self assert: aMeterPlusASecondMinusASecond equals: anotherMeter.! !


!classDefinition: #CompoundMeasure category: #'Measure-Solution'!
Object subclass: #CompoundMeasure
	instanceVariableNames: 'measures'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'JG 6/7/2017 11:29:04'!
add: anotherMeasure

	| firstCompatibleMeasure newValueForCompatibleMeasure newCompoundMeasure allMeasuresButFirstCompatibleMeasure |
	
	firstCompatibleMeasure _ measures 
		detect: [ :aMeasure | aMeasure isCompatibleWith: anotherMeasure ] 
		ifNone: [ ^ (CompoundMeasure with: anotherMeasure) addAll: measures].
	
	newCompoundMeasure _ CompoundMeasure new.
	
	newValueForCompatibleMeasure _ firstCompatibleMeasure + anotherMeasure.
	newValueForCompatibleMeasure absoluteAmount isZero 
		ifFalse: [ newCompoundMeasure _ CompoundMeasure with: (firstCompatibleMeasure + anotherMeasure) ].
	
	allMeasuresButFirstCompatibleMeasure _ measures.
	allMeasuresButFirstCompatibleMeasure remove: firstCompatibleMeasure.
	
	newCompoundMeasure addAll: allMeasuresButFirstCompatibleMeasure.
	
	^ newCompoundMeasure 
	
	! !

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 19:53:17'!
addAll: aCollectionOfMeasures

	measures addAll: aCollectionOfMeasures.
	
	^ self! !

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'JG 6/7/2017 11:43:02'!
includes: aMeasure

	^ measures includes: aMeasure! !


!CompoundMeasure methodsFor: 'arithmetic' stamp: 'AM 6/6/2017 20:41:11'!
* anInteger

	| newMeasure |
	
	newMeasure _ CompoundMeasure new. 
	measures do: [:aMeasure | newMeasure + (aMeasure * anInteger)].
		
	^ newMeasure! !

!CompoundMeasure methodsFor: 'arithmetic' stamp: 'JG 6/7/2017 11:24:22'!
+ anotherMeasure

	| newMeasure |
	
	newMeasure _ CompoundMeasure withAll: measures.
	anotherMeasure measures do: [ :aMeasure | newMeasure _ newMeasure add: aMeasure ].
	
	^ newMeasure! !

!CompoundMeasure methodsFor: 'arithmetic' stamp: 'JG 6/7/2017 11:20:53'!
- anotherMeasure

	| newMeasure |
	
	newMeasure _ self + (anotherMeasure * -1).
		
	^ newMeasure! !


!CompoundMeasure methodsFor: 'comparing' stamp: 'AM 6/6/2017 20:07:45'!
= anotherMeasure

	^ measures = anotherMeasure measures
! !


!CompoundMeasure methodsFor: 'accessing' stamp: 'AM 6/6/2017 19:47:21'!
measures

	^ measures! !


!CompoundMeasure methodsFor: 'initialization' stamp: 'AM 6/6/2017 20:41:32'!
initialize

	measures _ Bag new.
	
	^ self! !

!CompoundMeasure methodsFor: 'initialization' stamp: 'AM 6/6/2017 19:56:35'!
initializeWith: aCollectionOfMeasures

	measures _ aCollectionOfMeasures.
	
	^ self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompoundMeasure class' category: #'Measure-Solution'!
CompoundMeasure class
	instanceVariableNames: ''!

!CompoundMeasure class methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 19:56:23'!
with: aMeasure

	^ self new initializeWith: (Bag with: aMeasure)! !

!CompoundMeasure class methodsFor: 'as yet unclassified' stamp: 'AM 6/6/2017 19:56:02'!
withAll: aCollectionOfMeasures

	^ self new initializeWith: aCollectionOfMeasures! !


!classDefinition: #CompoundUnit category: #'Measure-Solution'!
Object subclass: #CompoundUnit
	instanceVariableNames: 'units'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/7/2017 13:02:28'!
* anotherUnit

	| newUnit |
	
	newUnit _ CompoundUnit withAll: units.
	anotherUnit units keys do: [ :aUnit | newUnit _ newUnit multiplyBy: aUnit ].
	
	^ newUnit! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/7/2017 12:40:14'!
/ anotherUnit

	^ self * anotherUnit reversed! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/7/2017 12:39:00'!
add: aUnit withDegree: aDegree

	units at: aUnit put: aDegree.
	
	^ self! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'AM 6/7/2017 15:45:06'!
amountToUnitCorrection

	^ 0! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'AM 6/7/2017 15:35:17'!
degreeOf: aUnit

	^ units at: aUnit ifAbsent: [0].
! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/7/2017 12:42:40'!
initialize

	units _ Dictionary new.
	
	^ self! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/7/2017 12:53:22'!
initializeWith: aCollectionOfUnits

	units _ aCollectionOfUnits.
	
	^ self! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'AM 6/7/2017 15:40:29'!
isCompatibleWith: anotherUnit

	^units = anotherUnit units

"
	| anotherUnitAsocs |
	
	anotherUnitAsocs _ anotherUnit units. 

	anotherUnitAsocs associationsDo: [:anAsoc | (anAsoc value = (self degreeOf: anAsoc key)) ifFalse: [^false]].
	
	^true
"! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'AM 6/7/2017 16:29:00'!
isOfTheSameTypeAs: anotherUnit

	^self isCompatibleWith: anotherUnit! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/7/2017 13:04:05'!
multiplyBy: anotherCompoundUnit

	| newUnit |
	
	newUnit _ CompoundUnit withAll: self units.

	anotherCompoundUnit units keys do: [ :aUnit | newUnit _ newUnit multiplyByUnit: aUnit withDegree: (anotherCompoundUnit degreeOf: aUnit) ].
	
	^ newUnit
! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'AM 6/7/2017 16:12:33'!
multiplyByUnit: anotherUnit withDegree: aDegree

	units detect: [ :aUnit | aUnit = anotherUnit ]
		ifFound: [ :compatibleUnit |  self remove: compatibleUnit.
										self add: compatibleUnit withDegree: (self degreeOf: compatibleUnit) + aDegree. ]
		ifNone: [ self add: anotherUnit withDegree: aDegree ].
	
	^ self! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/7/2017 12:50:41'!
reversed
	
	| newCompoundUnit |

	newCompoundUnit _ CompoundUnit new.
	units do: [ :aUnit | newCompoundUnit add: aUnit withDegree: (self degreeOf: aUnit) * -1 ].
	
	^ newCompoundUnit 
	
	! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/7/2017 12:55:55'!
timesUnit: anotherUnit

	| newUnit |
	
	newUnit _ CompoundUnit withAll: units.
	anotherUnit units do: [ :aUnit | newUnit _ newUnit multiplyBy: aUnit ].
	
	^ newUnit! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'AM 6/7/2017 15:45:51'!
unitMultiplier

	^1! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/7/2017 12:00:55'!
units

	^ units! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompoundUnit class' category: #'Measure-Solution'!
CompoundUnit class
	instanceVariableNames: ''!

!CompoundUnit class methodsFor: 'as yet unclassified' stamp: 'JG 6/7/2017 12:53:08'!
withAll: aCollectionOfUnits

	^ self new initializeWith: aCollectionOfUnits ! !


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureFactory methodsFor: 'Distance Units' stamp: 'AM 6/6/2017 18:07:26'!
centimeter

	^ Unit withUnitMultiplier: 1/100 withLabel: 'centimeter' ofType: 'distance'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'AM 6/6/2017 18:07:38'!
decameter

	^ Unit withUnitMultiplier: 10 withLabel: 'decameter'  ofType: 'distance'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'AM 6/6/2017 18:08:01'!
decimeter

	^ Unit withUnitMultiplier: 1/10 withLabel: 'decimeter' ofType: 'distance'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'AM 6/6/2017 18:07:57'!
hectometer

	^ Unit withUnitMultiplier: 100 withLabel: 'hectometer' ofType: 'distance'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'AM 6/6/2017 18:07:41'!
kilometer
	
	^ Unit withUnitMultiplier: 1000 withLabel: 'kilometer' ofType: 'distance'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'AM 6/6/2017 18:07:30'!
meter
	
	^ Unit withUnitMultiplier: 1 withLabel: 'meter' ofType: 'distance'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'AM 6/6/2017 18:06:53'!
milimeter

	^ Unit withUnitMultiplier: 1/1000 withLabel: 'milimeter' ofType: 'distance'! !

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


!MeasureFactory methodsFor: 'Temperature Units' stamp: 'AM 6/6/2017 18:27:10'!
celsius

	^ Unit withUnitMultiplier: 1 withAmountToUnitCorrection: 273 withLabel: 'celsius' ofType: 'temperature'! !

!MeasureFactory methodsFor: 'Temperature Units' stamp: 'AM 6/6/2017 18:26:59'!
fahrenheit

	^ Unit withUnitMultiplier: 5/9 withAmountToUnitCorrection: 460 withLabel: 'fahrenheit' ofType: 'temperature'! !

!MeasureFactory methodsFor: 'Temperature Units' stamp: 'AM 6/6/2017 18:07:50'!
kelvin

	^ Unit withUnitMultiplier: 1  withLabel: 'kelvin' ofType: 'temperature'! !


!MeasureFactory methodsFor: 'Weight Measures' stamp: 'JG 6/5/2017 20:07:17'!
oneKilogram

	^ Measure withAmount: 1 withUnit: self kilogram! !


!MeasureFactory methodsFor: 'Weight Units' stamp: 'AM 6/6/2017 18:07:11'!
gram

	^ Unit withUnitMultiplier: 1 withLabel: 'gram' ofType: 'weight'! !

!MeasureFactory methodsFor: 'Weight Units' stamp: 'AM 6/6/2017 18:07:34'!
kilogram

	^ Unit withUnitMultiplier: 1000 withLabel: 'kilogram' ofType: 'weight'! !


!MeasureFactory methodsFor: 'Currency Units' stamp: 'AM 6/6/2017 18:07:16'!
centavo
	
	^ Unit withUnitMultiplier: 1 withLabel: 'centavo' ofType: 'argentinian currency'! !

!MeasureFactory methodsFor: 'Currency Units' stamp: 'AM 6/6/2017 18:08:05'!
dollar
	
	^ Unit withUnitMultiplier: 100 withLabel: 'dollar' ofType: 'american currency'! !

!MeasureFactory methodsFor: 'Currency Units' stamp: 'AM 6/6/2017 18:06:48'!
peso
	
	^ Unit withUnitMultiplier: 100 withLabel: 'peso' ofType: 'argentinian currency'! !


!MeasureFactory methodsFor: 'Volume Units' stamp: 'AM 6/6/2017 18:07:07'!
liter

	^ Unit withUnitMultiplier: 1 withLabel: 'liter' ofType: 'volume'! !


!MeasureFactory methodsFor: 'Speed Units' stamp: 'JG 6/7/2017 11:51:43'!
metersPerSecond

	^ self meter / self second! !


!MeasureFactory methodsFor: 'Area Units' stamp: 'JG 6/7/2017 12:44:56'!
squaredMeter

	^ CompoundUnit new add: self meter withDegree: 2! !


!MeasureFactory methodsFor: 'Acceleration Units' stamp: 'JG 6/7/2017 12:44:41'!
metersPerSquaredSecond

	^ (CompoundUnit new) add: self meter withDegree: 1; add: self second withDegree: -2! !

!MeasureFactory methodsFor: 'Acceleration Units' stamp: 'AM 6/7/2017 15:52:51'!
tenMetersPerSquaredSecond

	^ Measure withAmount: 10 withUnit: self metersPerSquaredSecond! !


!MeasureFactory methodsFor: 'Speed Measures' stamp: 'JG 6/7/2017 12:57:25'!
tenMetersPerSecond

	^ Measure withAmount: 10 withUnit: self metersPerSecond ! !


!MeasureFactory methodsFor: 'Time Units' stamp: 'AM 6/6/2017 18:07:53'!
second

	^ Unit withUnitMultiplier: 1 withLabel: 'second' ofType: 'time'! !


!MeasureFactory methodsFor: 'Time Measure' stamp: 'AM 6/6/2017 18:34:28'!
oneSecond
	^ Measure withAmount: 1 withUnit: self second.! !


!MeasureFactory methodsFor: 'random physics formulas' stamp: 'AM 6/7/2017 16:01:40'!
finalSpeedStartingAt: startSpeed accelerating: anAcceleration during: aTime

    ^ startSpeed + (anAcceleration * aTime) ! !


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'unitMultiplier amountToUnitCorrection label type'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/7/2017 14:33:30'!
degreeOf: aUnit
	
	^ (aUnit = self)
		ifTrue: [ 1 ]! !

!Unit methodsFor: 'as yet unclassified' stamp: 'JG 6/5/2017 20:51:33'!
initializeWith: aUnitMultiplier withAmountToUnitCorrection: anAmountToUnitCorrection withLabel: aLabel withType: aUnitType

	unitMultiplier _ aUnitMultiplier.
	amountToUnitCorrection _ anAmountToUnitCorrection.
	label _ aLabel.
	type _ aUnitType.
		
	^ self! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/7/2017 16:30:33'!
isCompatibleWith: anotherUnit
	^ self isOfTheSameTypeAs: anotherUnit
				! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/7/2017 16:00:37'!
isOfTheSameTypeAs: anotherUnit

	^ type = anotherUnit type! !

!Unit methodsFor: 'as yet unclassified' stamp: 'AM 6/5/2017 14:54:10'!
printString

	^ label! !

!Unit methodsFor: 'as yet unclassified' stamp: 'JG 6/7/2017 12:48:56'!
reversed

	^ CompoundUnit new add: self withDegree: -1! !

!Unit methodsFor: 'as yet unclassified' stamp: 'JG 6/7/2017 12:54:11'!
units

	^ (CompoundUnit new add: self withDegree: 1) units! !


!Unit methodsFor: 'accessing' stamp: 'AM 6/5/2017 16:04:50'!
amountToUnitCorrection

	^ amountToUnitCorrection! !

!Unit methodsFor: 'accessing' stamp: 'JG 6/6/2017 00:59:21'!
label

	^ label! !

!Unit methodsFor: 'accessing' stamp: 'AM 6/5/2017 15:22:41'!
unitMultiplier

	^ unitMultiplier! !


!Unit methodsFor: 'arithmetic' stamp: 'AM 6/7/2017 16:06:03'!
* anotherUnitOrCompoundUnit

	^ (anotherUnitOrCompoundUnit isKindOf: CompoundUnit)
		ifTrue: [ anotherUnitOrCompoundUnit * self ]
		ifFalse: [ (CompoundUnit new) add: self withDegree: 1; add: anotherUnitOrCompoundUnit withDegree: 1]! !

!Unit methodsFor: 'arithmetic' stamp: 'JG 6/7/2017 12:48:17'!
/ anotherUnit

	^ self * anotherUnit reversed! !

!Unit methodsFor: 'arithmetic' stamp: 'JG 6/5/2017 21:04:14'!
type

	^  type! !


!Unit methodsFor: 'comparing' stamp: 'AM 6/5/2017 15:06:06'!
= anotherLabeledUnit

	^ (anotherLabeledUnit isKindOf: self class) 
		and: [ unitMultiplier = anotherLabeledUnit unitMultiplier]! !

!Unit methodsFor: 'comparing' stamp: 'AM 6/7/2017 15:39:13'!
hash 

	^ type hash! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Measure-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'error description' stamp: 'JG 6/5/2017 22:05:41'!
incompatibleUnitsErrorDescription

	^ 'The units are not compatible'! !


!Unit class methodsFor: 'as yet unclassified' stamp: 'JG 6/5/2017 20:51:06'!
withUnitMultiplier: aUnitMultiplier withAmountToUnitCorrection: anAmountToUnitCorrection withLabel: aLabel ofType: aUnitType 


	^ self new initializeWith: aUnitMultiplier withAmountToUnitCorrection: anAmountToUnitCorrection withLabel: aLabel withType: aUnitType.	! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'JG 6/5/2017 20:55:02'!
withUnitMultiplier: aUnitMultiplier withLabel: aLabel ofType: aUnitType

	^ self new initializeWith: aUnitMultiplier withAmountToUnitCorrection: 0 withLabel: aLabel withType: aUnitType.
	
! !
