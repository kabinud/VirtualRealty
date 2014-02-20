//
//  ListingCell.m
//  VirtualRealty
//
//  Created by christopher shanley on 10/7/13.
//  Copyright (c) 2013 virtualrealty. All rights reserved.
//

#import "ListingCell.h"
#import "NSDate+Extended.h"
#import "User.h"
#import "UIColor+Extended.h"

@implementation ListingCell

@synthesize thumb               = _thumb;
@synthesize priceView           = _priceView;
@synthesize addressLabel        = _addressLabel;
@synthesize listingDetailsLabel = _listingDetailsLabel;
@synthesize stroke              = _stroke;
@synthesize spinner             = _spinner;
@synthesize stateView           = _stateView;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if( self != nil  )
    {
        _thumb = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
        [self.thumb setContentMode:UIViewContentModeScaleAspectFill];
        [self.thumb setClipsToBounds:YES];
        [self.thumb setBackgroundColor:[UIColor colorFromHex:@"e6e6e6"]];
        [self.contentView addSubview:self.thumb];
        
        UIImageView *overlayView = [[UIImageView alloc]initWithFrame:self.thumb.frame];
        overlayView.image = [UIImage imageNamed:@"overlay.png"];
        [self.thumb addSubview:overlayView];
        
        _priceView = [[PriceView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.priceView];
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _addressLabel.font = [UIFont fontWithName:@"MuseoSans-300" size:19];
        [self.addressLabel setTextColor:[UIColor colorFromHex:@"ffffff"]];
        
        _listingDetailsLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _listingDetailsLabel.font = [UIFont fontWithName:@"MuseoSans-500" size:12];
        [self.listingDetailsLabel setTextColor:[UIColor colorFromHex:@"ffffff"]];
        
        _spinner = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        _spinner.activityIndicatorViewStyle = UIActionSheetStyleBlackTranslucent;
        _spinner.center = self.thumb.center;
      
        [self.contentView addSubview:_spinner];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.listingDetailsLabel];
       
        _stateView = [[ListingStateView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_stateView];
        
    }
    return self;
}


-(void)prepareForReuse
{
    [super prepareForReuse];
    self.thumb.image = nil;
    [self.spinner setHidden:YES];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = self.priceView.frame;
    rect.origin.x = ( tagPos == 0 ) ? 0 : self.contentView.frame.size.width - self.priceView.frame.size.width;
    self.priceView.frame = rect;
   
    [self.addressLabel sizeToFit];
    float y = self.thumb.frame.size.height - ( self.addressLabel.frame.size.height + 30 );
    self.addressLabel.frame = CGRectMake(5, y, 320, self.addressLabel.frame.size.height);
    
    if( self.addressLabel.frame.size.width > 320 )
    {
        self.addressLabel.adjustsFontSizeToFitWidth = YES;
        rect = self.addressLabel.frame;
        rect.size.width = 320;
        self.addressLabel.frame = rect;
    }
    [self.listingDetailsLabel sizeToFit];
    
    y = self.addressLabel.frame.size.height + self.addressLabel.frame.origin.y ;
    self.listingDetailsLabel.frame = CGRectMake(5, y, 320,self.listingDetailsLabel.frame.size.height);
}

-(void)render
{
    [self.spinner setHidden:NO];
    [self.spinner startAnimating];
    __block ListingCell *blockself = self;
    
    NSString *borough = ( self.listing.borough == nil ) ? self.listing.city : self.listing.borough;
    self.addressLabel.text = [NSString stringWithFormat:@"%@, %@ %@",self.listing.street, borough, [NSString stringWithFormat:@"%i",[self.listing.zip intValue]]];
  
    NSString *detailsFormat = (self.listing.neighborhood) ? @"%@, %@ in %@" : @"%@, %@";
    NSString *detailsText   = nil;
    
    if( self.listing.neighborhood )
    {
        detailsText = [NSString stringWithFormat:detailsFormat, self.listing.bedrooms, self.listing.bathrooms, self.listing.neighborhood];
    }
    else
    {
        detailsText = [NSString stringWithFormat:detailsFormat, self.listing.bedrooms, self.listing.bathrooms ];
    }
    
    self.listingDetailsLabel.text = [detailsText uppercaseString];
    
    
    [self.priceView setPrice:[self.listing.monthlyCost floatValue] andPosition:tagPos];
    
    if( self.listing.thumb == nil )
    {
        [self.listing loadThumb:^(BOOL success)
        {
            UIImage *img = blockself.listing.thumb;
            blockself.thumb.image = img;
            [blockself.spinner stopAnimating];
            [blockself.spinner setHidden:YES];
            blockself.thumb.alpha = 0.0f;
            
            [UIView animateWithDuration:0.3 animations:^{
                blockself.thumb.alpha = 1.0f;
            }];
        }];
        
    }
    else
    {
        [self.spinner setHidden:YES];
        [self.spinner stopAnimating];
        
        UIImage *img = self.listing.thumb;
        self.thumb.image = img;
        blockself.thumb.alpha = 0.0f;
        
        [UIView animateWithDuration:0.3 animations:^{
            blockself.thumb.alpha = 1.0f;
        }];

    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setTagPosition:(int)pos
{
    tagPos = pos;
}

-(void)showCloseWithTarget:(id)target andSEL:( SEL )selector
{
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    [close addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [close setTitle:@"close" forState:UIControlStateNormal];
    [close setTitleColor:[UIColor colorFromHex:@"424242"] forState:UIControlStateNormal];
    [close sizeToFit];
    [close.titleLabel setFont:[UIFont systemFontOfSize:10.0f]];
    CGRect rect = close.frame;
    rect.origin.x = self.contentView.frame.size.width - (rect.size.width );
    rect.origin.y = self.contentView.frame.size.height - (rect.size.height );
    close.frame = rect;
    
    [self.contentView addSubview:close];
}


@end
