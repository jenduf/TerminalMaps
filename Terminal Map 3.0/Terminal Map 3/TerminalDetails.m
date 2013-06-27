//
//  TerminalDetails.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/17/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import "TerminalDetails.h"
#import "Constants.h"
#import "TerminalInfoData.h"

@implementation TerminalDetails
@synthesize airline_clubs = _airline_clubs;
@synthesize airlines = _airlines;
@synthesize drinks = _drinks;
@synthesize flight_status = _flight_status;
@synthesize hotels = _hotels;
@synthesize parking = _parking;
@synthesize atms = _atms;
@synthesize restaurants = _restaurants;
@synthesize shops = _shops;
@synthesize services = _services;
@synthesize transportation = _transportation;
@synthesize hideClubs = _hideClubs;
@synthesize hideAirlines = _hideAirlines;
@synthesize hideDrinks = _hideDrinks;
@synthesize hideHotels = _hideHotels;
@synthesize hideParking = _hideParking;
@synthesize hideRestaurants = _hideRestaurants;
@synthesize hideShops = _hideShops;
@synthesize hideServices = _hideServices;
@synthesize hideTransportation = _hideTransportation;
@synthesize other = _other;
@synthesize currentlyDisplayedIcons = _currentlyDisplayedIcons;
@synthesize currentZoomLevel = _currentZoomLevel;

+ (id)getDetailsFromDictionary:(NSDictionary *)dict
{
	TerminalDetails *terminalDetails = [[self alloc] init];
	
	terminalDetails.airline_clubs = [[NSArray alloc] initWithArray:[TerminalDetails setUpClubsWithDictionary:dict]];
     
	terminalDetails.airlines = [[NSArray alloc] initWithArray:[TerminalDetails setUpAirlinesWithDictionary:dict]];
	
	terminalDetails.drinks = [[NSArray alloc] initWithArray:[TerminalDetails setUpDrinksWithDictionary:dict]];
	
	terminalDetails.flight_status = [[NSArray alloc] initWithArray:[TerminalDetails setUpFlightStatusesWithDictionary:dict]];
	
	terminalDetails.hotels = [[NSArray alloc] initWithArray:[TerminalDetails setUpHotelsWithDictionary:dict]];
	
	terminalDetails.parking = [[NSArray alloc] initWithArray:[TerminalDetails setUpParkingWithDictionary:dict]];
	
	terminalDetails.restaurants = [[NSArray alloc] initWithArray:[TerminalDetails setUpRestaurantsWithDictionary:dict]];
	
	terminalDetails.shops = [[NSArray alloc] initWithArray:[TerminalDetails setUpShopsWithDictionary:dict]];
	
	terminalDetails.services = [[NSArray alloc] initWithArray:[TerminalDetails setUpServicesWithDictionary:dict]];
	
	terminalDetails.transportation = [[NSArray alloc] initWithArray:[TerminalDetails setUpTransportationWithDictionary:dict]];
	
	terminalDetails.atms = [[NSArray alloc] initWithArray:[TerminalDetails setUpATMSWithDictionary:dict]];
	
	terminalDetails.other = [[NSArray alloc] initWithArray:[TerminalDetails setUpOtherWithDictionary:dict]];
	
	terminalDetails.currentlyDisplayedIcons = [[NSMutableArray alloc] initWithArray:terminalDetails.other];
	
	[terminalDetails.currentlyDisplayedIcons addObjectsFromArray:terminalDetails.parking];
	
	return terminalDetails;
}

- (NSArray *)getIconsByName:(NSString *)str
{
	NSMutableArray *returnArray = [NSMutableArray array];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like[cd] %@", str];
	
	NSArray *allIcons = [NSArray arrayWithArray:[self buildArrayForIconsOnFloor:0]];
	
	[returnArray addObjectsFromArray:[allIcons filteredArrayUsingPredicate:predicate]];
	
	return returnArray;
}

