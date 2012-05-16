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
#import "CSLCellShowViewImage.h"
#include <QuartzCore/QuartzCore.h>

@interface CSLShowEventViewController ()
    
@end



@implementation CSLShowEventViewController
@synthesize detailsTable, activityIndicator;
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.navigationItem.title = cslEvent.name;
    
    self.parentViewController.view.backgroundColor = [CSLAppDelegate getMainBackground];
    cells = [[NSMutableArray alloc] init];
    
    
    //Add image
    __block UIImage *img;
    CSLCellShowViewImage *cImage = [detailsTable dequeueReusableCellWithIdentifier:@"ShowViewImageCell"];
    cImage.frame = CGRectMake(0, 0, 0, 0);
    
    NSURL *imgUrl = [NSURL URLWithString:@"http://www.nowhereelse.fr/wp-content/uploads/2012/01/apple-keynote-19-janvier-2012.jpg"];
    dispatch_queue_t downloadQ = dispatch_queue_create("download queue", NULL);
    dispatch_async(downloadQ, ^{
        NSData *data = [NSData dataWithContentsOfURL:imgUrl];
        if (data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                img= [UIImage imageWithData:data];
                [detailsTable reloadData];
                [detailsTable beginUpdates];
                cImage.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, 200);
                [[cImage.imageView layer] setShadowOffset:CGSizeMake(0, 1)];
                [[cImage.imageView layer] setShadowColor:[[UIColor darkGrayColor] CGColor]];
                [[cImage.imageView layer] setShadowRadius:3.0];
                [[cImage.imageView layer] setShadowOpacity:0.8];
                [detailsTable endUpdates];
                cImage.imageView.image = img;
                cImage.imageView.frame = cImage.imageView.frame;
                [self.activityIndicator stopAnimating];
            });
        }
    });
    dispatch_release(downloadQ);
    [cells addObject:cImage];
    
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
    if (![cslEvent.description isEqualToString:@""] && cslEvent.description != nil) {
        
        CSLCellShowViewLongText *cDesc = [detailsTable dequeueReusableCellWithIdentifier:@"ShowViewLongTextCell"];
        cDesc.titleText.text = @"Description :";
//        cslEvent.description = @"azee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azeeazee azee";
        CGSize textSize = { 300.0f, 9999.0f };
        CGSize size1 = [cslEvent.description sizeWithFont:cDesc.longText.font constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
        cDesc.longText.text = cslEvent.description;
        cDesc.longText.frame = CGRectMake(8,20,cDesc.longText.frame.size.width, size1.height + 40);
        cDesc.frame = CGRectMake(0, 0, cDesc.frame.size.width, size1.height + 40);
        
        [cells addObject:cDesc];
    }
    
    
    //Add note
    CSLCellShowViewAttribute *cNote = [detailsTable dequeueReusableCellWithIdentifier:@"ShowViewAttributeCell"];
    cNote.attrName.text = @"Note :";
    cNote.attrText.text = cslEvent.note;
    
    CGSize textSize = { 300.0f, 9999.0f };
    CGSize size1 = [cslEvent.description sizeWithFont:cNote.attrText.font constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
    cNote.attrText.frame = CGRectMake(cNote.attrText.frame.origin.x, cNote.attrText.frame.origin.y,cNote.attrText.frame.size.width, size1.height + 10);
    cNote.frame = CGRectMake(0, 0, cNote.attrText.frame.size.width, size1.height + 10);
    
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
