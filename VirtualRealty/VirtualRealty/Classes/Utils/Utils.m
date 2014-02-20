//
//  ShutterstockUtils.m
//  shutterstock-ios
//
//  Created by Chris on 3/27/13.
//
//

#import "Utils.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
@interface Utils()
{
    
}

@end

@implementation Utils

+(BuildEnvironment)getCurrentBuildEnvironment
{
    static NSString *debugFlag         = @"Debug";
    static NSString *releaseFlag       = @"Release";

    int environment = 0;
    
    NSString *current = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Configuration"];
    
    if( [current isEqualToString:debugFlag])
    {
        environment = kDebug;
    }
    

    if( [current isEqualToString:releaseFlag])
    {
        environment = kRelease;
    }
    
    return  environment;
}

+(UIImage *)resizeImage:(UIImage *)img toSize:(CGSize)size
{
    UIGraphicsBeginImageContext( size );
    [img drawInRect:CGRectMake(0, 0, size.width, size.height) ];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return smallImage;
}

+(NSString *)getDocsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return  [paths objectAtIndex:0];    
}

+ (NSString*)codeForPreferredLanguage
{
    NSSet *supportedLangauges = [NSSet setWithArray:@[@"en", @"de", @"pt"]];
    NSString *deviceLanguage  = [[NSLocale preferredLanguages] objectAtIndex:0];
  
    
    if ([supportedLangauges containsObject:deviceLanguage])
    {
        return deviceLanguage;
    }
    else
    {
        return @"en";
    }
}

+(id) blockSafeInstanceOf:(id) _object
{
    __block __typeof__(_object) blockObject = _object;
    return blockObject;
}

+(DeviceType)getDevice
{
    int type;
    if( [[UIDevice currentDevice].model isEqualToString:@"iPhone"] )
    {
        type = kiPhone;
    }
    
    if( [[UIDevice currentDevice].model isEqualToString:@"iPod touch"])
    {
        type = kiPodTouch;
    }
    
    if( [[UIDevice currentDevice].model isEqualToString:@"iPad"])
    {
        type = kiPad;
    }

    return type;
}


+(NSString *)urlEncodeString:(NSString *)unencoded
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, CFBridgingRetain(unencoded),  NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
}

+(BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+(BOOL) isValidPassword:(NSString *)checkString
{
    return  checkString.length > 5 ? YES : NO;
}

+(UIImage *)getIconForBusinessTypes:(NSArray *)value
{
    NSString *restaurantFlag = @"restaurant";
    NSString *barFlag        = @"bar";
    NSString *groceryFlag    = @"grocery_or_supermarket";
    NSString *subwayFlag     = @"subway_station";
    UIImage *icon;
    for( NSString *type in value)
    {
        if( [type isEqualToString:restaurantFlag ] )
        {
            icon = [UIImage imageNamed:@"restaurant-icon.png"];
            break;
        }
        
        if( [type isEqualToString:barFlag ] )
        {
            icon = [UIImage imageNamed:@"bar-icon.png"];
            break;
        }
        
        if( [type isEqualToString:groceryFlag ] )
        {
            icon = [UIImage imageNamed:@"grocery-icon.png"];
            break;
        }
        if([type isEqualToString:subwayFlag])
        {
            icon = [UIImage imageNamed:@"subway-icon.png"];
        }
        
    }
    return icon;
}

+(UIImage *)getImagefromVideoURL:(NSURL *)url
{
    AVURLAsset *asset1 = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generate1 = [[AVAssetImageGenerator alloc] initWithAsset:asset1];
    generate1.appliesPreferredTrackTransform = YES;
   
    NSError *err      = NULL;
    CMTime time       = CMTimeMake(1, 2);
    CGImageRef oneRef = [generate1 copyCGImageAtTime:time actualTime:NULL error:&err];
    UIImage *image    = [[UIImage alloc] initWithCGImage:oneRef];
    return image;
}

+(NSNumber *)getDurationOfMedia:(NSURL *)url
{
    AVURLAsset *asset1 = [[AVURLAsset alloc] initWithURL:url options:nil];

    return [NSNumber numberWithFloat:asset1.duration.value/asset1.duration.timescale];
}


+ (void)convertVideoToLowQualityWithInputURL:(NSURL*)inputURL outputURL:(NSURL*)outputURL successHandler:(void (^)())successHandler failureHandler:(void (^)(NSError *))failureHandler
{
    
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    __block AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetLowQuality];
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeQuickTimeMovie;

    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
    {
        if (exportSession.status == AVAssetExportSessionStatusCompleted)
        {
            successHandler();
        }
        else
        {
            NSLog(@"%@ --- found error with export %@ ", @"<Utils>" , exportSession.error );
            failureHandler(nil);
        }
    }];
}

+(void)printFontFamilies
{

    return;
    for (NSString* family in [UIFont familyNames])
    {
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
        }
    }
}

+(UIImage *)copyImage:(UIImage *)img ToSize:(CGSize)size
{
    
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.contentMode = UIViewContentModeScaleAspectFill;
    view.clipsToBounds = YES;
    view.image = img;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *imgClone = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return imgClone;

}

@end
