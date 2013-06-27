//
//  SearchItem.m
//  TerminalMaps
//
//  Created by Jennifer Duffey on 5/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchItem.h"
#import "Constants.h"

@implementation SearchItem
@synthesize itemName = _itemName;
@synthesize itemGate = _itemGate;
@synthesize icon = _icon;
@synthesize itemTerminal = _itemTerminal;

+ (id)searchItemWithName:(NSString *)name atTerminal:(NSString *)terminal andGate:(NSString *)gate
{
	SearchItem *searchItem = [[self alloc] init];
	searchItem.itemName = name;
	searchItem.itemTerminal = terminal;
	searchItem.itemGate = gate;
	searchItem.icon = [UIImage imageNamed:ICON_MAGNIFYING_GLASS];
	return searchItem;
}
@end
