//
//  HotelData.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/16/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import "HotelData.h"

@implementation HotelData
@synthesize name = _name;
@synthesize icon = _icon;
@synthesize address1 = _address1;
@synthesize address2 = _address2;
@synthesize address3 = _address3;

- (id)initWithDictionary:(NSDictionary *)dict
{
	self = [super init];
	
	if(self)
	{
		self.name = [dict objectForKey:@"name"];
		self.icon = [dict objectForKey:@"icon"];
		self.address1 = [dict objectForKey:@"address1"];
		self.address2 = [dict objectForKey:@"address2"];
		self.address3 = [dict objectForKey:@"address3"];
		self.data = [[NSArray alloc] initWithArray:[self parseDataArrayWithDictionary:dict]];
	
	}
	return self;
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.icon forKey:@"icon"];
	[encoder encodeObject:self.address1 forKey:@"address1"];
	[encoder encodeObject:self.address2 forKey:@"address2"];
	[encoder encodeObject:self.address3 forKey:@"address3"];
	[encoder encodeObject:self.data forKey:@"data"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	if(self)
	{
		self.name = [decoder decodeObjectForKey:@"name"];
		self.icon = [decoder decodeObjectForKey:@"icon"];
		self.address1 = [decoder decodeObjectForKey:@"address1"];
		self.address2 = [decoder decodeObjectForKey:@"address2"];
		self.address3 = [decoder decodeObjectForKey:@"address3"];
		self.data = [decoder decodeObjectForKey:@"data"];
	}
	
	return self;
}

@end
