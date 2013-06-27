//
//  FlightData.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/16/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import "FlightData.h"
#import "Constants.h"
#import "FlightDetail.h"

@implementation FlightData
@synthesize name = _name;
@synthesize average_wait = _average_wait;
@synthesize departures = _departures;
@synthesize arrivals = _arrivals;
@synthesize currentSection = _currentSection;

- (id)initWithDictionary:(NSDictionary *)dict
{
	self = [super init];
	if(self)
	{
		self.name = [dict objectForKey:@"name"];
		self.average_wait = [dict objectForKey:@"average_wait"];
		self.departures = [[NSArray alloc] initWithArray:[self parseFlightDataArrayWithDictionary:dict andKey:KEY_AIRPORT_DEPARTURES]];
		self.arrivals = [[NSArray alloc] initWithArray:[self parseFlightDataArrayWithDictionary:dict andKey:KEY_AIRPORT_ARRIVALS]];
	}
	
	return self;
}

- (NSArray *)parseFlightDataArrayWithDictionary:(NSDictionary *)dict andKey:(NSString *)key
{
	// set up departure flight data
	NSArray *departureArr = [NSArray arrayWithArray:[dict objectForKey:key]];
	
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *flightDict in departureArr)
	{
		FlightDetail *flightDetail = [[FlightDetail alloc] initWithDictionary:flightDict];
		[tempArray addObject:flightDetail];
	}
     
     return tempArray;
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.average_wait forKey:@"average_wait"];
	[encoder encodeObject:self.departures forKey:@"departures"];
	[encoder encodeObject:self.arrivals forKey:@"arrivals"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	if(self)
	{
		self.name = [decoder decodeObjectForKey:@"name"];
		self.average_wait = [decoder decodeObjectForKey:@"average_wait"];
		self.departures = [decoder decodeObjectForKey:@"departures"];
		self.arrivals = [decoder decodeObjectForKey:@"arrivals"];
	}
	
	return self;
}

@end
