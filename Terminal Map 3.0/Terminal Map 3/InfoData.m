//
//  InfoData.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "InfoData.h"
#import "Constants.h"
#import "CustomCellData.h"

@implementation InfoData
@synthesize data = _data;
@synthesize label = _label;

- (NSArray *)parseDataArrayWithDictionary:(NSDictionary *)dict
{
     // set up contacts
	NSArray *dataArr = [NSArray arrayWithArray:[dict objectForKey:KEY_AIRPORT_AIRLINE_DATA]];
	
	if([dataArr count] == 0)
		return nil;
	
	NSMutableArray *tempArray = [NSMutableArray array];
	
	for(NSDictionary *cellDict in dataArr)
	{
		CustomCellData *cellData = [[CustomCellData alloc] initWithDictionary:cellDict];
		[tempArray addObject:cellData];
	}
     
     return tempArray;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
	// override
	return nil;
}

@end
