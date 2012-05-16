//
//  CSLEventFormViewController.m
//  ArubaClient
//
//  Created by Ludovic Chenneberg on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CSLEventFormViewController.h"
#import "CSLCellFormViewTextInput.h"
#import "CSLAppDelegate.h"

@interface CSLEventFormViewController ()

@end

@implementation CSLEventFormViewController
@synthesize formTableView;
@synthesize  cslEvent, cells, inputName, inputFrom, inputTo, inputLocation, inputPrice;

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
    self.parentViewController.view.backgroundColor = [CSLAppDelegate getMainBackground];
    if(cslEvent == nil){
        cslEvent = [CSLEvent new];
    }
    [super viewDidLoad];
	cells = [[NSMutableArray alloc] init];
    inputName = [formTableView dequeueReusableCellWithIdentifier:@"FormViewTextInputCell"];
    inputName.inputLabel.text = @"Name :";
    inputName.textInputField.text = cslEvent.name;
    inputName.textInputField.delegate = self;
    inputName.textInputField.tag = 0;
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm"];

    inputFrom = [formTableView dequeueReusableCellWithIdentifier:@"FormViewTextInputCell"];
    inputFrom.inputLabel.text = @"From :";
    inputFrom.textInputField.text = [dateFormatter stringFromDate:cslEvent.from];
    inputFrom.textInputField.delegate = self;
    inputFrom.textInputField.tag = 1;
    
    inputTo = [formTableView dequeueReusableCellWithIdentifier:@"FormViewTextInputCell"];
    inputTo.inputLabel.text = @"To :";
    inputTo.textInputField.text = [dateFormatter stringFromDate:cslEvent.from];
    inputTo.textInputField.delegate = self;
    inputTo.textInputField.tag = 2;
    
    inputLocation = [formTableView dequeueReusableCellWithIdentifier:@"FormViewTextInputCell"];
    inputLocation.inputLabel.text = @"Location :";
    inputLocation.textInputField.text = cslEvent.location;
    inputLocation.textInputField.delegate = self;
    inputLocation.textInputField.tag = 3;
    
    NSNumberFormatter *nForm = [[NSNumberFormatter alloc]init];
    inputPrice = [formTableView dequeueReusableCellWithIdentifier:@"FormViewTextInputCell"];
    inputPrice.inputLabel.text = @"Price :";
    inputPrice.textInputField.text = [nForm stringFromNumber:[NSNumber numberWithFloat:cslEvent.price]];
    inputPrice.textInputField.keyboardType = UIKeyboardTypeNumberPad;
    inputPrice.textInputField.returnKeyType = UIReturnKeyDone;
    inputPrice.textInputField.delegate = self;
    inputPrice.textInputField.tag = 4;
    
    
    
    [cells addObject:inputName];
    [cells addObject:inputFrom];
    [cells addObject:inputTo];
    [cells addObject:inputLocation];
    [cells addObject:inputPrice];
    [formTableView reloadData];
    
    
}

- (void)viewDidUnload
{
    [self setFormTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {	
    NSLog(@"textFieldDidBeginEditing");
    
    //UITableViewCell *cell = (UITableViewCell *)textField.superview.superview;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    
    [self.formTableView scrollToRowAtIndexPath:indexPath 
                          atScrollPosition:UITableViewScrollPositionTop 
                                  animated:YES];
    
    
    [self isFirstResponder];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {	
		
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            [inputFrom.textInputField becomeFirstResponder];
            break;
        case 1:
            [inputTo.textInputField becomeFirstResponder];
            break;
        case 2:
            [inputLocation.textInputField becomeFirstResponder];
            break;
        case 3:
            [inputPrice.textInputField becomeFirstResponder];
            break;
            
        default:
            //[textField resignFirstResponder];
            break;
    }
    return YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [cells count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [cells objectAtIndex:indexPath.row];
}


@end
