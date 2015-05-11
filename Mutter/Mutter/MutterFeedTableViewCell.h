//
//  MutterFeedTableViewCell.h
//  Mutter
//
//  Created by Mira Chen on 4/30/15.
//  Copyright (c) 2015 MiraStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MutterFeedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *feedLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedCreatedDateLabel;

@end
