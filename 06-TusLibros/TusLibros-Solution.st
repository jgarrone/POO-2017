!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'aCashier aCatalog anEmptyCatalog aShoppingCartWithEmptyCatalog aShoppingCart anItem anotherItem aCreditCard anExpiredCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/15/2017 20:23:19'!
test01AShoppingCartRaisesAnErrorIfTryingToAddAnItemNotIncludedInTheCatalog
		
	self 
		should: [aShoppingCartWithEmptyCatalog add: 'Harry Potter and the Chamber of Secrets' ] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: aShoppingCart isEmpty.
			self assert: anError messageText equals: ShoppingCart catalogDoesNotIncludeItemErrorDescription.
			] ! !

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/15/2017 20:23:42'!
test02AShoppingCartIncludesItemsAddedThatAreOnTheCatalog
	
	aShoppingCart add: anItem.
	
	self assert: (aShoppingCart includes: anItem) ! !

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/15/2017 20:24:43'!
test03AShoppingCartRaisesExceptionWhenTryingToAddAnUnevenAmountOfItems
	
	self 
		should: [aShoppingCart add: anItem withOccurrences: 1.5 ] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: aShoppingCart isEmpty.
			self assert: anError messageText equals: ShoppingCart invalidAmountOfItemsErrorDescription.
			]
	
	 ! !

!TusLibrosTest methodsFor: '01 Testing - ShoppingCart' stamp: 'JG 6/15/2017 20:24:59'!
test04AShoppingCartRaisesExceptionWhenTryingToAddANegativeAmountOfItems
	
	self 
		should: [aShoppingCart add: anItem withOccurrences: -1 ] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: aShoppingCart isEmpty.
			self assert: anError messageText equals: ShoppingCart invalidAmountOfItemsErrorDescription.
			]
	
	 ! !


!TusLibrosTest methodsFor: '02 Testing - Cashier' stamp: 'JG 6/15/2017 22:45:34'!
test01ACashierWontCheckoutAnEmptyShoppingCart
	
	self 
		should: [ aCashier checkout: aShoppingCart payingWith: aCreditCard on: Date today] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: aCashier salesBook isEmpty.
			self assert: anError messageText equals: Cashier emptyShoppingCartErrorDescription.
			]
	
	 ! !

!TusLibrosTest methodsFor: '02 Testing - Cashier' stamp: 'JG 6/15/2017 22:27:42'!
test02ACashierReturnsPriceSumOfCheckedShoppingCart

	aShoppingCart add: anItem withOccurrences: 3.
	aShoppingCart add: anotherItem.
		
	self assert: (aCashier checkout: aShoppingCart payingWith: aCreditCard on: Date today) equals: 500	
	 ! !

!TusLibrosTest methodsFor: '02 Testing - Cashier' stamp: 'JG 6/15/2017 22:46:09'!
test03ACashierRaisesAnExceptionWhenTryingToPayWithExpiredCreditCard

	aShoppingCart add: anItem.
	
	self 
		should: [ aCashier checkout: aShoppingCart payingWith: anExpiredCreditCard on: Date today ] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: aCashier salesBook isEmpty.
			self assert: anError messageText equals: Cashier expiredCreditCardErrorDescription.
			]
		 ! !


!TusLibrosTest methodsFor: 'set up' stamp: 'JG 6/15/2017 22:43:28'!
setUp

	anEmptyCatalog _ Dictionary new.
	aShoppingCartWithEmptyCatalog _ ShoppingCart withCatalog: anEmptyCatalog.
	
	anItem _ 'Harry Potter and the Chamber of Secrets'.
	anotherItem _ 'The Bible'.	
	
	aCatalog _ Dictionary new.
	aCatalog at: anItem put: 100.
	aCatalog at: anotherItem put: 200.
	
	aShoppingCart _ ShoppingCart withCatalog: aCatalog.
	
	aCreditCard _ CreditCard withExpirationDate: Date tomorrow.
	anExpiredCreditCard _ CreditCard withExpirationDate: Month current previous.
	
	aCashier _ Cashier withCatalog: aCatalog withSalesBook: Bag new.
