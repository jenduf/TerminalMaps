//
//  SearchHistoryCollection.m
//  Terminal Map 3
//
//  Created by Jennifer Duffey on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchHistoryCollection.h"
#import "SearchHistoryData.h"
#import "DataArchiver.h"
#import "Constants.h"

@interface SearchHistoryCollection() 

- (void)initializeDefaultDataList;

@end

@implementation SearchHistoryCollection
@synthesize masterSearchHistoryList = _masterSearchHistoryList;

- (id)init
{
	self = [super init];
	
	if(self)
	{
		[self initializeDefaultDataList];
	}
	
	return self;
}

- (void)initializeDefaultDataList
{
	NSMutableArray *masterList = [NSMutableArray arrayWithArray:[DataArchiver retrieveDataFromFileName:DATA_SEARCH_HISTORY_FILENAME]];
	
	if(masterList == nil)
		masterList = [[NSMutableArray alloc] init];
	
	self.masterSearchHistoryList = masterList;
}

- (void)setMasterSearchHistoryList:(NSMutableArray *)newList
{
	if(_masterSearchHistoryList != newList)
		_masterSearchHistoryList = [newList mutableCopy];
}

- (unsigned)countOfList
{
	return [self.masterSearchHistoryList count];	
}

- (SearchHistoryData *)objectInListAtIndex:(unsigned)theIndex
{
	SearchHistoryData *searchData = (SearchHistoryData *)[self.masterSearchHistoryList objectAtIndex:theIndex];
	return searchData;
}

- (void)addSearchHistoryDataWithKeywords:(NSString *)words
{
	SearchHistoryData *searchHistoryData = [[SearchHistoryData alloc] initWithKeywords:words];
	[self.masterSearchHistoryList addObject:searchHistoryData];
	
	[DataArchiver saveData:self.masterSearchHistoryList toFileName:DATA_SEARCH_HISTORY_FILENAME];
}

@end
