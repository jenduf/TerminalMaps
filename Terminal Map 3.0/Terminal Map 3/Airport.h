//
//  Airport.h
//  TerminalMaps
//
//  Created by Jennifer Duffey on 5/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AirportDetails;
@interface Airport : NSObject 
{

}

@property (nonatomic, strong) NSString *code, *name, *city;
@property (nonatomic, assign) BOOL showDownload, downloadAvailable, syncAvailable;
@property (nonatomic, assign) NSInteger sectionNumber;
@property (nonatomic, strong) AirportDetails *airportDetails;

- (id)initWithCode:(NSString *)c andName:(NSString *)n forCity:(NSString *)ci;
+ (id)airportFromDictionary:(NSDictionary *)dict;

@end
