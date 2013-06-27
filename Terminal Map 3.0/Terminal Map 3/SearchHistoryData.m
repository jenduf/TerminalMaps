//
//  SearchHistoryData.m
//  Terminal Map 3
//
//  Created by Jennifer Duffey on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchHistoryData.h"

@implementation SearchHistoryData
@synthesize keywords = _keywords;
@synthesize modifiedDate = _modifiedDate;

- (id)initWithKeywords:(NSString *)words
{
	self = [super init];
	
	if(self)
	{
		self.keywords = words;
		self.modifiedDate = [NSDate date];
	}
	
	return self;
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.keywords forKey:@"keywords"];
	[encoder encodeObject:self.modifiedDate forKey:@"modifiedDate"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	if(self)
	{
		self.keywords = [decoder decodeObjectForKey:@"keywords"];
		self.modifiedDate = [decoder decodeObjectForKey:@"modifiedDate"];
	}
	
	return self;
}

@end
