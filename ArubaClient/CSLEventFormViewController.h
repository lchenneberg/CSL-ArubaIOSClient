//
//  CSLEventFormViewController.h
//  ArubaClient
//
//  Created by Ludovic Chenneberg on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLEvent.h"
#import "CSLCellFormViewTextInput.h"

@interface CSLEventFormViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>{
    __strong NSMutableArray *cells;
    __strong CSLEvent *cslEvent;
    CSLCellFormViewTextInput *inputName;
    CSLCellFormViewTextInput *inputFrom;
    CSLCellFormViewTextInput *inputTo;
    CSLCellFormViewTextInput *inputLocation;
    CSLCellFormViewTextInput *inputPrice;
}

@property (nonatomic, strong) IBOutlet UITableView *formTableView;
@property (nonatomic, strong) NSMutableArray *cells;
@property (nonatomic, strong) CSLEvent *cslEvent;

@property (nonatomic, strong) CSLCellFormViewTextInput *inputName;
@property (nonatomic, strong) CSLCellFormViewTextInput *inputFrom;
@property (nonatomic, strong) CSLCellFormViewTextInput *inputTo;
@property (nonatomic, strong) CSLCellFormViewTextInput *inputLocation;
@property (nonatomic, strong) CSLCellFormViewTextInput *inputPrice;



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
-(void)textFieldDidEndEditing:(UITextField *)textField;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;
- (void)textFieldDidBeginEditing:(UITextField *)textField;

@end
