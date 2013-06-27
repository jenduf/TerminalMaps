//
//  Airport.m
//  TerminalMaps
//
//  Created by Jennifer Duffey on 5/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Airport.h"
#import "AirportDetails.h"

@implementation Airport
@synthesize code = _code;
@synthesize name = _name;
@synthesize city = _city;
@synthesize showDownload = _showDownload;
@synthesize downloadAvailable = _downloadAvailable;
@synthesize sectionNumber = _sectionNumber;
@synthesize airportDetails = _airportDetails;
@synthesize syncAvailable = _syncAvailable;


- (id)initWithCode:(NSString *)c andName:(NSString *)n forCity:(NSString *)ci
{
	self = [super init];
	
	if(self)
	{
		self.code = c;
		self.name = n;
		self.city = ci;
		self.showDownload = NO;
		self.downloadAvailable = NO;
		self.syncAvailable = NO;
	}
	
	return self;
}

+ (id)airportFromDictionary:(NSDictionary *)dict
{
	for(NSString *key in [dict allKeys])
	{
	     //     NSLog(@"Key: %@", key);
	     //     NSLog(@"Value: %@", [dict valueForKey:key]);
	}
     
	Airport *airport = [[self alloc] init];
	airport.code = [dict objectForKey:@"code"];
	airport.city = [dict objectForKey:@"city"];
	airport.name = [dict objectForKey:@"name"];
	airport.downloadAvailable = [[dict valueForKey:@"download"] boolValue];
	airport.syncAvailable = [[dict valueForKey:@"sync"] boolValue];
	airport.airportDetails = [AirportDetails getDetailsFromDictionary:dict];
     
	return airport;
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.code forKey:@"code"];
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.city forKey:@"city"];
	[encoder encodeObject:self.airportDetails forKey:@"airportDetails"];
	[encoder encodeBool:self.downloadAvailable forKey:@"download"];
	[encoder encodeBool:self.syncAvailable forKey:@"sync"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	if(self)
	{
		self.code = [decoder decodeObjectForKey:@"code"];
		self.name = [decoder decodeObjectForKey:@"name"];
		self.city = [decoder decodeObjectForKey:@"city"];
		self.airportDetails = [decoder decodeObjectForKey:@"airportDetails"];
		self.downloadAvailable = [decoder decodeBoolForKey:@"download"];
		self.syncAvailable = [decoder decodeBoolForKey:@"sync"];
	}
	
	return self;
}


@end
