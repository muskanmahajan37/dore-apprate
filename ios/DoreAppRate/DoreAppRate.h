//
//  DoreAppRate.h
//  DoreAppRate
//
//  Created by phodal on 17/12/2017.
//

#import <React/RCTBridgeModule.h>
#import <UIKit/UIKit.h>
#import <React/RCTUtils.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <StoreKit/StoreKit.h>

@interface DoreAppRate : RCTEventEmitter <RCTBridgeModule>

- (void)getAppVersion:(CDVInvokedUrlCommand *)command;

- (void)getAppTitle:(CDVInvokedUrlCommand *)command;

- (void)launchiOSReview:(CDVInvokedUrlCommand *)command;

- (void)launchAppStore:(NSString *)appId;

- (void)launchInAppReview;

@end
