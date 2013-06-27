//
//  Utils.m
//  TerminalMaps
//
//  Created by Jennifer Duffey on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"
#import "Constants.h"
#import "SearchItem.h"
#import <QuartzCore/QuartzCore.h>

@implementation Utils

+ (NSString *)getProperXIBNameForDeviceType:(NSString *)xib
{
	NSString *returnString;
	
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		returnString = [NSString stringWithFormat:@"%@_iPad", xib];
	else
		returnString = xib;
	
	return returnString;
}

+ (NSArray *)parseAllContent
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"coordinates" ofType:@"plist"];
	NSDictionary *coordDict = [NSDictionary dictionaryWithContentsOfFile:path];
	NSDictionary *searchDictionary = [[NSDictionary alloc] initWithDictionary:[coordDict objectForKey:@"food_and_shopping"]];
	
	NSMutableArray *allContent = [NSMutableArray array];
	
	for(NSString *key in searchDictionary)
	{
		NSDictionary *dict = [searchDictionary objectForKey:key];
		NSArray *items = [NSArray arrayWithArray:[dict objectForKey:@"items"]];
		
		for(NSDictionary *itemDict in items)
		{
			NSString *itemName = [itemDict objectForKey:@"name"];
			NSString *terminalName = [itemDict objectForKey:@"terminal"];
			NSString *gateName = [itemDict objectForKey:@"gate"];
			
			SearchItem *searchItem = [SearchItem searchItemWithName:itemName atTerminal:terminalName andGate:gateName];
			[allContent addObject:searchItem];
		}
	}
	
	return allContent;
}

+ (UIImage *)determineIconFromType:(int)type
{
     UIImage *returnImage;
     
     switch (type) 
     {
          case MENU_ITEM_AIRPORT_A_TO_Z:
          case MENU_ITEM_NEARBY_AIRPORTS:
               returnImage = [UIImage imageNamed:ICON_MAP];
               break;
               
          default:
               break;
     }
     
     return returnImage;
}

+ (NSDictionary *)getMenuItemsForView:(int)viewIndex
{
	NSMutableDictionary *returnDict = [NSMutableDictionary dictionary];
	
	switch(viewIndex)
	{
		case OVERVIEW_VIEW:
		{
			NSArray *viewMenuArray = [NSArray arrayWithObjects:@"Interactive Map", @"Airport Info", nil];
			[returnDict setValue:viewMenuArray forKey:@"  Menu"];
			
			NSArray *settingsArray = [NSArray arrayWithObjects:@"Settings", @"About MapSpot", nil];
			[returnDict setValue:settingsArray forKey:@"  Application Settings"];
		}
			break;
			
		case INTERACTIVE_MAP_VIEW:
			//NSArray *settingsArray = [NSArray arrayWithObjects:@"Legend", @"Terminals", @"Floors", @"Terminal Info", @"Settings", nil];
			break;
			
		case INFO_VIEW:
			break;
			
		default:
			break;
	}
	
	return returnDict;
}

/*+ (UIImage *)getIconForAirline:(int)airline
{
	UIImage *btnImage;
	
	switch(airline)
	{
		case AIRLINE_AMERICAN:
			btnImage = [UIImage imageNamed:ICON_MAP];
			break;
		case AIRLINE_CANADA:
			btnImage = [UIImage imageNamed:ICON_MAGNIFYING_GLASS];
			break;
		case AIRLINE_LUFTHANSA:
			btnImage = [UIImage imageNamed:ICON_WORLD];
			break;
		case AIRLINE_BRITISH:
			btnImage = [UIImage imageNamed:ICON_PHONE];
			break;
	}
	
	return btnImage;
}*/

