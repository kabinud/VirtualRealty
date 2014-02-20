//
//  PriceView.m
//  VirtualRealty
//
//  Created by christopher shanley on 11/26/13.
//  Copyright (c) 2013 virtualrealty. All rights reserved.
//

#import "PriceView.h"
#import "UIColor+Extended.h"
@interface PriceView()
{
    UIImageView *triangle;
    UIView *bg;
    UILabel *priceLabel;
}

@end;


@implementation PriceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        triangle = [[UIImageView alloc]initWithImage:nil];
        [self addSubview:triangle];
        
        bg = [[UIView alloc]initWithFrame:CGRectZero];
        [bg setBackgroundColor:[UIColor colorFromHex:@"01aef0"]];
        [self addSubview:bg];
        
        priceLabel  = [[UILabel alloc]initWithFrame:CGRectZero];
        priceLabel.textColor = [UIColor whiteColor];
        [priceLabel setFont:[UIFont fontWithName:@"MuseoSans-500" size:15]];
        [self addSubview:priceLabel];
    }
    return self;
}


-(void)setPrice:(float)value andPosition:(int)pos
{
    
    NSString *wedgeName = ( pos == 0 ) ? @"topleft-wedge.png" : @"topRight-wedge.png";
    triangle.image = [UIImage imageNamed:wedgeName];
    triangle.frame = CGRectZero;
    bg.frame = CGRectZero;
    priceLabel.frame = CGRectZero;
    
    [triangle sizeToFit];
    
   
    priceLabel.text = [NSString stringWithFormat:@"$%i", (int)value];
    [priceLabel sizeToFit];
    
    
    if( pos == 0 )
    {
        CGRect rect = priceLabel.frame;
        rect.size.width  = priceLabel.frame.size.width + 10;
        rect.size.height = triangle.frame.size.height;
        bg.frame = rect;
       
        rect = priceLabel.frame;
        rect.origin.y = 5;
        rect.origin.x = 5;
        priceLabel.frame = rect;
        
        rect = triangle.frame;
        rect.origin.x = bg.frame.size.width;
        triangle.frame = rect;

        CGRect fr      = CGRectZero;
        fr.size.width  = triangle.frame.size.width + bg.frame.size.width;
        fr.size.height = triangle.frame.size.height;
        self.frame = fr;
    }
    
    if( pos == 1 )
    {
    
        CGRect rect = priceLabel.frame;
        rect.size.width  = priceLabel.frame.size.width + 10;
        rect.size.height = triangle.frame.size.height;
        rect.origin.x    = triangle.frame.size.width;
        bg.frame = rect;
        
        rect = priceLabel.frame;
        rect.origin.y = 5;
        rect.origin.x = bg.frame.origin.x + 5;
        priceLabel.frame = rect;
        
        CGRect fr      = CGRectZero;
        fr.size.width  = triangle.frame.size.width + bg.frame.size.width;
        fr.size.height = triangle.frame.size.height;
        self.frame = fr;
    }
}



@end
