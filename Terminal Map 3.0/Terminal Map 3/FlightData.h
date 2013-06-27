//
//  FlightData.h
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/16/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoData.h"

@interface FlightData : InfoData

@property (nonatomic, copy) NSString *name, *average_wait;
@property (nonatomic, copy) NSArray *departures, *arrivals;
@property (nonatomic, assign) int currentSection;

- (id)initWithDictionary:(NSDictionary *)dict;
- (NSArray *)parseFlightDataArrayWithDictionary:(NSDictionary *)dict andKey:(NSString *)key;

@end
