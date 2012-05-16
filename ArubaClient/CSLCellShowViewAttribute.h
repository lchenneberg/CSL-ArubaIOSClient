//
//  CSLCellShowViewAttribute.h
//  ArubaClient
//
//  Created by Ludovic Chenneberg on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSLCellShowViewAttribute : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel* attrName;
@property(nonatomic,strong) IBOutlet UITextView* attrText;

@end
