
//
//  UserListingCell.m
//  VirtualRealty
//
//  Created by christopher shanley on 10/21/13.
//  Copyright (c) 2013 virtualrealty. All rights reserved.
//

#import "UserListingCell.h"
#import "User.h"
#import <QuartzCore/QuartzCore.h>
#import "ListingStateView.h"


@implementation UserListingCell



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self)
    {
    }
    return self;
}

-(void) render
{
    [super render];
    
    if( [self.listing.submitterObjectId isEqualToString:[User sharedUser].uid] )
    {
        [self.stateView setState:[self.listing.listingState intValue]];
        CGRect rect = self.stateView.frame;
        rect.origin.x = 320 - self.stateView.frame.size.width;
        self.stateView.frame = rect;
    }

}

@end
