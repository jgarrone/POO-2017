!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'aCashier aCatalog anEmptyCatalog aShoppingCartWithEmptyCatalog aShoppingCart anItem anotherItem aCreditCard anExpiredCreditCard aShoppingCartWithAnItem today aRestToObjectTransator'
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


!TusLibrosTest methodsFor: '02 Testing - Cashier' stamp: 'JG 6/21/2017 21:06:24'!
test01ACashierWontCheckoutAnEmptyShoppingCart
	
	self 
		should: [ aCashier checkout: aShoppingCart payingWith: aCreditCard on: today] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: aCashier salesBook isEmpty.
			self assert: anError messageText equals: Cashier emptyShoppingCartErrorDescription.
			]
	
	 ! !

!TusLibrosTest methodsFor: '02 Testing - Cashier' stamp: 'JG 6/21/2017 21:06:30'!
test02ACashierReturnsPriceSumOfCheckedShoppingCart

	aShoppingCart add: anItem withOccurrences: 3.
	aShoppingCart add: anotherItem.
		
	self assert: (aCashier checkout: aShoppingCart payingWith: aCreditCard on: today) equals: 500	
	 ! !

!TusLibrosTest methodsFor: '02 Testing - Cashier' stamp: 'JG 6/21/2017 21:06:34'!
test03ACashierRaisesAnExceptionWhenTryingToPayWithExpiredCreditCard

	self 
		should: [ aCashier checkout: aShoppingCartWithAnItem payingWith: anExpiredCreditCard on: today ] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: aCashier salesBook isEmpty.
			self assert: anError messageText equals: Cashier expiredCreditCardErrorDescription.
			]
		 ! !

!TusLibrosTest methodsFor: '02 Testing - Cashier' stamp: 'JG 6/21/2017 21:06:41'!
test04ACashierLogsOrderAndRaisesAnExceptionWhenMerchantProcessorIsUnavailable

	| aCashierWithUnavailableMerchantProcessor |

	aCashierWithUnavailableMerchantProcessor _ Cashier withCatalog: aCatalog withSalesBook: Bag new withMerchantProcessor: UnavailableMerchantProcessor new.

	self 
		should: [ aCashierWithUnavailableMerchantProcessor checkout: aShoppingCartWithAnItem payingWith: aCreditCard on: today ] 
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: MerchantProcessor unavailableErrorDescription.
			self assert: aCashierWithUnavailableMerchantProcessor salesBook isEmpty.
			self assert: aCashierWithUnavailableMerchantProcessor delayedOrders size equals: 1.
			self assert: aCashierWithUnavailableMerchantProcessor delayedOrders anyOne shoppingCart equals: aShoppingCartWithAnItem.
			self assert: aCashierWithUnavailableMerchantProcessor delayedOrders anyOne creditCard equals: aCreditCard .
			self assert: aCashierWithUnavailableMerchantProcessor delayedOrders anyOne date equals: today.
			]
				
! !

!TusLibrosTest methodsFor: '02 Testing - Cashier' stamp: 'JG 6/21/2017 21:15:11'!
test05ACashierRaisesAnExceptionWhenCreditCardIsRejected

	| aCashierWithCreditCardRejecterMerchantProcessor |

	aCashierWithCreditCardRejecterMerchantProcessor _ Cashier withCatalog: aCatalog withSalesBook: Bag new withMerchantProcessor: CreditCardRejecterMerchantProcessor new.

	self 
		should: [ aCashierWithCreditCardRejecterMerchantProcessor checkout: aShoppingCartWithAnItem payingWith: aCreditCard on: today ] 
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: MerchantProcessor invalidCreditCardErrorDescription.
			self assert: aCashierWithCreditCardRejecterMerchantProcessor salesBook isEmpty.
			self assert: aCashierWithCreditCardRejecterMerchantProcessor delayedOrders isEmpty
			]
				
! !


!TusLibrosTest methodsFor: '03 Testing - Translator' stamp: 'JG 6/23/2017 19:12:37'!
test01ARecentlyCreatedCartCanBeListedAndItIsEmpty

	| aClientID aPassword aCartID |
	
	aClientID _ 1.
	aPassword _ 'password'.
	
	aCartID _ aRestToObjectTransator createCartForClientWithID: aClientID andPassword: aPassword.
	
	self assert: (aRestToObjectTransator listCartWithID: aCartID) isEmpty
	

	! !