! !


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'JG 6/15/2017 22:38:11'!
checkout: aShoppingCart payingWith: aCreditCard on: aDate
	
	| anAmount |
	
	aShoppingCart isEmpty
		ifTrue: [ self error: Cashier emptyShoppingCartErrorDescription ]
		ifFalse: [ (aCreditCard isExpiredOn: aDate)
			ifTrue: [ self error: Cashier expiredCreditCardErrorDescription ]
			ifFalse: [ 
				anAmount _ (aShoppingCart itemSet collect: [ :anItem | (aShoppingCart countOf: anItem) * (catalog at: anItem) ] ) sum.
				self debit: anAmount from: aCreditCard.
				salesBook add: (Sale withCreditCard: aCreditCard withAmount: anAmount on: aDate). 
			] 
		].
		
	^ anAmount ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'JG 6/13/2017 21:15:17'!
debit: anAmount from: aCreditCard

	"No hacer nada"! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'JG 6/15/2017 22:41:16'!
initializeWithCatalog: aCatalog withSalesBook: aSalesBook

	catalog _ aCatalog.
	salesBook _ aSalesBook.
	
	^ self ! !


!Cashier methodsFor: 'accessing' stamp: 'JG 6/15/2017 22:45:26'!
salesBook
	
	^ salesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error description' stamp: 'JG 6/14/2017 11:43:38'!
emptyShoppingCartErrorDescription

	^ 'The shopping cart is empty' ! !

!Cashier class methodsFor: 'error description' stamp: 'JG 6/15/2017 19:31:38'!
expiredCreditCardErrorDescription
	
	^ 'The credit card is expired'! !


!Cashier class methodsFor: 'instance creation' stamp: 'JG 6/15/2017 22:41:24'!
withCatalog: aCatalog withSalesBook: aSalesBook

	^ self new initializeWithCatalog: aCatalog withSalesBook: aSalesBook

	 ! !


!classDefinition: #CreditCard category: #'TusLibros-Solution'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CreditCard methodsFor: 'initializing' stamp: 'JG 6/15/2017 20:07:14'!
expirationMonthIndex

	^ expirationDate monthIndex! !

!CreditCard methodsFor: 'initializing' stamp: 'JG 6/15/2017 20:07:21'!
expirationYearNumber

	^ expirationDate yearNumber! !

!CreditCard methodsFor: 'initializing' stamp: 'JG 6/15/2017 20:07:58'!
initializeWithExpirationDate: aDate

	expirationDate _ aDate.
	
	^ self! !


!CreditCard methodsFor: 'accessing' stamp: 'JG 6/15/2017 22:49:54'!
isExpiredOn: aDate

	^ (aDate yearNumber <= self expirationYearNumber and: aDate monthIndex <= self expirationMonthIndex) not.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Solution'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JG 6/15/2017 20:11:00'!
withExpirationDate: aDate 
	
	^ self new initializeWithExpirationDate: aDate! !


!classDefinition: #Sale category: #'TusLibros-Solution'!
Object subclass: #Sale
	instanceVariableNames: 'creditCard amount date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Sale methodsFor: 'initialization' stamp: 'JG 6/15/2017 22:44:15'!
initializeWithCreditCard: aCreditCard withAmount: anAmount on: aDate

	creditCard _ aCreditCard.
	amount _ anAmount.
	date _ aDate.
	
	^ self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'TusLibros-Solution'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'JG 6/15/2017 22:39:21'!
withCreditCard: aCreditCard withAmount: anAmount on: aDate

	^ self new initializeWithCreditCard: aCreditCard withAmount: anAmount on: aDate	! !


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

!ShoppingCart methodsFor: 'accessing' stamp: 'JG 6/15/2017 20:46:41'!
itemSet

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

!ShoppingCart class methodsFor: 'error description' stamp: 'JG 6/13/2017 21:50:10'!
catalogDoesNotIncludeItemErrorDescription
	
	^ 'The item is not included in the catalog'! !

!ShoppingCart class methodsFor: 'error description' stamp: 'JG 6/13/2017 22:20:33'!
invalidAmountOfItemsErrorDescription

	^ 'The amount of items is invalid'! !


!ShoppingCart class methodsFor: 'instance creation' stamp: 'JG 6/13/2017 20:39:25'!
withCatalog: aCatalog

	^ self new initializeWith: aCatalog
! !
