//
//  CSLEvent.h
//  ArubaClient
//
//  Created by Ludovic Chenneberg on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

//@interface CSLEvent : NSManagedObject{
@interface CSLEvent : NSObject
    @property (nonatomic, retain) NSString* eventID;
    @property (nonatomic, retain) NSString* userID;
    @property (nonatomic, retain) NSString* name;
    @property (nonatomic, retain) NSString* description;
    @property (nonatomic, retain) NSDate*   from;
    @property (nonatomic, retain) NSDate*   to;
    @property (nonatomic, retain) NSString* url;
    @property (nonatomic, retain) NSString* note;
    @property (nonatomic, retain) NSString* location;
    @property (nonatomic, retain) NSArray*  coordinates;
    @property (nonatomic, retain) NSDate*   createdAt;
    @property (nonatomic, retain) NSDate*   updatedAt;
    @property (nonatomic) float             price;
    @property (nonatomic, retain) UIImage*  eventImage;


-(void)fetchEventImage;

@end
