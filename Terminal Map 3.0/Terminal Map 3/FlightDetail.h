//
//  FlightDetail.h
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/16/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightDetail : NSObject

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSNumber *airline, *flight_number, *status;
@property (nonatomic, copy) NSDate *time;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
