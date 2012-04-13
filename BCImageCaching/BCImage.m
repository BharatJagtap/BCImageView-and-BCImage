//
//  BCImage.m
//  BCFramework
//
//  Created by Bitcode Technologies on 12/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BCImage.h"


// specify the Cache Image directory path
#define kBCImageCacheDirectoyName @"BCImageCache"

BOOL imageCachedDirecoryExist = NO;
NSString * BCImageCacheDirectory = nil;

@interface BCImage (BCImagePrivateMethods)

+(void)createCacheDirectory;
+(NSString*)directoryFromFilePath:(NSString*)filePath;

@end


@implementation BCImage

@synthesize imageURL;

+(BCImage*)imageWithURL:(NSString*)_url
{
    if (imageCachedDirecoryExist == NO) {
        [BCImage createCacheDirectory];
    }
    
    BCImage * image;
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString * imageFilePath = [BCImageCacheDirectory stringByAppendingPathComponent:_url];
    if ([fileManager fileExistsAtPath:imageFilePath]) {
        
        NSData * imageData = [NSData dataWithContentsOfFile:imageFilePath];
        image = [[BCImage alloc] initWithData:imageData];
        
        NSLog(@"<BCImage>Loaded image from cache directory . . .");
        return [image autorelease];
    }
    else
    {
       NSLog(@"<BCImage>Loaded image from URL . . .");
        NSData * imageURLdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:_url]];
        image = [[BCImage alloc] initWithData:imageURLdata];

        
        NSString * directoryPath = [BCImage directoryFromFilePath:imageFilePath];
        NSError * directoryError = nil;
        
        [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&directoryError];
        if (directoryError != nil ) {
            NSLog(@"Directory creation Error : %@", [directoryError localizedDescription]);
        }
                   
         
        NSLog(@"writting image to file : %@",imageFilePath);
        
        NSError * writtingError = nil;

        [imageURLdata writeToFile:imageFilePath options:NSDataWritingFileProtectionNone error:&writtingError];
        if (writtingError != nil ) {
            NSLog(@"File Writting Error : %@ ",[writtingError localizedDescription]);
        }
        
        return [image autorelease];
        
    }
    
}

+(void)createCacheDirectory
{
    
    NSString * documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString * cacheDirectory = [documentsDirectory stringByAppendingPathComponent:kBCImageCacheDirectoyName];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSError * error = nil;

    
    [fileManager createDirectoryAtPath:cacheDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    if (error != nil ) {
        NSLog(@"failed to create cache directoriy");
        return;
    }
    NSLog(@"created cache directory : %@",cacheDirectory);
    imageCachedDirecoryExist = YES;
    if (BCImageCacheDirectory == nil ) {
        BCImageCacheDirectory = [[NSString alloc]initWithFormat:@"%@",cacheDirectory];
    }
      
}

+(NSString*)directoryFromFilePath:(NSString*)filePath
{
    
    NSArray * components = [filePath componentsSeparatedByString:@"/"];
    NSString * lastComponent = [components lastObject];
    NSString * finalString = [filePath stringByReplacingOccurrencesOfString:lastComponent withString:@""];
    return finalString;
 
}


+(BOOL)flushCacheDirectory
{
    
    NSString * documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString * cacheDirectory = [documentsDirectory stringByAppendingPathComponent:kBCImageCacheDirectoyName];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSError * error = nil;
    
    [fileManager removeItemAtPath:cacheDirectory error:&error];
    
    if (error != nil) {
        NSLog(@"<BCImage>Error removing cache directory ( %@ )",[error localizedDescription]);
        return NO;
    }
    return YES;
    
}

-(void)dealloc
{
    self.imageURL = nil;
    [super dealloc];
}
@end
