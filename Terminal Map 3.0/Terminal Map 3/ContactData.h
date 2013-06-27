//
//  ContactData.h
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoData.h"

@interface ContactData : InfoData

@property (nonatomic, copy) NSString *label, *address1, *address2;

+ (id)contactFromDictionary:(NSDictionary *)dict;
- (id)initWithCode:(NSString *)c andName:(NSString *)n forCity:(NSString *)ci;

@end
