//
//  Flight.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Flight.h"

@implementation Flight
@synthesize flightNumber = _flightNumber;
@synthesize gate = _gate;
@synthesize airline = _airline;
@synthesize origin = _origin;
@synthesize destination = _destination;
@synthesize arriveTime = _arriveTime;
@synthesize departTime = _departTime;
@synthesize scheduledTime = _scheduledTime;
@synthesize status = _status;

- (id)initWithDictionary:(NSDictionary *)dict
{
	self = [super init];
	if(self)
	{
		self.flightNumber = [dict objectForKey:@"flightNumber"];
		self.gate = [dict objectForKey:@"gate"];
		self.airline = [dict objectForKey:@"airline"];
		self.origin = [dict objectForKey:@"origin"];
		self.destination = [dict objectForKey:@"destination"];
		self.arriveTime = [dict objectForKey:@"arriveTime"];
		self.departTime = [dict objectForKey:@"departTime"];
		self.scheduledTime = [dict objectForKey:@"scheduledTime"];
		self.status = [[dict valueForKey:@"status"] intValue];
	}
	
	return self;
}

@end
