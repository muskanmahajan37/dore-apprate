//
//  DoreAppRate.m
//  DoreAppRate
//
//  Created by phodal on 17/12/2017.
//

#import "RNAppRate.h"
#import <React/RCTBridge.h>
#import <StoreKit/StoreKit.h>

@implementation RNNoTagDatepicker

@synthesize bridge = _bridge;

- (NSArray<NSString *> *) supportedEvents
{
    return @[@"DATEPICKER_NATIVE_INVOKE"];
}

RCT_EXPORT_MODULE()

- (void)getAppVersion:(CDVInvokedUrlCommand *)command {
    [self.commandDelegate runInBackground:^{
        NSString *versionString = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:versionString];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)getAppTitle:(CDVInvokedUrlCommand *)command {
    [self.commandDelegate runInBackground:^{
        NSString *appNameString = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:appNameString];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)launchiOSReview:(CDVInvokedUrlCommand *)command {
    BOOL shouldUseNativePrompt = [command.arguments[1] boolValue];
    
    if (shouldUseNativePrompt && [SKStoreReviewController class]) {
        [self launchInAppReview];
    } else {
        NSString *appId = @"";
        
        if ([command.arguments count] >= 1) {
            appId = (NSString *) (command.arguments)[0];
        }
        
        [self launchAppStore:appId];
    }
}

- (void)launchAppStore:(NSString *) appId{
    [self.commandDelegate runInBackground:^{
        // Initialize Product View Controller
        SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
        
        // Configure View Controller
        [storeProductViewController setDelegate:self];
        [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : appId} completionBlock:^(BOOL result, NSError *error) {
            if (error) {
                NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
            } else {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [self.viewController presentViewController:storeProductViewController animated:YES completion:nil];
            }
        }];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }];
}

- (void)launchInAppReview {
    [self.commandDelegate runInBackground:^{
        [SKStoreReviewController requestReview];
    }];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

@end

