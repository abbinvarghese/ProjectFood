//
//  PFConstants.m
//  ProjectFood
//
//  Created by Abbin Varghese on 07/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFConstants.h"

@implementation PFConstants

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Restaurant Keys -

NSString *const restaurantNameKey               = @"restaurantName";
NSString *const restaurantlocationKey           = @"restaurantlocation";
NSString *const restaurantPhoneNumberKey        = @"restaurantPhoneNumber";
NSString *const restaurantWorkingFromKey        = @"restaurantWorkingFrom";
NSString *const restaurantWorkingTillKey        = @"restaurantWorkingTill";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Fuud Keys -

NSString *const fuudTitleKey                    = @"fuudTitle";
NSString *const fuudDescriptionKey              = @"fuudDescription";
NSString *const fuudPriceKey                    = @"fuudPrice";
NSString *const fuudRatingKey                   = @"fuudRating";
NSString *const fuudRestaurentKey               = @"fuudRestaurent";
NSString *const fuudImageKey                    = @"fuudImage";
NSString *const fuudLatitudeKey                 = @"fuudLatitude";
NSString *const fuudLongitudeKey                = @"fuudLongitude";
NSString *const fuudTimeStampKey                = @"fuudTimeStamp";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - User Keys -

NSString *const userIDKey                       = @"userID";
NSString *const userIsAnonymousKey              = @"userIsAnonymous";
NSString *const userLocationKey                 = @"userLocation";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Location Keys -

NSString *const locationPlaceIDKey              = @"locationPlaceID";
NSString *const locationNameKey                 = @"locationName";
NSString *const locationAddressKey              = @"locationAddress";
NSString *const locationLatitudeKey             = @"locationLatitude";
NSString *const locationLongitudeKey            = @"locationLongitude";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Feedback Keys -

NSString *const feedbackTextKey                 = @"feedbackText";
NSString *const feedbackFileURLKey              = @"feedbackFileURL";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Database Path Keys -

NSString *const fuudPathKey                     = @"fuuds";
NSString *const storagePathKey                  = @"gs://uncle-bun.appspot.com/";
NSString *const userPathKey                     = @"users";
NSString *const messagesPathKey                 = @"messages";
NSString *const feedbackPathKey                 = @"feedbacks";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UX Keys -

NSString *const firstCameraLaunchKey            = @"firstCameraLaunch";
NSString *const firstLaunchKey                  = @"firstLaunch";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Segue Keys -

NSString *const signInSegueKey                  = @"signInSegueKey";
NSString *const locationSegueKey                = @"locationSegueKey";
NSString *const locationPickerSegueKey          = @"locationPickerSegueKey";
NSString *const directLocationSegueKey          = @"directLocationSegueKey";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Other Keys -

NSString *const itunesAppUrl                    = @"itunesAppUrl";
NSString *const shareSMSText                    = @"shareSMSText";
NSString *const shareEmailTitle                 = @"shareEmailTitle";
NSString *const shareEmailText                  = @"shareEmailText";


@end
