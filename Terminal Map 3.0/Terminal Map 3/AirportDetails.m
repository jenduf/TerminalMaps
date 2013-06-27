//
//  AirportDetails.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AirportDetails.h"
#import "Constants.h"
#import "ContactData.h"
#import "AirlineData.h"
#import "FlightData.h"
#import "HotelData.h"
#import "TransportationData.h"
#import "ParkingData.h"
#import "Terminal.h"
#import "TerminalDetails.h"
#import "MapData.h"

@implementation AirportDetails
@synthesize airlines = _airlines;
@synthesize contacts = _contacts;
@synthesize flights = _flights;
@synthesize hotels = _hotels;
@synthesize parking = _parking;
@synthesize transportation = _transportation;
@synthesize terminals = _terminals;
@synthesize mapData = _mapData;

+ (id)getDetailsFromDictionary:(NSDictionary *)dict
{
     AirportDetails *airportDetails = [[self alloc] init];
	
	airportDetails.contacts = [[NSArray alloc] initWithArray:[AirportDetails setUpContactsWithDictionary:dict]];
     
	airportDetails.airlines = [[NSArray alloc] initWithArray:[AirportDetails setUpAirlinesWithDictionary:dict]];
	
	airportDetails.flights = [[NSArray alloc] initWithArray:[AirportDetails setUpFlightsWithDictionary:dict]];
	
	airportDetails.hotels = [[NSArray alloc] initWithArray:[AirportDetails setUpHotelsWithDictionary:dict]];
	
	airportDetails.parking = [[NSArray alloc] initWithArray:[AirportDetails setUpParkingWithDictionary:dict]];
	
	airportDetails.transportation = [[NSArray alloc] initWithArray:[AirportDetails setUpTransportationWithDictionary:dict]];
	
	airportDetails.terminals = [[NSArray alloc] initWithArray:[AirportDetails setUpTerminalsWithDictionary:dict]];
	
	airportDetails.mapData = (MapData *)[AirportDetails setUpCoordinatesWithDictionary:dict];
	
	return airportDetails;
	
}

- (NSArray *)getAllIcons
{
	NSMutableArray *returnArray = [NSMutableArray array];
	
	for(Terminal *termData in self.terminals)
	{
		[returnArray addObjectsFromArray:[termData.terminalDetails buildArrayForIconsOnFloor:0]];
	}
	
	[returnArray addObjectsFromArray:self.mapData.gates];
	[returnArray addObjectsFromArray:self.mapData.facilities];
	
	return returnArray;
}

- (NSArray *)getAirportIconsForFloor:(int)floor
{
	NSMutableArray *returnArray = [NSMutableArray array];
	
	for(Terminal *termData in self.terminals)
	{
		[returnArray addObjectsFromArray:[termData.terminalDetails buildArrayForIconsOnFloor:floor]];
	}
	
	return returnArray;
}

- (NSArray *)getAirportIconsForZoomLevel:(int)zoomLevel
{
	NSMutableArray *returnArray = [NSMutableArray array];
	
	for(Terminal *terminal in self.terminals)
	{
		[returnArray addObjectsFromArray:[terminal.terminalDetails buildArrayForIconsAtZoomLevel:zoomLevel]];
	}
	
	return returnArray;
}

- (NSArray *)toggleIconsAtIndex:(int)index makeVisible:(BOOL)visible
{
	NSMutableArray *returnArray = [NSMutableArray array];
	
	for(Terminal *termData in self.terminals)
	{
		[returnArray addObjectsFromArray:[termData.terminalDetails toggleVisibilityForIconsAtIndex:index isVisible:visible]];
	}
	
	return returnArray;
}

- (NSArray *)getAllLocationsForAmenityName:(NSString *)name
{
	NSMutableArray *returnArray = [NSMutableArray array];
	
	for(Terminal *termData in self.terminals)
	{
		[returnArray addObjectsFromArray:[termData.terminalDetails getIconsByName:name]];
	}
	
	return returnArray;
}

