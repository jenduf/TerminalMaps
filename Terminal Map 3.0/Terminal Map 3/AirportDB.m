//
//  AirportDB.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 10/25/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import "AirportDB.h"
#import "Constants.h"
#import "Airport.h"
#import "Terminal.h"
#import "DataArchiver.h"
#import "Flight.h"

@implementation AirportDB
@synthesize airports = _airports;
@synthesize favorites = _favorites;
@synthesize currentAirport = _currentAirport;
@synthesize currentTerminal = _currentTerminal;
@synthesize flights = _flights;

static AirportDB *a_database;

+ (AirportDB *)sharedDatabase
{
	if(!a_database)
	{
		a_database = [[AirportDB alloc] init];
	}
	
	return a_database;
}

- (id)init
{
	self = [super init];
	
	if(self)
	{
		[self loadAirports];
		[self loadFavorites];
		[self loadFlights];
	}
	
	return self;
}

- (void)loadAirports
{
	NSString *path = [[NSBundle mainBundle] pathForResource:DATA_AIRPORTS_FILENAME ofType:@"plist"];
	NSDictionary *tempDict;
	
	NSMutableArray *airportArr = [NSMutableArray array];
	
	if(path && (tempDict = [NSDictionary dictionaryWithContentsOfFile:path]))
	{
          NSArray *airportsArray = [NSArray arrayWithArray:[tempDict objectForKey:KEY_AIRPORTS]];
		
		for(NSDictionary *dict in airportsArray)
		{
			Airport *airport = [Airport airportFromDictionary:dict];
			[airportArr addObject:airport];
		}
		
	}
	
	self.airports = [[NSArray alloc] initWithArray:airportArr];
}

- (void)loadFlights
{
	NSString *path = [[NSBundle mainBundle] pathForResource:DATA_FLIGHTS_FILENAME ofType:@"plist"];
	NSDictionary *tempDict;
	
	NSMutableArray *flightArr = [NSMutableArray array];
	
	if(path && (tempDict = [NSDictionary dictionaryWithContentsOfFile:path]))
	{
		NSArray *flightsArray = [NSArray arrayWithArray:[tempDict objectForKey:KEY_FLIGHTS]];
		
		for(NSDictionary *dict in flightsArray)
		{
			Flight *flight = [[Flight alloc] initWithDictionary:dict];
			[flightArr addObject:flight];
		}
		
	}
	
	self.flights = [[NSArray alloc] initWithArray:flightArr];
	
}

- (void)loadFavorites
{
	self.favorites = [[NSMutableArray alloc] init];
	
	NSMutableArray *faves = [NSMutableArray arrayWithArray:[DataArchiver retrieveDataFromFileName:DATA_FAVORITES_FILENAME]];
	
	if(faves != nil)
	{		
		for(Airport *airport in faves)
		{
			[self.favorites addObject:airport];
		}
	}
	
}

- (BOOL)addFavorite:(Airport *)favorite
{
	if(![self.favorites containsObject:favorite])
	{
		[self.favorites addObject:favorite];
		[DataArchiver saveData:self.favorites toFileName:DATA_FAVORITES_FILENAME];
		return YES;
	}
	else
	{
		return NO;
	}
}

- (void)removeFavorite:(Airport *)favorite
{
	[self.favorites removeObject:favorite];
	[DataArchiver saveData:self.favorites toFileName:DATA_FAVORITES_FILENAME];
}

- (BOOL)isFavorite:(Airport *)airport
{
	for(Airport *aPort in self.favorites)
	{
		if([aPort.code isEqualToString:airport.code])
			return YES;
	}
	
	return NO;
}

@end
