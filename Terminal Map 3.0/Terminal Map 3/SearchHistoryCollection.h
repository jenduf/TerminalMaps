//
//  SearchHistoryCollection.h
//  Terminal Map 3
//
//  Created by Jennifer Duffey on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchHistoryData;
@interface SearchHistoryCollection : NSObject

@property (nonatomic, copy) NSMutableArray *masterSearchHistoryList;

- (unsigned)countOfList;
- (SearchHistoryData *)objectInListAtIndex:(unsigned)theIndex;
- (void)addSearchHistoryDataWithKeywords:(NSString *)words;

@end
