//
//  BCImageView.m
//  BCFramework
//
//  Created by Bitcode Technologies on 12/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BCImageView.h"


@implementation BCImageView
@synthesize imageURL=_imageURL;
@synthesize placeHolderImage = _placeHolderImage;

+(BCImageView*)imageViewWithURL:(NSString*)_url placeHolderImage:(NSString*)_placeholder
{
    
    BCImageView * imageView = [[BCImageView alloc]init];
    imageView.imageURL = _url;
    imageView.placeHolderImage = _placeholder;
    
    if (_placeholder != nil ) {
        imageView.image = [UIImage imageNamed:imageView.placeHolderImage];
    }
    
    [NSThread detachNewThreadSelector:@selector(loadImage:) toTarget:imageView withObject:nil];

    return [imageView autorelease];
    
}

-(void)loadImage:(NSThread*)thread
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    BCImage * image = [BCImage imageWithURL:self.imageURL];
    self.image = image;
    [pool release];  
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    self.placeHolderImage = nil;
    self.imageURL = nil;
    [super dealloc];
}

@end
