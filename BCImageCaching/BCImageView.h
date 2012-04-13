//
//  BCImageView.h
//  BCFramework
//
//  Created by Bitcode Technologies on 12/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCImage.h"

@interface BCImageView : UIImageView {
 
    NSString * _imageURL;
    NSString * _placeHolderImage;
    
}
+(BCImageView*)imageViewWithURL:(NSString*)_url placeHolderImage:(NSString*)_placeholder;

@property(nonatomic,retain) NSString * imageURL;
@property(nonatomic,retain) NSString * placeHolderImage;
@end
