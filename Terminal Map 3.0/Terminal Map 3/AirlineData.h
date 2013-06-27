//
//  AirlineData.h
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/13/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoData.h"

@interface AirlineData : InfoData

@property (nonatomic, copy) NSString *name, *icon, *gates, *bag_claim;

+ (id)airlineFromDictionary:(NSDictionary *)dict;

@end
