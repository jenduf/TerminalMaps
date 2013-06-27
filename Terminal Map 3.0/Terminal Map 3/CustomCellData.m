//
//  PhoneData.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/13/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import "CustomCellData.h"

@implementation CustomCellData
@synthesize label = _label;
@synthesize number = _number;
@synthesize cellType = _cellType;

+ (id)cellDataFromDictionary:(NSDictionary *)dict
{
	CustomCellData *cellData = [[self alloc] init];
	cellData.label = [dict objectForKey:@"label"];
	cellData.number = [dict objectForKey:@"value"];
	cellData.cellType = [(NSNumber *)[dict objectForKey:@"cell_type"] intValue];
	
	return cellData;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
	self = [super init];
	
	if(self)
	{
		self.label = [dict objectForKey:@"label"];
		self.number = [dict objectForKey:@"value"];
		self.cellType = [(NSNumber *)[dict objectForKey:@"cell_type"] intValue];
	}
	
	return self;
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.label forKey:@"label"];
	[encoder encodeObject:self.number forKey:@"number"];
	[encoder encodeInt:self.cellType forKey:@"cell_type"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	if(self)
	{
		self.label = [decoder decodeObjectForKey:@"label"];
		self.number = [decoder decodeObjectForKey:@"number"];
		self.cellType = [decoder decodeIntForKey:@"cell_type"];
	}
	
	return self;
}

@end
