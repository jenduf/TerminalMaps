//
//  TerminalInfoData.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/17/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import "TerminalInfoData.h"

@implementation TerminalInfoData
@synthesize name = _name;
@synthesize gate = _gate;
@synthesize cellType = _cellType;
@synthesize sectionNumber = _sectionNumber;
@synthesize description = _description;
@synthesize level = _level;
@synthesize iconType = _iconType;
@synthesize iconX = _iconX;
@synthesize iconY = _iconY;

- (id)initWithDictionary:(NSDictionary *)dict
{
	self = [super init];
	
	if(self)
	{
		self.name = [dict objectForKey:@"name"];
		self.gate = [dict objectForKey:@"gate"];
		self.description = [dict objectForKey:@"description"];
		self.iconType = [[dict valueForKey:@"icon_type"] intValue];
		self.iconX = [[dict valueForKey:@"x"] floatValue];
		self.iconY = [[dict valueForKey:@"y"] floatValue];
	}
	
	return self;
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.gate forKey:@"gate"];
	[encoder encodeObject:self.description forKey:@"description"];
	[encoder encodeInt:self.iconType forKey:@"icon_type"];
	[encoder encodeInt:self.iconX forKey:@"iconX"];
	[encoder encodeInt:self.iconY forKey:@"iconY"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	if(self)
	{
		self.name = [decoder decodeObjectForKey:@"name"];
		self.gate = [decoder decodeObjectForKey:@"gate"];
		self.description = [decoder decodeObjectForKey:@"description"];
		self.iconType = [decoder decodeIntForKey:@"icon_type"];
		self.iconX = [decoder decodeIntForKey:@"iconX"];
		self.iconY = [decoder decodeIntForKey:@"iconY"];
	}
	
	return self;
}


@end
