//
//  SSIErrorFactory.h
//  shutterstock-ios
//
//  Created by Chris on 6/25/13.
//
//

#import <Foundation/Foundation.h>

typedef enum ErrorType
{
    // system error
    kDatabaseFailedToLoadError,
    
    // reachable error
    kNotReachableOnLogIn,
    
    // user error
    kUserLoginFailError,
    kUserDataLoaderror,
    
    // data errors
    kNoEarningsRecordsError,
    // form errors
    
    kInvalidUsernameError,
    kInvalidPasswordError
}ErrorType;


@interface ErrorFactory : NSObject

+(UIAlertView *)getAlertForType:(ErrorType)type andDelegateOrNil:(id<UIAlertViewDelegate>)delegate andOtherButtons:(NSArray *)otherButtons;
+(UIAlertView *)getAlertCustomMessage:(NSString *)error andDelegateOrNil:(id<UIAlertViewDelegate>)delegate andOtherButtons:(NSArray *)otherButtons;

@end