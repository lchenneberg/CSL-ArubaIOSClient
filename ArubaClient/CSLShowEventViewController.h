//
//  CSLShowEventViewController.h
//  ArubaClient
//
//  Created by Ludovic Chenneberg on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLEvent.h"
#import "CSLCellShowViewTitle.h"

@interface CSLShowEventViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    CSLEvent *cslEvent;
    __strong NSMutableArray *cells;
}

@property (strong, nonatomic) IBOutlet UITableView *detailsTable;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) CSLEvent *cslEvent;
@property (nonatomic, strong) NSMutableArray *cells;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;


@end
