//
//  PhoneData.h
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/13/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomCellData : NSObject

@property (nonatomic, copy) NSString *label, *number;
@property (nonatomic, assign) int cellType;

+ (id)cellDataFromDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;

@end
