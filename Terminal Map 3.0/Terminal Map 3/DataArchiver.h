//
//  DataArchiver.h
//  SimplyOrganic-iPad
//
//  Created by jennifer-duffey on 1/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataArchiver : NSObject 
{
	
}

+ (NSString *)dataFilePathFromFileName:(NSString *)fileName;
+ (id)retrieveDataFromFileName:(NSString *)fileName;
+ (void)saveData:(id)data toFileName:(NSString *)str;

@end
