//
//  CSLCellShowViewLongText.h
//  ArubaClient
//
//  Created by Ludovic Chenneberg on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSLCellShowViewLongText : UITableViewCell

@property (nonatomic, strong) IBOutlet UITextView *longText;
@property (nonatomic, strong) IBOutlet UILabel *titleText;

@end
