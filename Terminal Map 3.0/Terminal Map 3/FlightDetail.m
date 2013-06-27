//
//  FlightDetail.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/16/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import "FlightDetail.h"

@implementation FlightDetail
@synthesize city = _city;
@synthesize time = _time;
@synthesize airline = _airline;
@synthesize flight_number = _flight_number;
@synthesize status = _status;

- (id)initWithDictionary:(NSDictionary *)dict
{
	self = [super init];
	
	if(self)
	{
		self.city = [dict objectForKey:@"city"];
		self.time = [dict objectForKey:@"time"];
		self.airline = [dict objectForKey:@"airline"];
		self.flight_number = (NSNumber *)[dict objectForKey:@"flight_number"];
		self.status = [dict objectForKey:@"status"];
	}
	
	return self;
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.city forKey:@"city"];
	[encoder encodeObject:self.time forKey:@"time"];
	[encoder encodeObject:self.airline forKey:@"airline"];
	[encoder encodeObject:self.flight_number forKey:@"flight_number"];
	[encoder encodeObject:self.status forKey:@"status"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	if(self)
	{
		self.city = [decoder decodeObjectForKey:@"city"];
		self.time = [decoder decodeObjectForKey:@"time"];
		self.airline = [decoder decodeObjectForKey:@"airline"];
		self.flight_number = [decoder decodeObjectForKey:@"flight_number"];
		self.status = [decoder decodeObjectForKey:@"status"];
	}
	
	return self;
}

@end