- (NSArray *)toggleVisibilityForIconsAtIndex:(int)index isVisible:(BOOL)visible
{
	NSMutableArray *returnArray = [NSMutableArray arrayWithArray:self.currentlyDisplayedIcons];
	
	if(visible == YES)
	{
		if(index == 0)
		{
			[returnArray removeAllObjects];
			
			if(self.other != nil && [self.other count] > 0)
				[returnArray addObjectsFromArray:self.other];
		}
		else
		{
			for(TerminalInfoData *tid in self.other)
			{
				if(tid.iconType == index)
					[returnArray addObject:tid];
			}
		}
	}
	else
	{
		if(index == 0)
		{
			[returnArray removeAllObjects];
		}
		else
		{
			for(TerminalInfoData *tid in self.currentlyDisplayedIcons)
			{
				if(tid.iconType == index)
					[returnArray removeObject:tid];
			}
		}
			
	}
	
	if(self.parking != nil && [self.parking count] > 0)
		[returnArray addObjectsFromArray:self.parking];
	
	[self.currentlyDisplayedIcons removeAllObjects];
	[self.currentlyDisplayedIcons addObjectsFromArray:returnArray];
	
	
	return [self buildArrayForIconsAtZoomLevel:self.currentZoomLevel];
}

- (NSArray *)buildArrayForIconsAtZoomLevel:(int)zoom
{
	NSMutableArray *returnArray = [NSMutableArray array];
	
	self.currentZoomLevel = zoom;
	
	//if(self.other != nil && [self.other count] > 0)
		//	[returnArray addObjectsFromArray:self.other];
	
	//if(self.parking != nil && [self.parking count] > 0)
	//	[returnArray addObjectsFromArray:self.parking];
	
	if(self.currentlyDisplayedIcons != nil && [self.currentlyDisplayedIcons count] > 0)
	{
		[returnArray addObjectsFromArray:self.currentlyDisplayedIcons];
	}
		
	if(zoom < 2)
	{
		for(TerminalInfoData *tid in self.currentlyDisplayedIcons)
		{
			if(tid.iconType == MAP_ICON_SECURITY || tid.iconType == MAP_ICON_TICKET || tid.iconType == MAP_ICON_BAGGAGE)
				[returnArray removeObject:tid];
		}
	}
	
	if(zoom > 3)
	{
		[returnArray addObjectsFromArray:[self buildArrayForIconsOnFloor:0]];
	}
	
	return returnArray;
}

- (NSArray *)buildArrayForIconsOnFloor:(int)floor
{
	NSMutableArray *returnArray = [NSMutableArray array];
	
	if(self.hideClubs == NO)
	{
		if(self.airline_clubs != nil && [self.airline_clubs count] > 0)
		{
			if([self icons:self.airline_clubs visibleOnFloor:floor])
				[returnArray addObjectsFromArray:self.airline_clubs];
		}
	}
	
	if(self.hideAirlines == NO)
	{
		if(self.airlines != nil && [self.airlines count] > 0)
		{
			if([self icons:self.airlines visibleOnFloor:floor])
				[returnArray addObjectsFromArray:self.airlines];
		}
	}
	
	if(self.hideDrinks == NO)
	{
		if(self.drinks != nil && [self.drinks count] > 0)
		{
			if([self icons:self.drinks visibleOnFloor:floor])
				[returnArray addObjectsFromArray:self.drinks];
		}
	}
	
	if(self.hideHotels == NO)
	{
		if(self.hotels != nil && [self.hotels count] > 0)
		{
			if([self icons:self.hotels visibleOnFloor:floor])
				[returnArray addObjectsFromArray:self.hotels];
		}
	}
	
	/*
	if(self.hideParking == NO)
	{
		if(self.parking != nil && [self.parking count] > 0)
		{
			if([self icons:self.parking visibleOnFloor:floor])
				[returnArray addObjectsFromArray:self.parking];
		}
	}
	 */
	
	if(self.hideRestaurants == NO)
	{
		if(self.restaurants != nil && [self.restaurants count] > 0)
		{
			if([self icons:self.restaurants visibleOnFloor:floor])
				[returnArray addObjectsFromArray:self.restaurants];
		}
	}
	
	if(self.hideShops == NO)
	{
		if(self.shops != nil && [self.shops count] > 0)
		{
			if([self icons:self.shops visibleOnFloor:floor])
				[returnArray addObjectsFromArray:self.shops];
		}
	}
	
	if(self.hideServices == NO)
	{
		if(self.services != nil && [self.services count] > 0)
		{
			if([self icons:self.services visibleOnFloor:floor])
				[returnArray addObjectsFromArray:self.services];
		}
	}
	if(self.hideTransportation == NO)
	{
		if(self.transportation != nil && [self.transportation count] > 0)
		{
			if([self icons:self.transportation visibleOnFloor:floor])
				[returnArray addObjectsFromArray:self.transportation];
		}
	}
	
	if(self.atms != nil && [self.atms count] > 0)
	{
		if([self icons:self.atms visibleOnFloor:floor])
			[returnArray addObjectsFromArray:self.atms];
	}
	
	//[returnArray addObjectsFromArray:self.currentlyDisplayedIcons];
	
	return returnArray;
	
}

