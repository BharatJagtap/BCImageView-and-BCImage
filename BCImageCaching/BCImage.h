//
//  BCImage.h
//  BCFramework
//
//  Created by Bitcode Technologies on 12/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BCImage : UIImage {
    
    NSString * _imageURL;
    
}
@property(nonatomic,retain) NSString * imageURL;
+(BCImage*)imageWithURL:(NSString*)_url;
+(BOOL)flushCacheDirectory;
@end
