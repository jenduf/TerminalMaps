//
//  DataArchiver.m
//  SimplyOrganic-iPad
//
//  Created by jennifer-duffey on 1/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataArchiver.h"

@implementation DataArchiver

+ (id)retrieveDataFromFileName:(NSString *)fileName
{
	
	NSObject *archivedObject = [NSKeyedUnarchiver unarchiveObjectWithFile:[self dataFilePathFromFileName:fileName]];
	
	return archivedObject;
}

+ (void)saveData:(id)data toFileName:(NSString *)str
{	
	
	NSString *filePath = [self dataFilePathFromFileName:str];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if([fileManager fileExistsAtPath:filePath])
	{
		NSLog(@"File exists");
	}
	
	[NSKeyedArchiver archiveRootObject:data toFile:filePath];
}

+ (NSString *)dataFilePathFromFileName:(NSString *)fileName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [paths objectAtIndex:0];
	
	return [documentDirectory stringByAppendingPathComponent:fileName];
}

@end