!TusLibrosTest methodsFor: '03 Testing - Translator' stamp: 'JG 6/23/2017 19:12:12'!
test02TryingToListANonExistantCartRaisesAnError

	self 
		should: [ aRestToObjectTransator listCartWithID: 123 ] 
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestToObjectTranslator cartDoesntExistErrorDescription]
		
	

	! !


!TusLibrosTest methodsFor: 'set up' stamp: 'JG 6/23/2017 19:12:23'!
setUp

	today _ Date today.

	anEmptyCatalog _ Dictionary new.
	aShoppingCartWithEmptyCatalog _ ShoppingCart withCatalog: anEmptyCatalog.
	
	anItem _ 'Harry Potter and the Chamber of Secrets'.
	anotherItem _ 'The Bible'.	
	
	aCatalog _ Dictionary new.
	aCatalog at: anItem put: 100.
	aCatalog at: anotherItem put: 200.
	
	aShoppingCart _ ShoppingCart withCatalog: aCatalog.

	aShoppingCartWithAnItem _ ShoppingCart withCatalog: aCatalog.
	aShoppingCartWithAnItem add: anItem.
	
	aCreditCard _ CreditCard withExpirationDate: Date tomorrow.
	anExpiredCreditCard _ CreditCard withExpirationDate: Month current previous.
	
	aCashier _ Cashier withCatalog: aCatalog withSalesBook: Bag new withMerchantProcessor: MerchantProcessor new.

	aRestToObjectTransator _ RestToObjectTranslator withCatalog: aCatalog.	
	! !


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog salesBook merchantProcessor delayedOrders'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'JG 6/21/2017 19:08:35'!
checkout: aShoppingCart payingWith: aCreditCard on: aDate
	
	| anAmount |
	
	aShoppingCart isEmpty
		ifTrue: [ self error: Cashier emptyShoppingCartErrorDescription ]
		ifFalse: [ (aCreditCard isExpiredOn: aDate)
			ifTrue: [ self error: Cashier expiredCreditCardErrorDescription ]
			ifFalse: [ 
				anAmount _ aShoppingCart price.
				[ merchantProcessor debit: anAmount from: aCreditCard ] 
					on: Error 
					do: [ :anError | 
							(anError messageText = MerchantProcessor unavailableErrorDescription) 
								ifTrue: [ self logOrderOf: aShoppingCart payingWith: aCreditCard on: aDate ].
							self error: anError messageText.
						].
				salesBook add: (Sale withCreditCard: aCreditCard withAmount: anAmount on: aDate). 
			] 
		].
		
	^ anAmount ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'JG 6/21/2017 19:20:25'!
initialize

	delayedOrders _ Bag new.
	
	^ self! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'JG 6/20/2017 01:54:57'!
initializeWithCatalog: aCatalog withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor

	catalog _ aCatalog.
	salesBook _ aSalesBook.
	merchantProcessor _ aMerchantProcessor.
	
	^ self ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'JG 6/21/2017 21:03:52'!
logOrderOf: aShoppingCart payingWith: aCreditCard on: aDate

	"Generate batch file"
	^ delayedOrders add: (Order with: aShoppingCart payingWith: aCreditCard on: aDate).! !


!Cashier methodsFor: 'accessing' stamp: 'JG 6/21/2017 19:21:48'!
delayedOrders

	^ delayedOrders! !

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


!Cashier class methodsFor: 'instance creation' stamp: 'JG 6/20/2017 01:55:25'!
withCatalog: aCatalog withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor

	^ self new initializeWithCatalog: aCatalog withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor

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


!classDefinition: #MerchantProcessor category: #'TusLibros-Solution'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'JG 6/20/2017 01:49:56'!
debit: anAmount from: aCreditCard! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #'TusLibros-Solution'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'error description' stamp: 'JG 6/21/2017 21:13:03'!
invalidCreditCardErrorDescription
	
	^ 'The credit card is invalid'! !

