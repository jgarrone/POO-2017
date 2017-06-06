
!classDefinition: #Measure category: #'Measure-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'arithmetic' stamp: 'JG 6/6/2017 01:06:25'!
* anAmountOrAMeasure

	^ (anAmountOrAMeasure isKindOf: self class) 
		ifTrue: [ self timesMeasure: anAmountOrAMeasure ]
		ifFalse: [ self timesAmount: anAmountOrAMeasure ]! !

!Measure methodsFor: 'arithmetic' stamp: 'JG 6/5/2017 21:40:07'!
+ aMeasure 
	
	^ (unit isOfTheSameTypeAs: aMeasure unit) 
		ifTrue: [ Measure withAmount: ((self absoluteAmount + aMeasure absoluteAmount) / unit unitMultiplier) withUnit: unit ]
		ifFalse: [ Measures new add: self; add: aMeasure; value]! !

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

!Measure methodsFor: 'arithmetic' stamp: 'JG 6/6/2017 01:05:22'!
timesAmount: anAmount

	^ Measure withAmount: (amount * anAmount) withUnit: unit! !

!Measure methodsFor: 'arithmetic' stamp: 'JG 6/6/2017 01:15:22'!
timesMeasure: aMeasure

	^ Measure withAmount: amount * aMeasure amount withUnit: (CompoundUnit with: unit and: aMeasure unit withConnection: #* ofType: (unit type , ' times ' , aMeasure unitType))! !


!Measure methodsFor: 'comparing' stamp: 'AM 6/5/2017 15:54:44'!
< aDistance 

	^ self absoluteAmount < (aDistance absoluteAmount)! !

!Measure methodsFor: 'comparing' stamp: 'JG 6/5/2017 22:15:27'!
= aMeasure
	
	^ (aMeasure isKindOf: self class)
		and: [(unit isCompatibleWith: aMeasure unit) or: [amount = 0 and: [aMeasure amount = 0] ]]
		and: [self absoluteAmount  = (aMeasure absoluteAmount)]! !

!Measure methodsFor: 'comparing' stamp: 'JG 6/5/2017 19:57:19'!
hash

	^ self absoluteAmount hash! !


!Measure methodsFor: 'converting' stamp: 'AM 5/25/2017 15:31:19'!
adaptToNumber: aSmallInteger andSend: aSymbol 
	
	^ self perform: aSymbol with: aSmallInteger
! !

!Measure methodsFor: 'converting' stamp: 'JG 6/5/2017 21:51:51'!
convertTo: aUnit

	^ (unit isCompatibleWith: aUnit) 
		ifTrue: [ Measure withAmount: ( amount * ( unit unitMultiplier / aUnit unitMultiplier ) ) withUnit: aUnit ]
		ifFalse: [ self error: LabeledUnit incompatibleUnitsErrorDescription]! !

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


!classDefinition: #Measures category: #'Measure-Solution'!
Bag subclass: #Measures
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!


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

!TestMeasures methodsFor: 'Testing' stamp: 'JG 6/5/2017 21:34:43'!
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

!TestMeasures methodsFor: 'Testing' stamp: 'JG 6/5/2017 22:07:11'!
test09ConvertingPesosToMetersRaisesAnError

	| tenPesos |
	
	tenPesos _ Measure withAmount: 10 withUnit: (MeasureFactory new peso).
	
	self should: [ (tenPesos convertTo: (MeasureFactory new meter)) ] raise: Error description: LabeledUnit incompatibleUnitsErrorDescription.! !

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

!TestMeasures methodsFor: 'Testing temperatures' stamp: 'JG 6/5/2017 20:13:24'!
testTemp04AllKelvinsAreTheSame

	| unKelvin otroKelvin |
	
	unKelvin _ MeasureFactory new oneKelvin.
	otroKelvin _ MeasureFactory new oneKelvin.
	
	self assert: unKelvin = otroKelvin.! !


!TestMeasures methodsFor: 'Testing compounds' stamp: 'JG 6/6/2017 00:58:20'!
test01ASpeedMultipliedByATimeGivesADistance

	| tenMetersPerSecond oneSecond tenMeters |
	
	tenMetersPerSecond _ MeasureFactory new tenMetersPerSecond.
	oneSecond _ Measure withAmount: 1 withUnit: MeasureFactory new second.
	tenMeters _ Measure withAmount: 10 withUnit: MeasureFactory new meter.
	
	
	self assert: tenMetersPerSecond * oneSecond equals: tenMeters.! !


!classDefinition: #LabeledUnit category: #'Measure-Solution'!
Object subclass: #LabeledUnit
	instanceVariableNames: 'unitMultiplier amountToUnitCorrection label type'
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

!LabeledUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/5/2017 20:51:33'!
initializeWith: aUnitMultiplier withAmountToUnitCorrection: anAmountToUnitCorrection withLabel: aLabel withType: aUnitType

	unitMultiplier _ aUnitMultiplier.
	amountToUnitCorrection _ anAmountToUnitCorrection.
	label _ aLabel.
	type _ aUnitType.
		
	^ self! !

!LabeledUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/5/2017 21:52:23'!
isCompatibleWith: anotherUnit

	^ self isOfTheSameTypeAs: anotherUnit! !

!LabeledUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/5/2017 21:04:05'!
isOfTheSameTypeAs: anotherUnit

	^ type = anotherUnit type! !

!LabeledUnit methodsFor: 'as yet unclassified' stamp: 'AM 6/5/2017 14:54:10'!
printString

	^ label! !

!LabeledUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/5/2017 21:04:14'!
type

	^  type! !

!LabeledUnit methodsFor: 'as yet unclassified' stamp: 'AM 6/5/2017 15:22:41'!
unitMultiplier

	^ unitMultiplier! !


!LabeledUnit methodsFor: 'accessing' stamp: 'JG 6/6/2017 00:59:21'!
label

	^ label! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LabeledUnit class' category: #'Measure-Solution'!
LabeledUnit class
	instanceVariableNames: ''!

!LabeledUnit class methodsFor: 'error description' stamp: 'JG 6/5/2017 22:05:41'!
incompatibleUnitsErrorDescription

	^ 'The units are not compatible'! !


!LabeledUnit class methodsFor: 'as yet unclassified' stamp: 'JG 6/5/2017 20:51:06'!
withUnitMultiplier: aUnitMultiplier withAmountToUnitCorrection: anAmountToUnitCorrection withLabel: aLabel ofType: aUnitType 


	^ self new initializeWith: aUnitMultiplier withAmountToUnitCorrection: anAmountToUnitCorrection withLabel: aLabel withType: aUnitType.	! !

!LabeledUnit class methodsFor: 'as yet unclassified' stamp: 'JG 6/5/2017 20:55:02'!
withUnitMultiplier: aUnitMultiplier withLabel: aLabel ofType: aUnitType

	^ self new initializeWith: aUnitMultiplier withAmountToUnitCorrection: 0 withLabel: aLabel withType: aUnitType.
	
! !


!classDefinition: #CompoundUnit category: #'Measure-Solution'!
LabeledUnit subclass: #CompoundUnit
	instanceVariableNames: 'firstUnit secondUnit connection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'JG 6/6/2017 00:51:10'!
initializeWith: aUnit and: anotherUnit withConnection: aSelector withType: aUnitType

	firstUnit _ aUnit.
	secondUnit _ anotherUnit.
	connection _ aSelector.
	unitMultiplier _ aUnit unitMultiplier perform: aSelector with: anotherUnit unitMultiplier.
	label _ aUnit label , ' ' , anotherUnit label.
	amountToUnitCorrection _ 0.
	type _ aUnitType.
	
	^ self
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompoundUnit class' category: #'Measure-Solution'!
CompoundUnit class
	instanceVariableNames: ''!

!CompoundUnit class methodsFor: 'as yet unclassified' stamp: 'JG 6/6/2017 00:43:14'!
with: aUnit and: anotherUnit withConnection: aSelector ofType: aUnitType

	^ self new initializeWith: aUnit and: anotherUnit withConnection: aSelector withType: aUnitType

	! !

!CompoundUnit class methodsFor: 'as yet unclassified' stamp: 'JG 6/6/2017 00:44:53'!
with: aUnit per: anotherUnit ofType: aUnitType

	^ self with: aUnit and: anotherUnit withConnection: #/ ofType: aUnitType! !

!CompoundUnit class methodsFor: 'as yet unclassified' stamp: 'JG 6/6/2017 00:50:49'!
with: aUnit times: anotherUnit ofType: aUnitType

	^ self with: aUnit and: anotherUnit withConnection: #* ofType: aUnitType 

	! !


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureFactory methodsFor: 'Distance Units' stamp: 'JG 6/5/2017 21:05:30'!
centimeter

	^ LabeledUnit withUnitMultiplier: 1/100 withLabel: 'centimeter' ofType: 'distance'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'JG 6/5/2017 21:05:40'!
decameter

	^ LabeledUnit withUnitMultiplier: 10 withLabel: 'decameter'  ofType: 'distance'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'JG 6/5/2017 21:05:44'!
decimeter

	^ LabeledUnit withUnitMultiplier: 1/10 withLabel: 'decimeter' ofType: 'distance'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'JG 6/5/2017 21:06:20'!
hectometer

	^ LabeledUnit withUnitMultiplier: 100 withLabel: 'hectometer' ofType: 'distance'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'JG 6/5/2017 21:06:37'!
kilometer
	
	^ LabeledUnit withUnitMultiplier: 1000 withLabel: 'kilometer' ofType: 'distance'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'JG 6/5/2017 21:06:47'!
meter
	
	^ LabeledUnit withUnitMultiplier: 1 withLabel: 'meter' ofType: 'distance'! !

!MeasureFactory methodsFor: 'Distance Units' stamp: 'JG 6/5/2017 21:06:49'!
milimeter

	^ LabeledUnit withUnitMultiplier: 1/1000 withLabel: 'milimeter' ofType: 'distance'! !

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


!MeasureFactory methodsFor: 'Temperature Units' stamp: 'JG 6/5/2017 20:55:48'!
celsius

	^ LabeledUnit withUnitMultiplier: 1 withAmountToUnitCorrection: -273 withLabel: 'celsius' ofType: 'temperature'! !

!MeasureFactory methodsFor: 'Temperature Units' stamp: 'JG 6/5/2017 20:56:00'!
fahrenheit

	^ LabeledUnit withUnitMultiplier: 5/9 withAmountToUnitCorrection: -460 withLabel: 'fahrenheit' ofType: 'temperature'! !

!MeasureFactory methodsFor: 'Temperature Units' stamp: 'JG 6/5/2017 21:06:29'!
kelvin

	^ LabeledUnit withUnitMultiplier: 1  withLabel: 'kelvin' ofType: 'temperature'! !


!MeasureFactory methodsFor: 'Weight Measures' stamp: 'JG 6/5/2017 20:07:17'!
oneKilogram

	^ Measure withAmount: 1 withUnit: self kilogram! !


!MeasureFactory methodsFor: 'Weight Units' stamp: 'JG 6/5/2017 21:06:09'!
gram

	^ LabeledUnit withUnitMultiplier: 1 withLabel: 'gram' ofType: 'weight'! !

!MeasureFactory methodsFor: 'Weight Units' stamp: 'JG 6/5/2017 21:06:34'!
kilogram

	^ LabeledUnit withUnitMultiplier: 1000 withLabel: 'kilogram' ofType: 'weight'! !


!MeasureFactory methodsFor: 'Currency Units' stamp: 'JG 6/5/2017 21:05:02'!
centavo
	
	^ LabeledUnit withUnitMultiplier: 1 withLabel: 'centavo' ofType: 'argentinian currency'! !

!MeasureFactory methodsFor: 'Currency Units' stamp: 'JG 6/5/2017 21:06:00'!
dollar
	
	^ LabeledUnit withUnitMultiplier: 100 withLabel: 'dollar' ofType: 'american currency'! !

!MeasureFactory methodsFor: 'Currency Units' stamp: 'JG 6/5/2017 21:06:56'!
peso
	
	^ LabeledUnit withUnitMultiplier: 100 withLabel: 'peso' ofType: 'argentinian currency'! !


!MeasureFactory methodsFor: 'Volume Units' stamp: 'JG 6/5/2017 21:06:44'!
liter

	^ LabeledUnit withUnitMultiplier: 1 withLabel: 'liter' ofType: 'volume'! !


!MeasureFactory methodsFor: 'Speed Units' stamp: 'JG 6/6/2017 00:45:34'!
metersPerSecond

	^ CompoundUnit with: self meter per: self second ofType: 'speed'! !


!MeasureFactory methodsFor: 'Area Units' stamp: 'JG 6/5/2017 22:55:14'!
squaredMeter

	^ CompoundUnit with: self meter times: self meter! !


!MeasureFactory methodsFor: 'Acceleration Units' stamp: 'JG 6/6/2017 00:50:27'!
metersPerSquaredSecond

	^ CompoundUnit with: self meter per: (CompoundUnit with: self second times: self second ofType: 'squaredTime') ofType: 'acceleration'! !


!MeasureFactory methodsFor: 'Speed Measures' stamp: 'JG 6/6/2017 00:56:04'!
tenMetersPerSecond

	^ Measure withAmount: 10 withUnit: self metersPerSecond ! !


!MeasureFactory methodsFor: 'Time Units' stamp: 'JG 6/6/2017 00:56:47'!
second

	^ LabeledUnit withUnitMultiplier: 1 withLabel: 'second' ofType: 'time'! !
