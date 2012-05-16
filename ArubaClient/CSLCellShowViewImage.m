//
//  CSLCellShowViewImage.m
//  ArubaClient
//
//  Created by Ludovic Chenneberg on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CSLCellShowViewImage.h"
#include <QuartzCore/QuartzCore.h>

@implementation CSLCellShowViewImage
@synthesize imageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [[imageView layer] setShadowOffset:CGSizeMake(0, 1)];
        [[imageView layer] setShadowColor:[[UIColor darkGrayColor] CGColor]];
        [[imageView layer] setShadowRadius:3.0];
        [[imageView layer] setShadowOpacity:0.8];
        NSLog(@"loaded layer");
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