!MerchantProcessor class methodsFor: 'error description' stamp: 'JG 6/20/2017 01:48:48'!
unavailableErrorDescription

	^ 'The Merchant Processor is unavailable at the moment'
	! !


!classDefinition: #CreditCardRejecterMerchantProcessor category: #'TusLibros-Solution'!
MerchantProcessor subclass: #CreditCardRejecterMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CreditCardRejecterMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'JG 6/21/2017 21:14:35'!
debit: anAmount from: aCreditCard

	self error: MerchantProcessor invalidCreditCardErrorDescription ! !


!classDefinition: #UnavailableMerchantProcessor category: #'TusLibros-Solution'!
MerchantProcessor subclass: #UnavailableMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!UnavailableMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'JG 6/20/2017 01:54:30'!
debit: anAmount from: aCreditCard

	self error: MerchantProcessor unavailableErrorDescription ! !


!classDefinition: #Order category: #'TusLibros-Solution'!
Object subclass: #Order
	instanceVariableNames: 'shoppingCart creditCard date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Order methodsFor: 'initialization' stamp: 'JG 6/21/2017 19:28:31'!
initializeWith: aShoppingCart payingWith: aCreditCard on: aDate

	shoppingCart _ aShoppingCart.
	creditCard _ aCreditCard.
	date _ aDate.
	
	^ self! !


!Order methodsFor: 'accesing' stamp: 'JG 6/21/2017 19:31:57'!
creditCard

	 ^ creditCard! !

!Order methodsFor: 'accesing' stamp: 'JG 6/21/2017 19:32:01'!
date

	 ^ date! !

!Order methodsFor: 'accesing' stamp: 'JG 6/21/2017 19:31:51'!
shoppingCart

	 ^ shoppingCart! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Order class' category: #'TusLibros-Solution'!
Order class
	instanceVariableNames: ''!

!Order class methodsFor: 'as yet unclassified' stamp: 'JG 6/21/2017 19:28:02'!
with: aShoppingCart payingWith: aCreditCard on: aDate

	^ self new initializeWith: aShoppingCart payingWith: aCreditCard on: aDate! !


!classDefinition: #RestToObjectTranslator category: #'TusLibros-Solution'!
Object subclass: #RestToObjectTranslator
	instanceVariableNames: 'carts catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!RestToObjectTranslator methodsFor: 'initializing' stamp: 'JG 6/23/2017 18:56:57'!
initialize

	carts _ Dictionary new.
	
	^ self! !

!RestToObjectTranslator methodsFor: 'initializing' stamp: 'JG 6/23/2017 18:54:18'!
initializeWith: aCatalog

	catalog _ aCatalog.
	
	^ self! !


!RestToObjectTranslator methodsFor: 'adding' stamp: 'JG 6/23/2017 18:59:52'!
createCartForClientWithID: anID andPassword: aPassword

	carts at: anID put: (ShoppingCart withCatalog: catalog).

	^ anID
	
	

	! !


!RestToObjectTranslator methodsFor: 'accessing' stamp: 'JG 6/23/2017 19:11:44'!
listCartWithID: anID 

	(carts includesKey: anID)
		ifTrue: [ ^ (carts at: anID) sortedCounts ]
		ifFalse: [ self error: RestToObjectTranslator cartDoesntExistErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestToObjectTranslator class' category: #'TusLibros-Solution'!
RestToObjectTranslator class
	instanceVariableNames: ''!

!RestToObjectTranslator class methodsFor: 'instance creation' stamp: 'JG 6/23/2017 18:54:00'!
withCatalog: aCatalog

	^ self new initializeWith: aCatalog! !


!RestToObjectTranslator class methodsFor: 'error description' stamp: 'JG 6/23/2017 19:10:20'!
cartDoesntExistErrorDescription

	^ 'The cart for the ID given does not exist'! !


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

!ShoppingCart methodsFor: 'accessing' stamp: 'JG 6/20/2017 20:17:49'!
price

	^ ( contents asSet collect: [ :anItem | (self countOf: anItem) * (catalog at: anItem) ] ) sum! !

!ShoppingCart methodsFor: 'accessing' stamp: 'JG 6/23/2017 19:03:13'!
sortedCounts

	^ contents sortedCounts! !


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
