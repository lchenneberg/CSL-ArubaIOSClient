//
//  CSLCellShowViewMap.h
//  ArubaClient
//
//  Created by Ludovic Chenneberg on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/Mapkit.h>

@interface CSLCellShowViewMap : UITableViewCell

@property (nonatomic, weak) IBOutlet MKMapView *map;

@end
