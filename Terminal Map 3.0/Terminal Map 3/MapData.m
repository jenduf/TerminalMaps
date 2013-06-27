//
//  MapData.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 10/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MapData.h"
#import "Constants.h"
#import "TerminalInfoData.h"

@implementation MapData
@synthesize gates = _gates;
@synthesize text = _text;
@synthesize facilities = _facilities;

- (id)initWithDictionary:(NSDictionary *)dict
{
	self = [super init];
	
	if(self)
	{
		self.gates = [[NSArray alloc] initWithArray:[MapData setUpGatesWithDictionary:dict]];
     
		self.text = [[NSArray alloc] initWithArray:[MapData setUpTextWithDictionary:dict]];
		
		self.facilities = [[NSArray alloc] initWithArray:[MapData setUpFacilitiesWithDictionary:dict]];
	}
	
	return self;
}

- (TerminalInfoData *)getGateByName:(NSString *)str
{
	NSMutableArray *returnArray = [NSMutableArray array];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like[cd] %@", str];
	
	[returnArray addObjectsFromArray:[self.gates filteredArrayUsingPredicate:predicate]];
	
	TerminalInfoData *termInfoData = (TerminalInfoData *)[returnArray objectAtIndex:0];
	
	return termInfoData;
}

+ (NSArray *)setUpGatesWithDictionary:(NSDictionary *)dict
{
	// set up gates
	NSArray *gateArray = [NSArray arrayWithArray:[dict objectForKey:KEY_AIRPORT_GATES]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *gateDict in gateArray)
	{
		TerminalInfoData *gateData = [[TerminalInfoData alloc] initWithDictionary:gateDict];
		gateData.iconType = ICON_TYPE_GATE;
		[tempArray addObject:gateData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpTextWithDictionary:(NSDictionary *)dict
{
	// set up text
	NSArray *textArray = [NSArray arrayWithArray:[dict objectForKey:KEY_AIRPORT_TEXT]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *textDict in textArray)
	{
		TerminalInfoData *textData = [[TerminalInfoData alloc] initWithDictionary:textDict];
		textData.iconType = ICON_TYPE_TEXT;
		[tempArray addObject:textData];
	}
     
     return tempArray;
}

+ (NSArray *)setUpFacilitiesWithDictionary:(NSDictionary *)dict
{
	// set up facilities
	NSArray *facilitiesArray = [NSArray arrayWithArray:[dict objectForKey:KEY_AIRPORT_FACILITIES]];
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *facDict in facilitiesArray)
	{
		TerminalInfoData *facData = [[TerminalInfoData alloc] initWithDictionary:facDict];
		facData.iconType = [[facDict valueForKey:@"icon_type"] intValue];
		[tempArray addObject:facData];
	}
     
     return tempArray;
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.gates forKey:@"gates"];
	[encoder encodeObject:self.text forKey:@"text"];
	[encoder encodeObject:self.facilities forKey:@"facilities"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	if(self)
	{
		self.gates = [decoder decodeObjectForKey:@"gates"];
		self.text = [decoder decodeObjectForKey:@"text"];
		self.facilities = [decoder decodeObjectForKey:@"facilities"];
	}
	
	return self;
}



@end
