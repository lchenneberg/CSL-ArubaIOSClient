//
//  CSLShowEventViewController.m
//  ArubaClient
//
//  Created by Ludovic Chenneberg on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CSLShowEventViewController.h"
#import "CSLEvent.h"
#import "CSLCellShowViewTitle.h"
#import "CSLCellShowViewAttribute.h"
#import "CSLCellShowViewLongText.h"
#import "CSLAppDelegate.h"
#import "CSLEventFormViewController.h"



@interface CSLShowEventViewController ()
    
@end



@implementation CSLShowEventViewController
@synthesize detailsTable;
@synthesize cslEvent,cells;



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString: @"FromShowViewToFormView"]) {
        CSLEventFormViewController *evc = (CSLEventFormViewController*)[segue destinationViewController];
        evc.cslEvent = cslEvent;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.navigationItem.title = cslEvent.name;
    
    self.parentViewController.view.backgroundColor = [CSLAppDelegate getMainBackground];
    cells = [[NSMutableArray alloc] init];
    
    //Add title
    CSLCellShowViewTitle *cTitle = [detailsTable dequeueReusableCellWithIdentifier:@"ShowViewTitleCell"];
    cTitle.title.text = cslEvent.name;
    [cells addObject:cTitle];
    
    if (cslEvent.location != nil) {
        //Add location
        CSLCellShowViewAttribute *cLocat = [detailsTable dequeueReusableCellWithIdentifier:@"ShowViewAttributeCell"];
        cLocat.attrName.text = @"Location :";
        cLocat.attrText.text = cslEvent.location;
        [cells addObject:cLocat];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm"];

    //AddFromTo
    CSLCellShowViewAttribute *cFrom = [detailsTable dequeueReusableCellWithIdentifier:@"ShowViewAttributeCell"];
    cFrom.attrName.text = @"From :";
    cFrom.attrText.text = [dateFormatter stringFromDate:[cslEvent from]];
    CSLCellShowViewAttribute *cTo = [detailsTable dequeueReusableCellWithIdentifier:@"ShowViewAttributeCell"];
    cTo.attrName.text = @"To :";
    cTo.attrText.text = [dateFormatter stringFromDate:[cslEvent to]];
    [cells addObject:cFrom];
    [cells addObject:cTo];
    
    //Add Price
    CSLCellShowViewAttribute *cPrice = [detailsTable dequeueReusableCellWithIdentifier:@"ShowViewAttributeCell"];
    cPrice.attrName.text = @"Price :";
    if(cslEvent.price <= 0){
        cPrice.attrText.text = @"Free";
    } else {
        NSNumberFormatter *nform = [[NSNumberFormatter alloc] init];
        nform.numberStyle = NSNumberFormatterCurrencyStyle;
        cPrice.attrText.text = [nform stringFromNumber:[NSNumber numberWithFloat:cslEvent.price]];
    }
    [cells addObject:cPrice];
    
    //Add description
    CSLCellShowViewLongText *cDesc = [detailsTable dequeueReusableCellWithIdentifier:@"ShowViewLongTextCell"];
    cDesc.longText.text = cslEvent.description;
    [cells addObject:cDesc];
    
    //Add note
    CSLCellShowViewAttribute *cNote = [detailsTable dequeueReusableCellWithIdentifier:@"ShowViewAttributeCell"];
    cNote.attrName.text = @"Note :";
    cNote.attrText.text = cslEvent.note;
    cNote.attrText.textColor = [UIColor orangeColor];
    [cells addObject:cNote];
    
    [detailsTable reloadData];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setDetailsTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cells count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    return [cells objectAtIndex:indexPath.row];
}


@end
