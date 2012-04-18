//
//  CSLFirstViewController.h
//  ArubaClient
//
//  Created by Ludovic Chenneberg on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "CSLEvent.h"

@interface CSLFirstViewController : UITableViewController <RKRequestDelegate, RKObjectLoaderDelegate, UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) NSArray *eventData;
@property (weak, nonatomic) IBOutlet UITableView *eventsTableView;
    
-(void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response;
-(void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error;

-(void)getEvents;
-(void)createEvent;
-(void)serverReachability;
-(void)reachabilityDidChange:(NSNotification*)notification;
-(void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error;
-(void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects;

-(void)refreshList;

@end
