!classDefinition: #ShoppingCart category: #'TusLibros-Solution'!
Bag subclass: #ShoppingCart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!ShoppingCart methodsFor: 'adding' stamp: 'JG 6/13/2017 14:25:04'!
add: newBook

	newBook ISBN isInteger 
		ifTrue: [ super add: newBook ]
		ifFalse: [ self error: Exception]
		! !

!ShoppingCart methodsFor: 'adding' stamp: 'JG 6/13/2017 14:32:16'!
add: newBook withOccurrences: anAmount

	(anAmount isInteger and: [ newBook ISBN isInteger ])
		ifTrue: [ super add: newBook withOccurrences: anAmount ]
		ifFalse: [ self error: Exception]
		! !


!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/9/2017 11:36:48'!
test01AShoppingCartsIsEmptyWhenCreated
	
	self assert: ShoppingCart new isEmpty.! !

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/13/2017 14:29:17'!
test02AShoppingCartStopsBeingEmptyWhenABookIsAdded
	
	| aShoppingCart |

	aShoppingCart _ ShoppingCart new.
	aShoppingCart add: (Book with: 1).
	
	self deny: aShoppingCart isEmpty.! !

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/13/2017 14:29:49'!
test03AShoppingCartKnowsHowManyBooksItHas
	
	| aShoppingCart |

	aShoppingCart _ ShoppingCart new.
	aShoppingCart add: (Book with: 1).
	aShoppingCart add: (Book with: 2).
		
	self assert: aShoppingCart size equals: 2! !

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/13/2017 14:34:30'!
test04AShoppingCartCanHaveMultipleBooksAddedAtOnce
	
	| aShoppingCart |

	aShoppingCart _ ShoppingCart new.
	aShoppingCart add: (Book with: 1) withOccurrences: 10.
	
	self assert: aShoppingCart size equals: 10! !

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/13/2017 14:23:28'!
test05AShoppingCartRaisesExceptionIfAnObjectWithoutISBNIsAdded
	
	| aShoppingCart |

	aShoppingCart _ ShoppingCart new.
	
	self should: [aShoppingCart add: Object new] raise: Exception
	
	! !

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/13/2017 14:30:52'!
test06AShoppingCartRaisesExceptionIfAnUnevenAmountOfBooksIsAdded
	
	| aShoppingCart |

	aShoppingCart _ ShoppingCart new.
	
	self should: [aShoppingCart add: (Book with: 1) withOccurrences: 1.5] raise: Exception
	
	! !

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/13/2017 14:41:45'!
test07AShoppingCartKnowsHowManyTimesItHasABook
	
	| aShoppingCart aBook anotherBook |

	aBook _ Book with: 1.
	anotherBook _ Book with: 2.

	aShoppingCart _ ShoppingCart new.
	aShoppingCart add: aBook withOccurrences: 2.
	aShoppingCart add: anotherBook.
		
	self assert: (aShoppingCart select: [ :currentBook | currentBook = aBook]) size equals: 2.
	self assert: (aShoppingCart select: [ :currentBook | currentBook = anotherBook]) size equals: 1.! !


!classDefinition: #Book category: #'TusLibros-Solution'!
Object subclass: #Book
	instanceVariableNames: 'ISBN'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Book methodsFor: 'accessing' stamp: 'JG 6/13/2017 14:26:40'!
ISBN
	
	^ ISBN! !


!Book methodsFor: 'initialization' stamp: 'JG 6/13/2017 14:28:58'!
initializeWith: anISBN

	ISBN _ anISBN.
	
	^ self! !


!Book methodsFor: 'comparing' stamp: 'JG 6/13/2017 14:37:49'!
= anotherBook

	^ ISBN = anotherBook ISBN! !

!Book methodsFor: 'comparing' stamp: 'JG 6/13/2017 14:38:00'!
hash

	^ ISBN hash! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: #'TusLibros-Solution'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'as yet unclassified' stamp: 'JG 6/13/2017 14:28:35'!
with: anISBN

	anISBN isInteger ifFalse: [ self error: Exception ].
	^ self new initializeWith: anISBN.
	
	! !
