//
//  MapData.h
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 10/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TerminalInfoData;
@interface MapData : NSObject
{
	
}

@property (nonatomic, copy) NSArray *gates, *text, *facilities;

- (id)initWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpGatesWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpTextWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpFacilitiesWithDictionary:(NSDictionary *)dict;
- (TerminalInfoData *)getGateByName:(NSString *)str;

@end
