//
//  CSLCellShowViewAttribute.m
//  ArubaClient
//
//  Created by Ludovic Chenneberg on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CSLCellShowViewAttribute.h"

@implementation CSLCellShowViewAttribute
@synthesize  attrName, attrText;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    NSLog(@"initframereuseidentifier");

    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        NSLog(@"initframereuseidentifier");
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

@end
