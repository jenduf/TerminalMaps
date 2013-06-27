//
//  Flight.h
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flight : NSObject

@property (nonatomic, strong) NSString *flightNumber, *airline, *gate, *origin, *destination, *departTime, *arriveTime, *scheduledTime;
@property (nonatomic, assign) int status;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
