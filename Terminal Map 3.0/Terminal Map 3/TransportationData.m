//
//  TransportationData.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/16/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import "TransportationData.h"

@implementation TransportationData
@synthesize name = _name;
@synthesize text = _text;

- (id)initWithDictionary:(NSDictionary *)dict
{
	self = [super init];
	
	if(self)
	{
		self.name = [dict objectForKey:@"name"];
		self.text = [dict objectForKey:@"text"];
		self.data = [[NSArray alloc] initWithArray:[self parseDataArrayWithDictionary:dict]];
		
	}
	return self;
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.text forKey:@"text"];
	[encoder encodeObject:self.data forKey:@"data"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	if(self)
	{
		self.name = [decoder decodeObjectForKey:@"name"];
		self.text = [decoder decodeObjectForKey:@"text"];
		self.data = [decoder decodeObjectForKey:@"data"];
	}
	
	return self;
}

@end
