!classDefinition: #AddInstVarTest category: #Metaprogramacion!
TestCase subclass: #AddInstVarTest
	instanceVariableNames: 'anAwesomeClass anAwesomeSubclass anInstanceVariableNameForAnAwesomeClass anInstanceVariableNameForAnAwesomeSubclass anAwesomeLocalVariableName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Metaprogramacion'!

!AddInstVarTest methodsFor: 'Testing' stamp: 'JG 6/29/2017 20:50:17'!
test01AddInstVariableFailsToInstantiateIfNewVariableNameIsEmpty

	self
		should: [ AddInstVariable named: '' in: anAwesomeClass ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: AddInstVariable invalidVariableNameErrorDescription ]
	! !

!AddInstVarTest methodsFor: 'Testing' stamp: 'JG 6/29/2017 20:52:10'!
test02AddInstVariableFailsToInstantiateIfNewVariableNameStartsWithABlank

	self
		should: [ AddInstVariable named: ' variableName' in: anAwesomeClass ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: AddInstVariable invalidVariableNameErrorDescription ]
	! !

!AddInstVarTest methodsFor: 'Testing' stamp: 'JG 6/29/2017 20:52:15'!
test03AddInstVariableFailsToInstantiateIfNewVariableNameEndsWithABlank

	self
		should: [ AddInstVariable named: 'variableName ' in: anAwesomeClass ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: AddInstVariable invalidVariableNameErrorDescription ]
	! !

!AddInstVarTest methodsFor: 'Testing' stamp: 'JG 6/29/2017 20:52:21'!
test04AddInstVariableFailsToInstantiateIfNewVariableNameContainsBlanks

	self
		should: [ AddInstVariable named: 'variable Name' in: anAwesomeClass ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: AddInstVariable invalidVariableNameErrorDescription ]
	! !

!AddInstVarTest methodsFor: 'Testing' stamp: 'JG 6/29/2017 20:52:25'!
test05AddInstVariableFailsToInstantiateIfNewVariableNameContainsNonASCIICharacters

	self
		should: [ AddInstVariable named: 'variable/Name' in: anAwesomeClass ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: AddInstVariable invalidVariableNameErrorDescription ]
	! !

!AddInstVarTest methodsFor: 'Testing' stamp: 'JG 6/29/2017 20:52:32'!
test06AddInstVariableFailsToInstantiateIfNewVariableNameStartsWithADigit

	self
		should: [ AddInstVariable named: '1variableName' in: anAwesomeClass ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: AddInstVariable invalidVariableNameErrorDescription ]
	! !

!AddInstVarTest methodsFor: 'Testing' stamp: 'JG 6/29/2017 20:59:46'!
test07AddInstVariableFailsToInstantiateIfVariableNameAlreadyExistsInTheTargetClass

	self
		should: [ AddInstVariable named: anInstanceVariableNameForAnAwesomeClass in: anAwesomeClass ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: AddInstVariable invalidVariableNameErrorDescription ]
	! !

!AddInstVarTest methodsFor: 'Testing' stamp: 'JG 6/29/2017 21:00:26'!
test08AddInstVariableFailsToInstantiateIfVariableNameAlreadyExistsInASuperclass

	self
		should: [ AddInstVariable named: anInstanceVariableNameForAnAwesomeClass in: anAwesomeSubclass ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: AddInstVariable invalidVariableNameErrorDescription ]
	! !

!AddInstVarTest methodsFor: 'Testing' stamp: 'JG 6/29/2017 21:00:57'!
test09AddInstVariableFailsToInstantiateIfVariableNameAlreadyExistsInASubclass

	self
		should: [ AddInstVariable named: anInstanceVariableNameForAnAwesomeSubclass in: anAwesomeClass ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: AddInstVariable invalidVariableNameErrorDescription ]
	! !

