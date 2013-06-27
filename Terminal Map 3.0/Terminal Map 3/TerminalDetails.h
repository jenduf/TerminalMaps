//
//  TerminalDetails.h
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/17/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TerminalDetails : NSObject

@property (nonatomic, assign) BOOL hideClubs, hideAirlines, hideDrinks, hideHotels, hideParking, hideRestaurants, hideShops, hideServices, hideTransportation;
@property (nonatomic, copy) NSArray *airline_clubs, *airlines, *drinks, *flight_status, *hotels, *parking, *restaurants, *shops, *services, *transportation, *other, *atms;
@property (nonatomic, strong) NSMutableArray *currentlyDisplayedIcons;
@property (nonatomic, assign) int currentZoomLevel;

+ (id)getDetailsFromDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpClubsWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpAirlinesWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpDrinksWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpFlightStatusesWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpHotelsWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpParkingWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpRestaurantsWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpShopsWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpServicesWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpTransportationWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpATMSWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpOtherWithDictionary:(NSDictionary *)dict;

- (NSArray *)buildArrayForIconsOnFloor:(int)floor;
- (NSArray *)buildArrayForIconsAtZoomLevel:(int)zoom;
- (NSArray *)toggleVisibilityForIconsAtIndex:(int)index isVisible:(BOOL)visible;
- (BOOL)icons:(NSArray *)icons visibleOnFloor:(int)floor;
- (NSArray *)getIconsByName:(NSString *)str;

@end
