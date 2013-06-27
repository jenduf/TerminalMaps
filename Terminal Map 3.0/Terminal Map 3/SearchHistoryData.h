//
//  SearchHistoryData.h
//  Terminal Map 3
//
//  Created by Jennifer Duffey on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchHistoryData : NSObject

@property (nonatomic, strong) NSString *keywords;
@property (nonatomic, strong) NSDate *modifiedDate;

- (id)initWithKeywords:(NSString *)words;

@end
