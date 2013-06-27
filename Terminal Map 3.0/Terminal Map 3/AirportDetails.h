//
//  AirportDetails.h
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 9/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MapData;
@interface AirportDetails : NSObject

@property (nonatomic, strong) MapData *mapData;
@property (nonatomic, copy) NSArray *airlines, *contacts, *flights, *hotels, *parking, *transportation, *terminals;

+ (id)getDetailsFromDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpContactsWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpAirlinesWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpFlightsWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpHotelsWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpParkingWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpTransportationWithDictionary:(NSDictionary *)dict;
+ (NSArray *)setUpTerminalsWithDictionary:(NSDictionary *)dict;
+ (MapData *)setUpCoordinatesWithDictionary:(NSDictionary *)dict;
- (NSArray *)getAirportIconsForFloor:(int)floor;
- (NSArray *)getAirportIconsForZoomLevel:(int)zoomLevel;
- (NSArray *)getAllLocationsForAmenityName:(NSString *)name;
- (NSArray *)toggleIconsAtIndex:(int)index makeVisible:(BOOL)visible;
- (NSArray *)getAllIcons;

@end
