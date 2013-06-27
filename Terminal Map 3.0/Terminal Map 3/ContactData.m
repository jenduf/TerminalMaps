//
//  ContactData.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ContactData.h"

@implementation ContactData
@synthesize label = _label;
@synthesize address1 = _address1;
@synthesize address2 = _address2;

- (id)initWithDictionary:(NSDictionary *)dict
{
	self = [super init];
	if(self)
	{
		self.address1 = [dict objectForKey:@"address1"];
		self.address2 = [dict objectForKey:@"address2"];
		self.label = [dict objectForKey:@"label"];
		self.data = [[NSArray alloc] initWithArray:[self parseDataArrayWithDictionary:dict]];
	}
	
	return self;
}

+ (id)contactFromDictionary:(NSDictionary *)dict
{
	ContactData *contactData = [[self alloc] init];
	contactData.label = [dict objectForKey:@"label"];
	//contactData.data = [[NSArray alloc] initWithArray:[self parseDataArrayWithDictionary:dict]];
	
	return contactData;
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.label forKey:@"label"];
	[encoder encodeObject:self.address1 forKey:@"address1"];
	[encoder encodeObject:self.address2 forKey:@"address2"];
	[encoder encodeObject:self.data forKey:@"data"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	if(self)
	{
		self.label = [decoder decodeObjectForKey:@"label"];
		self.address1 = [decoder decodeObjectForKey:@"address1"];
		self.address2 = [decoder decodeObjectForKey:@"address2"];
		self.data = [decoder decodeObjectForKey:@"data"];
	}
	
	return self;
}


@end