+ (NSString *)getIconForWeatherCode:(int)code
{
	switch(code)
	{
		case FORECAST_CLEAR:
		case	FORECAST_ICE_PELLETS:
			break;
			
		case FORECAST_PARTLY_CLOUDY:
		case FORECAST_CLOUDY:
		case FORECAST_OVERCAST:
			code = FORECAST_PARTLY_CLOUDY;
			break;
			
		case FORECAST_FOG:
		case FORECAST_MIST:
		case FORECAST_FREEZING_FOG:
			code = FORECAST_FOG;
			break;
			
		case FORECAST_OCCASIONAL_RAIN:
		case FORECAST_OCCASIONAL_DRIZZLE:
		case FORECAST_LIGHT_DRIZZLE:
		case FORECAST_OCCASIONAL_LIGHT_RAIN:
		case FORECAST_LIGHT_RAIN:
		case FORECAST_OCCASIONAL_MODERATE_RAIN:
		case FORECAST_LIGHT_RAIN_SHOWER:
			code = FORECAST_LIGHT_RAIN;
			break;
			
		case FORECAST_MODERATE_RAIN:
		case FORECAST_OCCASIONAL_HEAVY_RAIN:
		case FORECAST_HEAVY_RAIN:
		case FORECAST_MODERATE_RAIN_SHOWER:
		case FORECAST_TORRENTIAL_RAIN_SHOWER:
			code = FORECAST_HEAVY_RAIN;
			break;
			
		case FORECAST_THUNDER:
		case FORECAST_OCCASIONAL_RAIN_THUNDER:
		case FORECAST_MODERATE_RAIN_THUNDER:
			code = FORECAST_THUNDER;
			break;
			
		case FORECAST_OCCASIONAL_SLEET:
		case FORECAST_FREEZING_DRIZZLE:
		case FORECAST_HEAVY_FREEZING_DRIZZLE:
		case FORECAST_LIGHT_FREEZING_RAIN:
		case FORECAST_MODERATE_FREEZING_RAIN:
		case FORECAST_LIGHT_SLEET:
		case FORECAST_MODERATE_SLEET:
		
		case FORECAST_LIGHT_SLEET_SHOWER:
		case FORECAST_MODERATE_SLEET_SHOWER:
		case FORECAST_LIGHT_ICE_SHOWER:
		case FORECAST_MODERATE_ICE_SHOWER:
		case FORECAST_OCCASIONAL_SNOW:
		case FORECAST_BLOWING_SNOW:
		case FORECAST_OCCASIONAL_LIGHT_SNOW:
		case FORECAST_LIGHT_SNOW:
		case FORECAST_OCCASIONAL_MODERATE_SNOW:
		case FORECAST_LIGHT_SNOW_SHOWER:
			code = FORECAST_LIGHT_SNOW;
			break;
			
		
		case FORECAST_BLIZZARD:
		case FORECAST_MODERATE_SNOW:
		case FORECAST_OCCASIONAL_HEAVY_SNOW:
		case FORECAST_HEAVY_SNOW:
		case FORECAST_MODERATE_SNOW_SHOWER:
			code = FORECAST_HEAVY_SNOW;
			break;
			
		case FORECAST_LIGHT_SNOW_THUNDER:
		case FORECAST_MODERATE_SNOW_THUNDER:
			code = FORECAST_LIGHT_SNOW_THUNDER;
			break;
	}
	
	return  [NSString stringWithFormat:@"weather_%i.png", code];
}

+ (NSString*)getTimeStrFromDate:(NSDate*)date
{
	NSString* ret;
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"h:mm a"];
	ret = [formatter stringFromDate:date];
	
	return ret;
}

+ (void)animateView:(UIView *)viewToAnimate from:(id)target to:(CGPoint)newPoint
{
     CGRect endFrame = CGRectMake(newPoint.x, newPoint.y, viewToAnimate.frame.size.width, viewToAnimate.frame.size.height);

     //[viewToAnimate setFrame:startFrame];

     [UIView beginAnimations:nil context:nil];
     [UIView setAnimationDuration:0.5];
     [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
     [UIView setAnimationDidStopSelector:nil];
     [UIView setAnimationDelegate:target];
     [viewToAnimate setFrame:endFrame];
     [UIView commitAnimations];
}

+ (void)fadeViewInLayer:(CALayer *)layer withProperty:(NSString *)property andName:(NSString *)name fromValue:(float)fromValue toValue:(float)toValue withDelegate:(id)del
{						
	CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:property];
	[basicAnimation setValue:name forKey:@"name"];
	[basicAnimation setFromValue:[NSNumber numberWithFloat:fromValue]];
	[basicAnimation setToValue:[NSNumber numberWithFloat:toValue]];
	[basicAnimation setDelegate:del];
	[basicAnimation setAutoreverses:NO];
	[basicAnimation setRemovedOnCompletion:YES];
	[layer addAnimation:basicAnimation forKey:property];
}

+ (void)animateViewWithTransition:(NSString *)_trans andSubTrans:(NSString *)_subTrans andName:(NSString *)_nameString inLayer:(CALayer *)_layer withDelegate:(id)del
{
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:_trans];
	[animation setSubtype:_subTrans];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	[animation setDelegate:del];
	[_layer addAnimation:animation forKey:_nameString];
}

@end
