//
//  AirportDB.h
//  Terminal Maps 2
//
//  Created by Jennifer Duffey on 10/25/11.
//  Copyright (c) 2011 Blockdot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Airport, Terminal;
@interface AirportDB : NSObject

@property (strong) NSArray *airports, *flights;
@property (strong, nonatomic) NSMutableArray *favorites;
@property (strong, nonatomic) Airport *currentAirport;
@property (strong, nonatomic) Terminal *currentTerminal;

+ (AirportDB *)sharedDatabase;
- (BOOL)isFavorite:(Airport *)airport;
- (void)loadAirports;
- (BOOL)addFavorite:(Airport *)favorite;
- (void)removeFavorite:(Airport *)favorite;
- (void)loadFavorites;
- (void)loadFlights;

@end
