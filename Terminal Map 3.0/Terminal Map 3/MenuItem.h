//
//  MenuItem.h
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/12/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject
{

}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, assign) int itemType;

+ (id)menuItemWithTitle:(NSString *)t andType:(int)it;

@end
