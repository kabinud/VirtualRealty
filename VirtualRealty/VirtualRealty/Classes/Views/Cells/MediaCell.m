//
//  MediaCell.m
//  VirtualRealty
//
//  Created by christopher shanley on 10/5/13.
//  Copyright (c) 2013 virtualrealty. All rights reserved.
//

#import "MediaCell.h"

@implementation MediaCell

-(void)prepareForReuse
{
    [super prepareForReuse];
    self.accessoryType = UITableViewCellAccessoryNone;

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = self.contentView.frame;
    self.imageView.frame = rect;

    self.errorView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
}

-(void)render
{
    self.imageView.image = [UIImage imageNamed:self.cellinfo[@"temp-image"]];
    self.imageView.userInteractionEnabled = NO;
    if( [self.cellinfo valueForKey:@"current-value"] )
    {
        self.imageView.image = [self.cellinfo valueForKey:@"current-value"];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
    }
}

-(void)showError
{
    [super showError];
    NSLog(@"%@ -- showing error ", [self class]);
}

@end