+ (NSArray *)setUpContactsWithDictionary:(NSDictionary *)dict
{
     // set up contacts
	NSArray *contactArray = [NSArray arrayWithArray:[dict objectForKey:KEY_AIRPORT_CONTACTS]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *contactDict in contactArray)
	{
		ContactData *contactData = [[ContactData alloc] initWithDictionary:contactDict];
		[tempArray addObject:contactData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpAirlinesWithDictionary:(NSDictionary *)dict
{
     // set up airlines
	NSArray *airlineArr = [NSArray arrayWithArray:[dict objectForKey:KEY_AIRPORT_AIRLINES]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *airlineDict in airlineArr)
	{
		AirlineData *airlineData = [[AirlineData alloc] initWithDictionary:airlineDict];
		[tempArray addObject:airlineData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpFlightsWithDictionary:(NSDictionary *)dict
{
	// set up flights
	NSArray *flightsArr = [NSArray arrayWithArray:[dict objectForKey:KEY_AIRPORT_FLIGHTS]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *flightDict in flightsArr)
	{
		FlightData *flightData = [[FlightData alloc] initWithDictionary:flightDict];
		[tempArray addObject:flightData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpHotelsWithDictionary:(NSDictionary *)dict
{
	// set up hotels
	NSArray *hotelsArr = [NSArray arrayWithArray:[dict objectForKey:KEY_AIRPORT_HOTELS]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *hotelDict in hotelsArr)
	{
		HotelData *hotelData = [[HotelData alloc] initWithDictionary:hotelDict];
		[tempArray addObject:hotelData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpParkingWithDictionary:(NSDictionary *)dict
{
	// set up parking
	NSArray *parkingArr = [NSArray arrayWithArray:[dict objectForKey:KEY_AIRPORT_PARKING]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *parkingDict in parkingArr)
	{
		ParkingData *parkingData = [[ParkingData alloc] initWithDictionary:parkingDict];
		[tempArray addObject:parkingData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpTransportationWithDictionary:(NSDictionary *)dict
{
	// set up transportation
	NSArray *tranArr = [NSArray arrayWithArray:[dict objectForKey:KEY_AIRPORT_TRANSPORTATION]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *tranDict in tranArr)
	{
		TransportationData *tranData = [[TransportationData alloc] initWithDictionary:tranDict];
		[tempArray addObject:tranData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpTerminalsWithDictionary:(NSDictionary *)dict
{
	// set up terminals
	NSArray *termArr = [NSArray arrayWithArray:[dict objectForKey:KEY_AIRPORT_TERMINALS]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *termDict in termArr)
	{
		Terminal *terminalData = [[Terminal alloc] initWithDictionary:termDict];
		[tempArray addObject:terminalData];
	}
     
     return tempArray;
}

+ (MapData *)setUpCoordinatesWithDictionary:(NSDictionary *)dict
{
	// set up coordinates
	NSDictionary *coordDict = [NSDictionary dictionaryWithDictionary:[dict objectForKey:KEY_AIRPORT_COORDINATES]];
	MapData *mData = (MapData *)[[MapData alloc] initWithDictionary:coordDict];
	
	return mData;
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.airlines forKey:@"airlines"];
	[encoder encodeObject:self.contacts forKey:@"contacts"];
	[encoder encodeObject:self.flights forKey:@"flights"];
	[encoder encodeObject:self.hotels forKey:@"hotels"];
	[encoder encodeObject:self.parking forKey:@"parking"];
	[encoder encodeObject:self.transportation forKey:@"transportation"];
	[encoder encodeObject:self.terminals forKey:@"terminals"];
	[encoder encodeObject:self.mapData forKey:@"mapData"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	if(self)
	{
		self.airlines = [decoder decodeObjectForKey:@"airlines"];
		self.contacts = [decoder decodeObjectForKey:@"contacts"];
		self.flights = [decoder decodeObjectForKey:@"flights"];
		self.hotels = [decoder decodeObjectForKey:@"hotels"];
		self.parking = [decoder decodeObjectForKey:@"parking"];
		self.transportation = [decoder decodeObjectForKey:@"transportation"];
		self.terminals = [decoder decodeObjectForKey:@"terminals"];
		self.mapData = [decoder decodeObjectForKey:@"mapData"];
	}
	
	return self;
}

@end
