//
//  CSLEvent.m
//  ArubaClient
//
//  Created by Ludovic Chenneberg on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CSLEvent.h"

@implementation CSLEvent
//@dynamic eventID, userID, name, description, from, to, url, 
//    note, location, coordinates, createdAt, updatedAt, price;
@synthesize eventID, userID, name, description, from, to, url, 
note, location, coordinates, createdAt, updatedAt, price, eventImage;

-(id)init {
    
    if (self == [super init]) {        
    }
    
    return self;
}

-(void)fetchEventImage{
    __block UIImage *img;
    
    NSURL *imgUrl = [NSURL URLWithString:@"http://www.nowhereelse.fr/wp-content/uploads/2012/01/apple-keynote-19-janvier-2012.jpg"];
    dispatch_queue_t downloadQ = dispatch_queue_create("download queue", NULL);
    dispatch_async(downloadQ, ^{
        NSData *data = [NSData dataWithContentsOfURL:imgUrl];
        if (data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                img= [UIImage imageWithData:data];
                self.eventImage = img;
                NSLog(@"Image loaded");
            });
            
        }
    });
    dispatch_release(downloadQ);
}

@end
