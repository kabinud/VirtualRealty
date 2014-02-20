//
//  ShutterstockUtils.h
//  shutterstock-ios
//
//  Created by Chris on 3/27/13.
//
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject


/* METHOD : getCurrentBuildEnvironment
   returns the currentbuild configuration as a BuildEnvironment constant
   requires "configuration" plist setting
 
    key   : Configuration
    value : ${CONFIGURATION}
*/



+(BuildEnvironment)getCurrentBuildEnvironment;
+(UIImage *)resizeImage:(UIImage *)img toSize:(CGSize)size;
/* Short hand method for ducments directory */
+(NSString *)getDocsDirectory;
+ (void)convertVideoToLowQualityWithInputURL:(NSURL*)inputURL outputURL:(NSURL*)outputURL successHandler:(void (^)())successHandler failureHandler:(void (^)(NSError *))failureHandler;
+(id) blockSafeInstanceOf:(id) _object;

+(DeviceType)getDevice;

+(NSString *)urlEncodeString:(NSString *)unencoded;

+(BOOL)isValidEmail:(NSString *)checkString;
+(BOOL)isValidPassword:(NSString *)checkString;
+(UIImage *)getIconForBusinessTypes:(NSArray *)value;
+(UIImage *)getImagefromVideoURL:(NSURL *)url;
+(NSNumber *)getDurationOfMedia:(NSURL *)url;
+(void)printFontFamilies;
+(UIImage *)copyImage:(UIImage *)img ToSize:(CGSize)size;



@end
