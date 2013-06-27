//
//  InfoData.h
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoData : NSObject
{
	
}

@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSString *label;

- (id)initWithDictionary:(NSDictionary *)dict;
- (NSArray *)parseDataArrayWithDictionary:(NSDictionary *)dict;

@end
