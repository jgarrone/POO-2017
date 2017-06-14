!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/14/2017 11:43:23'!
test01AShoppingCartRaisesAnErrorIfTryingToAddAnItemNotIncludedInTheCatalog
	
	| aShoppingCart |

	aShoppingCart _ ShoppingCart withCatalog: (Dictionary new).
	
	self 
		should: [aShoppingCart add: 'Harry Potter and the Chamber of Secrets' ] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: aShoppingCart isEmpty.
			self assert: anError messageText equals: ShoppingCart catalogDoesNotIncludeItemErrorDescription.
			] ! !

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/14/2017 11:43:26'!
test02AShoppingCartIncludesItemsAddedThatAreOnTheCatalog
	
	| anItem aShoppingCart aCatalog |

	anItem _ 'Harry Potter and the Chamber of Secrets'.
	aCatalog _ Dictionary new.
	aCatalog at: anItem put: 100.
	aShoppingCart _ ShoppingCart withCatalog: aCatalog.

	aShoppingCart add: anItem.
	
	self assert: (aShoppingCart includes: anItem) ! !

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/14/2017 11:43:29'!
test03AShoppingCartRaisesExceptionWhenTryingToAddAnUnevenAmountOfItems

	| aShoppingCart aCatalog anItem |

	anItem _ 'Harry Potter and the Chamber of Secrets'.
	aCatalog _ Dictionary new.
	aCatalog at: anItem put: 100.

	aShoppingCart _ ShoppingCart withCatalog: aCatalog.
	
	self 
		should: [aShoppingCart add: 'Harry Potter and the Chamber of Secrets' withOccurrences: 1.5 ] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: aShoppingCart isEmpty.
			self assert: anError messageText equals: ShoppingCart invalidAmountOfItemsErrorDescription.
			]
	
	 ! !

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/14/2017 11:43:32'!
test04AShoppingCartRaisesExceptionWhenTryingToAddANegativeAmountOfItems

	| aShoppingCart aCatalog anItem |

	anItem _ 'Harry Potter and the Chamber of Secrets'.
	aCatalog _ Dictionary new.
	aCatalog at: anItem put: 100.

	aShoppingCart _ ShoppingCart withCatalog: aCatalog.
	
	self 
		should: [aShoppingCart add: 'Harry Potter and the Chamber of Secrets' withOccurrences: -1 ] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: aShoppingCart isEmpty.
			self assert: anError messageText equals: ShoppingCart invalidAmountOfItemsErrorDescription.
			]
	
	 ! !


!TusLibrosTest methodsFor: '02 Testing - Cashier' stamp: 'JG 6/14/2017 11:43:13'!
test01ACashierWontCheckoutAnEmptyShoppingCart

	| aCashier aShoppingCart aCreditCard |
	
	aCashier _ Cashier new.
	aShoppingCart _ ShoppingCart withCatalog: Bag new.
	aCreditCard _ Object new.
	
	self 
		should: [ aCashier checkout: aShoppingCart payingWith: aCreditCard] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: Cashier emptyShoppingCartErrorDescription.
			]
	
	 ! !

!TusLibrosTest methodsFor: '02 Testing - Cashier' stamp: 'JG 6/14/2017 11:43:18'!
test02ACashierReturnsPriceSumOfCheckedShoppingCart

	| anItem aCashier aShoppingCart aCreditCard aCatalog anotherItem |
	
	anItem _ 'Harry Potter and the Chamber of Secrets'.	
	anotherItem _ 'The Bible'.
	aCatalog _ Dictionary new.
	aCatalog at: anItem put: 100.
	aCatalog at: anotherItem put: 200.
	aCashier _ Cashier withCatalog: aCatalog.
	aShoppingCart _ ShoppingCart withCatalog: aCatalog.
	aShoppingCart add: anItem withOccurrences: 3.
	aShoppingCart add: anotherItem.
	aCreditCard _ Object new.
	
	self assert: (aCashier checkout: aShoppingCart payingWith: aCreditCard) equals: 500	
	 ! !


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'JG 6/14/2017 11:42:14'!
checkout: aShoppingCart payingWith: aCreditCard
	
	| anAmount |
	
	aShoppingCart isEmpty
		ifTrue: [ self error: Cashier emptyShoppingCartErrorDescription ]
		ifFalse: [ 
			anAmount _ (aShoppingCart items collect: [ :anItem | (aShoppingCart countOf: anItem) * (catalog at: anItem) ] ) sum.
			self debit: anAmount from: aCreditCard ].
		
	^ anAmount ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'JG 6/13/2017 21:15:17'!
debit: anAmount from: aCreditCard

	"No hacer nada"! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'JG 6/14/2017 11:44:30'!
initializeWith: aCatalog

	catalog _ aCatalog.
	
	^ self ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error description' stamp: 'JG 6/14/2017 11:43:38'!
emptyShoppingCartErrorDescription

	^ 'The shopping cart is empty' ! !


!Cashier class methodsFor: 'as yet unclassified' stamp: 'JG 6/14/2017 11:43:42'!
withCatalog: aCatalog

	^ self new initializeWith: aCatalog

	 ! !


!classDefinition: #ShoppingCart category: #'TusLibros-Solution'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'contents catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!ShoppingCart methodsFor: 'adding' stamp: 'JG 6/13/2017 21:51:31'!
add: newObject

	^ self add: newObject withOccurrences: 1
		! !

!ShoppingCart methodsFor: 'adding' stamp: 'JG 6/14/2017 11:42:38'!
add: newObject withOccurrences: anAmount

	(catalog includesKey: newObject) 
		ifTrue: [ (anAmount isInteger and: anAmount > 0)
			ifTrue: [ contents add: newObject withOccurrences: anAmount]
			ifFalse: [ self error: ShoppingCart invalidAmountOfItemsErrorDescription ] ]
		ifFalse: [ self error: ShoppingCart catalogDoesNotIncludeItemErrorDescription ].
		
	^ self ! !


!ShoppingCart methodsFor: 'accessing' stamp: 'JG 6/14/2017 11:42:48'!
countOf: anItem
	
	^ contents occurrencesOf: anItem ! !

!ShoppingCart methodsFor: 'accessing' stamp: 'JG 6/13/2017 22:02:58'!
includes: anItem

	^ contents includes: anItem! !

!ShoppingCart methodsFor: 'accessing' stamp: 'JG 6/13/2017 22:08:17'!
isEmpty

	^ contents isEmpty! !

!ShoppingCart methodsFor: 'accessing' stamp: 'JG 6/14/2017 11:42:54'!
items

	^ contents asSet ! !


!ShoppingCart methodsFor: 'initializing' stamp: 'JG 6/13/2017 22:02:19'!
initialize

	contents _ Bag new.
	
	^ self! !

!ShoppingCart methodsFor: 'initializing' stamp: 'JG 6/13/2017 20:40:03'!
initializeWith: aCatalog
	
	catalog _ aCatalog.
	
	^ self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: #'TusLibros-Solution'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'initialization' stamp: 'JG 6/13/2017 20:39:25'!
withCatalog: aCatalog

	^ self new initializeWith: aCatalog
! !


!ShoppingCart class methodsFor: 'error description' stamp: 'JG 6/13/2017 21:50:10'!
catalogDoesNotIncludeItemErrorDescription
	
	^ 'The item is not included in the catalog'! !

!ShoppingCart class methodsFor: 'error description' stamp: 'JG 6/13/2017 22:20:33'!
invalidAmountOfItemsErrorDescription

	^ 'The amount of items is invalid'! !
