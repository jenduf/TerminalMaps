//
//  Utils.h
//  TerminalMaps
//
//  Created by Jennifer Duffey on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Utils : NSObject 
{
    
}

+ (NSString *)getProperXIBNameForDeviceType:(NSString *)xib;
+ (NSArray *)filterContentFromArray:(NSArray *)searchArray forSearchText:(NSString *)searchText;
+ (NSArray *)filterContentFromArray:(NSArray *)searchArray forSearchText:(NSString *)searchText scope:(NSString *)scope;
+ (NSArray *)parseAllContent;
+ (NSDictionary *)getMenuItemsForView:(int)viewIndex;
+ (UIImage *)determineIconFromType:(int)type;
+ (UIImage *)getIconForCellType:(int)type;
//+ (UIImage *)getIconForAirline:(int)airline;
+ (NSString *)getFlightStatusStringFromIndex:(int)status;
+ (UIImage *)getFlightStatusImageFromIndex:(int)status;
+ (UIColor *)getStatusColorFromIndex:(int)status;
+ (NSString*)getTimeStrFromDate:(NSDate*)date;
+ (NSString *)getMapIconTitleFromType:(int)type;
+ (NSString *)getIconForIndex:(int)index;
+ (NSString *)getFloorNameForIndex:(int)index;
+ (NSString *)getTerminalNameForIndex:(int)index;
+ (NSString *)getIconForWeatherCode:(int)code;
+ (int)getTerminalTagFromString:(NSString *)str;
+ (void)fadeViewInLayer:(CALayer *)layer withProperty:(NSString *)property andName:(NSString *)name fromValue:(float)fromValue toValue:(float)toValue withDelegate:(id)del;
+ (void)animateView:(UIView *)viewToAnimate from:(id)target to:(CGPoint)newPoint;
+ (void)animateViewWithTransition:(NSString *)_trans andSubTrans:(NSString *)_subTrans andName:(NSString *)_nameString inLayer:(CALayer *)_layer withDelegate:(id)del;

@end