- (BOOL)icons:(NSArray *)icons visibleOnFloor:(int)floor
{
	TerminalInfoData *tid = (TerminalInfoData *)[icons objectAtIndex:0];
	
	if(tid.level == floor || floor == 0)
		return YES;
	
	return NO;
}

+ (NSArray *)setUpClubsWithDictionary:(NSDictionary *)dict
{
	// set up clubs
	NSArray *clubArray = [NSArray arrayWithArray:[dict objectForKey:KEY_TERMINAL_AIRLINE_CLUBS]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *clubDict in clubArray)
	{
		TerminalInfoData *termInfoData = [[TerminalInfoData alloc] initWithDictionary:clubDict];
		[tempArray addObject:termInfoData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpAirlinesWithDictionary:(NSDictionary *)dict
{
	// set up airlines
	NSArray *airlineArray = [NSArray arrayWithArray:[dict objectForKey:KEY_TERMINAL_AIRLINES]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *airlineDict in airlineArray)
	{
		TerminalInfoData *termInfoData = [[TerminalInfoData alloc] initWithDictionary:airlineDict];
		termInfoData.iconType = 0;
		termInfoData.level = 2;
		[tempArray addObject:termInfoData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpDrinksWithDictionary:(NSDictionary *)dict
{
	// set up drinks
	NSArray *drinkArray = [NSArray arrayWithArray:[dict objectForKey:KEY_TERMINAL_DRINKS]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *drinkDict in drinkArray)
	{
		TerminalInfoData *termInfoData = [[TerminalInfoData alloc] initWithDictionary:drinkDict];
		[tempArray addObject:termInfoData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpFlightStatusesWithDictionary:(NSDictionary *)dict
{
	// set up flight statuses
	NSArray *flightArray = [NSArray arrayWithArray:[dict objectForKey:KEY_TERMINAL_FLIGHT_STATUS]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *flightDict in flightArray)
	{
		TerminalInfoData *termInfoData = [[TerminalInfoData alloc] initWithDictionary:flightDict];
		[tempArray addObject:termInfoData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpHotelsWithDictionary:(NSDictionary *)dict
{
	// set up hotels
	NSArray *hotelArray = [NSArray arrayWithArray:[dict objectForKey:KEY_TERMINAL_AIRPORT_HOTELS]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *hotelDict in hotelArray)
	{
		TerminalInfoData *termInfoData = [[TerminalInfoData alloc] initWithDictionary:hotelDict];
		termInfoData.iconType = MAP_ICON_HOTEL;
		[tempArray addObject:termInfoData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpParkingWithDictionary:(NSDictionary *)dict
{
	// set up parking
	NSArray *parkingArray = [NSArray arrayWithArray:[dict objectForKey:KEY_TERMINAL_PARKING]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *parkingDict in parkingArray)
	{
		TerminalInfoData *termInfoData = [[TerminalInfoData alloc] initWithDictionary:parkingDict];
		[tempArray addObject:termInfoData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpRestaurantsWithDictionary:(NSDictionary *)dict
{
	// set up restaurants
	NSArray *restaurantArray = [NSArray arrayWithArray:[dict objectForKey:KEY_TERMINAL_RESTAURANTS]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *restaurantDict in restaurantArray)
	{
		TerminalInfoData *termInfoData = [[TerminalInfoData alloc] initWithDictionary:restaurantDict];
		termInfoData.level = 3;
		[tempArray addObject:termInfoData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpShopsWithDictionary:(NSDictionary *)dict
{
	// set up shops
	NSArray *shopArray = [NSArray arrayWithArray:[dict objectForKey:KEY_TERMINAL_SHOPS]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *shopDict in shopArray)
	{
		TerminalInfoData *termInfoData = [[TerminalInfoData alloc] initWithDictionary:shopDict];
		termInfoData.iconType = MAP_ICON_SHOPS;
		termInfoData.level = 3;
		[tempArray addObject:termInfoData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpServicesWithDictionary:(NSDictionary *)dict
{
	// set up services
	NSArray *servicesArray = [NSArray arrayWithArray:[dict objectForKey:KEY_TERMINAL_SERVICES]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *servicesDict in servicesArray)
	{
		TerminalInfoData *termInfoData = [[TerminalInfoData alloc] initWithDictionary:servicesDict];
		termInfoData.iconType = MAP_ICON_SERVICES;
		[tempArray addObject:termInfoData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpTransportationWithDictionary:(NSDictionary *)dict
{
	// set up transportation
	NSArray *transportationArray = [NSArray arrayWithArray:[dict objectForKey:KEY_TERMINAL_TRANSPORTATION]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *transportationDict in transportationArray)
	{
		TerminalInfoData *termInfoData = [[TerminalInfoData alloc] initWithDictionary:transportationDict];
		[tempArray addObject:termInfoData];
	}
     
	return tempArray;
}
	
+ (NSArray *)setUpATMSWithDictionary:(NSDictionary *)dict
{
	// set up transportation
	NSArray *atmArray = [NSArray arrayWithArray:[dict objectForKey:KEY_TERMINAL_ATMS]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *atmDict in atmArray)
	{
		TerminalInfoData *termInfoData = [[TerminalInfoData alloc] initWithDictionary:atmDict];
		[tempArray addObject:termInfoData];
	}
	
	return tempArray;	
}

+ (NSArray *)setUpOtherWithDictionary:(NSDictionary *)dict
{
	// set up other
	NSArray *otherArray = [NSArray arrayWithArray:[dict objectForKey:KEY_TERMINAL_OTHER]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *otherDict in otherArray)
	{
		TerminalInfoData *termInfoData = [[TerminalInfoData alloc] initWithDictionary:otherDict];
		[tempArray addObject:termInfoData];
	}
     
     return tempArray;
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.airlines forKey:@"airline_clubs"];
	[encoder encodeObject:self.airlines forKey:@"airlines"];
	[encoder encodeObject:self.drinks forKey:@"drinks"];
	[encoder encodeObject:self.flight_status forKey:@"flight_status"];
	[encoder encodeObject:self.hotels forKey:@"hotels"];
	[encoder encodeObject:self.parking forKey:@"parking"];
	[encoder encodeObject:self.restaurants forKey:@"restaurants"];
	[encoder encodeObject:self.shops forKey:@"shops"];
	[encoder encodeObject:self.services forKey:@"services"];
	[encoder encodeObject:self.transportation forKey:@"transportation"];
	[encoder encodeObject:self.other forKey:@"other"];
	[encoder encodeObject:self.currentlyDisplayedIcons forKey:@"currentlyDisplayedIcons"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	if(self)
	{
		self.airline_clubs = [decoder decodeObjectForKey:@"airline_clubs"];
		self.airlines = [decoder decodeObjectForKey:@"airlines"];
		self.drinks = [decoder decodeObjectForKey:@"drinks"];
		self.flight_status = [decoder decodeObjectForKey:@"flight_status"];
		self.hotels = [decoder decodeObjectForKey:@"hotels"];
		self.parking = [decoder decodeObjectForKey:@"parking"];
		self.restaurants = [decoder decodeObjectForKey:@"restaurants"];
		self.shops = [decoder decodeObjectForKey:@"shops"];
		self.services = [decoder decodeObjectForKey:@"services"];
		self.transportation = [decoder decodeObjectForKey:@"transportation"];
		self.other = [decoder decodeObjectForKey:@"other"];
		self.currentlyDisplayedIcons = [decoder decodeObjectForKey:@"currentlyDisplayedIcons"];
	}
	
	return self;
}

@end
