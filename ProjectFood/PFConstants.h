//
//  PFConstants.h
//  ProjectFood
//
//  Created by Abbin Varghese on 07/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFConstants : NSObject

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Restaurant Keys -

FOUNDATION_EXPORT NSString *const restaurantNameKey;
FOUNDATION_EXPORT NSString *const restaurantNameCappedKey;
FOUNDATION_EXPORT NSString *const restaurantlocationKey;
FOUNDATION_EXPORT NSString *const restaurantPhoneNumberKey;
FOUNDATION_EXPORT NSString *const restaurantWorkingFromKey;
FOUNDATION_EXPORT NSString *const restaurantWorkingTillKey;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Fuud Keys -

FOUNDATION_EXPORT NSString *const fuudTitleKey;
FOUNDATION_EXPORT NSString *const fuudTitleCappedKey;
FOUNDATION_EXPORT NSString *const fuudDescriptionKey;
FOUNDATION_EXPORT NSString *const fuudPriceKey;
FOUNDATION_EXPORT NSString *const fuudRatingKey;
FOUNDATION_EXPORT NSString *const fuudRestaurentKey;
FOUNDATION_EXPORT NSString *const fuudImageKey;
FOUNDATION_EXPORT NSString *const fuudLatitudeKey;
FOUNDATION_EXPORT NSString *const fuudLongitudeKey;
FOUNDATION_EXPORT NSString *const fuudTimeStampKey;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - User Keys -

FOUNDATION_EXPORT NSString *const userIDKey;
FOUNDATION_EXPORT NSString *const userIsAnonymousKey;
FOUNDATION_EXPORT NSString *const userLocationKey;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Location Keys -

FOUNDATION_EXPORT NSString *const locationPlaceIDKey;
FOUNDATION_EXPORT NSString *const locationNameKey;
FOUNDATION_EXPORT NSString *const locationAddressKey;
FOUNDATION_EXPORT NSString *const locationLatitudeKey;
FOUNDATION_EXPORT NSString *const locationLongitudeKey;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Feedback Keys -

FOUNDATION_EXPORT NSString *const feedbackTextKey;
FOUNDATION_EXPORT NSString *const feedbackFileURLKey;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Database Path Keys -

FOUNDATION_EXPORT NSString *const fuudPathKey;
FOUNDATION_EXPORT NSString *const restaurentPathKey;
FOUNDATION_EXPORT NSString *const storagePathKey;
FOUNDATION_EXPORT NSString *const userPathKey;
FOUNDATION_EXPORT NSString *const messagesPathKey;
FOUNDATION_EXPORT NSString *const feedbackPathKey;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UX Keys -

FOUNDATION_EXPORT NSString *const firstCameraLaunchKey;
FOUNDATION_EXPORT NSString *const firstLaunchKey;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Segue Keys -

FOUNDATION_EXPORT NSString *const signInSegueKey;
FOUNDATION_EXPORT NSString *const locationSegueKey;
FOUNDATION_EXPORT NSString *const locationPickerSegueKey;
FOUNDATION_EXPORT NSString *const mapSegueKey;
FOUNDATION_EXPORT NSString *const directLocationSegueKey;
FOUNDATION_EXPORT NSString *const addFirstViewControllerSegue;
FOUNDATION_EXPORT NSString *const addSecondViewControllerSegue;
FOUNDATION_EXPORT NSString *const itemPickerSegue;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Other Keys -

FOUNDATION_EXPORT NSString *const itunesAppUrl;
FOUNDATION_EXPORT NSString *const shareSMSText;
FOUNDATION_EXPORT NSString *const shareEmailTitle;
FOUNDATION_EXPORT NSString *const shareEmailText;


@end
