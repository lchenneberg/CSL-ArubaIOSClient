//
//  CSLFirstViewController.m
//  ArubaClient
//
//  Created by Ludovic Chenneberg on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CSLFirstViewController.h"
#import <RestKit/Restkit.h>
#import "CSLEvent.h"
#import "CSLShowEventViewController.h"
#import "CSLAppDelegate.h"

@interface CSLFirstViewController ()

@end

@implementation CSLFirstViewController
@synthesize eventsTableView, eventData;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString: @"EventsToShowEventSegue"]){
        CSLShowEventViewController *sevc = (CSLShowEventViewController*)[segue destinationViewController];
        NSIndexPath *idx = [eventsTableView indexPathForSelectedRow];
        sevc.cslEvent = [eventData objectAtIndex:idx.row];
    }
}

- (void)viewDidLoad
{
    self.parentViewController.view.backgroundColor = [CSLAppDelegate getMainBackground];
    
    eventData = [[NSArray alloc] init];
    [super viewDidLoad];
   
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self refreshList];
}

-(void)refreshList{
    
    RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:[NSURL URLWithString:@"https://localhost:3000"]];
    objectManager.client.disableCertificateValidation = YES;
    objectManager.client.username = @"chenlu972@gmail.com";
    objectManager.client.password = @"Passwd0";
    objectManager.serializationMIMEType = RKMIMETypeJSON;
    objectManager.acceptMIMEType = RKMIMETypeJSON;
    
    //Setup object Mappings
    RKObjectMapping* eventMapping = [RKObjectMapping mappingForClass:[CSLEvent class]];
    [eventMapping mapKeyPath:@"id" toAttribute:@"eventID"];
    [eventMapping mapKeyPath:@"created_at" toAttribute:@"createdAt"];
    [eventMapping mapKeyPath:@"updated_at" toAttribute:@"updatedAt"];
    [eventMapping mapAttributes:@"name", @"description", @"from", @"to", @"url", 
     @"note", @"location", @"coordinates", @"price", nil];
    [[RKObjectManager sharedManager].mappingProvider setMapping:eventMapping forKeyPath:@"events"];
    
    //SetUpSerialization Mapping
    RKObjectMapping *patientSerializationMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [patientSerializationMapping mapKeyPath:@"eventID" toAttribute:@"id"];
    [patientSerializationMapping mapKeyPath:@"createdAt" toAttribute:@"created_at"];
    [patientSerializationMapping mapKeyPath:@"updatedAt" toAttribute:@"updated_at"];
    [patientSerializationMapping mapAttributes:@"name", @"description", @"from", @"to", @"url", 
     @"note", @"location", @"coordinates", @"price", nil];
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:patientSerializationMapping forClass:[CSLEvent class]]; 
    
    
    //[objectManager loadObjectsAtResourcePath:@"api/v1/account/events" delegate:self];
    
    //[objectManager loadObjectsAtResourcePath:@"api/v1/account/events" delegate:self];
    [objectManager.router routeClass:[CSLEvent class] toResourcePath:@"api/v1/account/events/(eventID)"];
    [objectManager.router routeClass:[CSLEvent class] toResourcePath:@"api/v1/account/events/" forMethod:RKRequestMethodPOST];
    [objectManager.router routeClass:[CSLEvent class] toResourcePath:@"api/v1/account/events/" forMethod:RKRequestMethodGET];
    
    //CSLEvent* event = [CSLEvent new];
    //event.name = @"Mon event from iOS";
    //[objectManager postObject:event delegate:self];
    
    [objectManager loadObjectsAtResourcePath:@"api/v1/account/events" delegate:self];
}


-(void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects{
    self.eventData = objects;
    [eventsTableView reloadData];
    NSLog(@"Loaded events: %@", objects);
}
-(void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error{
    NSLog(@"Request Failed %@", error);
}

- (void)request:(RKRequest*)request didFailLoadWithError:(NSError*)error {
    //NSLog(@"Oh no! Error: %@ \n\n", [error localizedDescription]);
}

- (void)viewDidUnload
{
    [self setEventsTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)getEvents {
    [[RKClient sharedClient] get:@"api/v1/account/events" delegate:self];
}
- (void)createEvent {
    NSDictionary *paramsDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Mon event from ios", @"name",
                               @"Palais des congrès Montreal", @"location",
                               nil];
    NSDictionary *eventDict = [NSDictionary dictionaryWithObject:paramsDict forKey:@"event"]; 
    [[RKClient sharedClient] post:@"api/v1/account/events" params:eventDict delegate:self];
}

- (void)serverReachability {
    [[RKClient sharedClient] isNetworkReachable];
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(reachabilityDidChange:) name:RKReachabilityDidChangeNotification object:nil];
}
- (void)reachabilityDidChange:(NSNotification*)notification{
    RKReachabilityObserver* observer = (RKReachabilityObserver*) [notification object];
    RKReachabilityNetworkStatus status = [observer networkStatus];
    if(RKReachabilityNotReachable == status){
        NSLog(@"No Network access!");
    } else if (RKReachabilityReachableViaWiFi == status) {
        NSLog(@"Online via WiFi");
    } else if (RKReachabilityReachableViaWWAN == status) {
        NSLog(@"Online via Edge or 3G");
    }
}

- (void)sendRequests {  
    // Perform a simple HTTP GET and call me back with the results  
    [[RKClient sharedClient] get:@"/foo.xml" delegate:self];  

    // Send a POST to a remote resource. The dictionary will be transparently  
    // converted into a URL encoded representation and sent along as the request body  
    NSDictionary* params = [NSDictionary dictionaryWithObject:@"RestKit" forKey:@"Sender"];  
    [[RKClient sharedClient] post:@"/other.json" params:params delegate:self];

    // DELETE a remote resource from the server  
    //[[RKClient client] delete:@"/missing_resource.txt" delegate:self];  
}  

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    
    NSLog(@"Request Headers: %@", [response allHeaderFields]); 
    NSLog(@"Cookies: %@", [response cookies]);
    if ([response isSuccessful]) {
        if([response isJSON]){
            // Response status was 200..299
            if ([response isOK]){
                NSLog(@"JSON returned is %@", [response bodyAsString]);
            } else if ([response isCreated]) {
                // Looks like we have a 201 response of type 'application/json'
                NSLog(@"The JSON is %@", [response bodyAsString]);
            }
        }
    } else if ([response isError]) {
        // Response status was either 400..499 or 500..599
        NSLog(@"HTTP error, status Code: %@", [response localizedStatusCodeString]);
    }
} 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.eventData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentififier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    NSUInteger row = [indexPath row];
    CSLEvent *evt = (CSLEvent*)[eventData objectAtIndex:row];
    cell.textLabel.text = evt.name;
    cell.detailTextLabel.text = evt.description;

    cell.opaque = NO;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor colorWithRed:.1 green:.1 blue:.1 alpha:.4];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}



@end
