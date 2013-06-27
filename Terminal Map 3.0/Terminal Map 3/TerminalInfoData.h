//
//  TerminalInfoData.h
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/17/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TerminalInfoData : NSObject

@property (nonatomic, assign) int cellType, sectionNumber;
@property (nonatomic, copy) NSString *name, *gate, *description;
@property (nonatomic, assign) int iconType, level;
@property (nonatomic, assign) float iconX, iconY;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