!AddInstVarTest methodsFor: 'Testing' stamp: 'JG 6/29/2017 21:26:24'!
test10AddInstVariableGivesAWarningIfVariableNameAlreadyExistsAsALocalVariable

	self
		should: [ AddInstVariable named: anAwesomeLocalVariableName in: anAwesomeClass ]
		raise: Warning
		withExceptionDo: [ :aWarning |
			self assert: aWarning messageText equals: AddInstVariable invalidVariableNameWarningDescription ]
	! !


!AddInstVarTest methodsFor: 'set up & tear down' stamp: 'JG 6/29/2017 21:21:02'!
setUp

	| aClassName aSubclassName |
	
	aClassName _ 'AwesomeClass'.
	aSubclassName _ 'AwesomeSubclass'.

	anInstanceVariableNameForAnAwesomeClass _ 'anAwesomeInstanceVariable'.
	anInstanceVariableNameForAnAwesomeSubclass _ 'anotherAwesomeInstanceVariable'.
	
	anAwesomeClass _ Object subclass: aClassName
		instanceVariableNames: anInstanceVariableNameForAnAwesomeClass 
		classVariableNames: ''
		poolDictionaries: ''
		category: 'Metaprogramacion'.

	anAwesomeLocalVariableName _ 'awesomeLocalVariable'.
	anAwesomeClass compile: 'awesomeMethod |',  anAwesomeLocalVariableName,  '| ^ self'.
		
	anAwesomeSubclass _ anAwesomeClass subclass: aSubclassName
		instanceVariableNames: anInstanceVariableNameForAnAwesomeSubclass
		classVariableNames: ''
		poolDictionaries: ''
		category: 'Metaprogramacion'.
	! !

!AddInstVarTest methodsFor: 'set up & tear down' stamp: 'JG 6/29/2017 21:21:27'!
tearDown

	anAwesomeClass removeFromSystem.
	anAwesomeSubclass removeFromSystem.! !


!classDefinition: #AddInstVariable category: #Metaprogramacion!
Object subclass: #AddInstVariable
	instanceVariableNames: 'variableName class'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Metaprogramacion'!

!AddInstVariable methodsFor: 'as yet unclassified' stamp: 'JG 6/29/2017 19:36:14'!
apply! !


!AddInstVariable methodsFor: 'initialization' stamp: 'JG 6/29/2017 20:28:30'!
initializeWithVariableName: newVariableName andClassToRefactor: aClassToRefactor

	variableName _ newVariableName.
	class _ aClassToRefactor.
	
	^ self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AddInstVariable class' category: #Metaprogramacion!
AddInstVariable class
	instanceVariableNames: ''!

!AddInstVariable class methodsFor: 'as yet unclassified' stamp: 'JG 6/29/2017 19:53:09'!
invalidVariableNameErrorDescription

	^ 'The given name for the variable is invalid'! !

!AddInstVariable class methodsFor: 'as yet unclassified' stamp: 'JG 6/29/2017 21:14:33'!
named: newVariableName in: aClassToRefactor

	newVariableName isEmpty 
		ifTrue: [ self error: AddInstVariable invalidVariableNameErrorDescription ]
		ifFalse: [ | newVariableNameFields | 
			newVariableNameFields _ Scanner new scanFieldNames: newVariableName.
			newVariableNameFields first = newVariableName
				ifFalse: [ self error: AddInstVariable invalidVariableNameErrorDescription ]
				ifTrue: [ | allInstVarNamesIncludingSubclasses |
					allInstVarNamesIncludingSubclasses _ aClassToRefactor allInstVarNames asSet.
					aClassToRefactor subclasses asSet do: [ :aSubclass |
						allInstVarNamesIncludingSubclasses addAll: aSubclass instVarNames
						].
					(allInstVarNamesIncludingSubclasses includes: newVariableName)
						ifTrue: [ self error: AddInstVariable invalidVariableNameErrorDescription ]
					]
			].
	
	^ self new initializeWithVariableName: newVariableName andClassToRefactor: aClassToRefactor.! !
