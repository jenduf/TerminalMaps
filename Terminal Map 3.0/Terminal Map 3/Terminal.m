//
//  Terminal.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Terminal.h"
#import "TerminalDetails.h"

@implementation Terminal
@synthesize name = _name;
@synthesize terminalDetails = _terminalDetails;

- (id)initWithDictionary:(NSDictionary *)dict
{
	self = [super init];
	
	if(self)
	{
		self.name = [dict objectForKey:@"name"];
		self.terminalDetails = [TerminalDetails getDetailsFromDictionary:dict];
	}
	
	return self;
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.terminalDetails forKey:@"terminalDetails"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	if(self)
	{
		self.name = [decoder decodeObjectForKey:@"name"];
		self.terminalDetails = [decoder decodeObjectForKey:@"terminalDetails"];
	}
	
	return self;
}

@end
