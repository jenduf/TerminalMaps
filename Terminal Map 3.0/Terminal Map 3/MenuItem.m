//
//  MenuItem.m
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/12/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import "MenuItem.h"
#import "Constants.h"
#import "Utils.h"

@implementation MenuItem
@synthesize title = _title;
@synthesize icon = _icon;
@synthesize itemType = _itemType;

+ (id)menuItemWithTitle:(NSString *)t andType:(int)it
{
	MenuItem *menuItem = [[self alloc] init];
	menuItem.title = t;
	menuItem.itemType = it;
	menuItem.icon = [Utils determineIconFromType:it];
	
	return menuItem;
}

@end
