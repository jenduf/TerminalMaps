//
//  SearchItem.h
//  TerminalMaps
//
//  Created by Jennifer Duffey on 5/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SearchItem : NSObject 
{

}

@property (nonatomic, copy) NSString *itemName, *itemTerminal, *itemGate;
@property (nonatomic, strong) UIImage *icon;

+ (id)searchItemWithName:(NSString *)name atTerminal:(NSString *)terminal andGate:(NSString *)gate;

@end
