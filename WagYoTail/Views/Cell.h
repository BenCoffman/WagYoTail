//
//  Cell.h
//  WagYoTail
//
//  Created by Ben Coffman on 3/01/18.
//  Copyright © 2018 Ben Coffman. All rights reserved.
//

#ifndef Cell_h
#define Cell_h


#endif /* Cell_h */

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ivImage;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblGoldBadgeCount;
@property (weak, nonatomic) IBOutlet UILabel *lblSilverBadgeCount;
@property (weak, nonatomic) IBOutlet UILabel *lblBronzeBadgeCount;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end
