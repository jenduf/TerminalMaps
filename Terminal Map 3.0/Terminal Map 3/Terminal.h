//
//  Terminal.h
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TerminalDetails;
@interface Terminal : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) TerminalDetails *terminalDetails;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
