//
//  AirlineData.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/13/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import "AirlineData.h"

@implementation AirlineData
@synthesize name = _name;
@synthesize icon = _icon;
@synthesize gates = _gates;
@synthesize bag_claim = _bag_claim;

- (id)initWithDictionary:(NSDictionary *)dict
{
	self = [super init];
	if(self)
	{
		self.name = [dict objectForKey:@"name"];
		self.icon = [dict objectForKey:@"icon"];
		self.gates = [dict objectForKey:@"gates"];
		self.bag_claim = [dict objectForKey:@"bag_claim"];
		self.data = [[NSArray alloc] initWithArray:[self parseDataArrayWithDictionary:dict]];
	}
	
	return self;
}

+ (id)airlineFromDictionary:(NSDictionary *)dict
{
	AirlineData *airlineData = [[self alloc] init];
	airlineData.name = [dict objectForKey:@"name"];
	airlineData.icon = [dict objectForKey:@"icon"];
     airlineData.gates = [dict objectForKey:@"gates"];
     airlineData.bag_claim = [dict objectForKey:@"bag_claim"];
	//airlineData.data = [[NSArray alloc] initWithArray:[AirlineData parseDataArrayWithDictionary:dict]];
	
	return airlineData;
}


#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.icon forKey:@"icon"];
	[encoder encodeObject:self.gates forKey:@"gates"];
	[encoder encodeObject:self.bag_claim forKey:@"bag_claim"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	if(self)
	{
		self.name = [decoder decodeObjectForKey:@"name"];
		self.icon = [decoder decodeObjectForKey:@"icon"];
		self.gates = [decoder decodeObjectForKey:@"gates"];
		self.bag_claim = [decoder decodeObjectForKey:@"bag_claim"];
	}
	
	return self;
}

@end
