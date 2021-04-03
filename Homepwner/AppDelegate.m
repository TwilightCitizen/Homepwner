//
//  AppDelegate.m
//  Homepwner
//
//  Created by David Clark on 2/10/21.
//

#import "AppDelegate.h"


NSString * const NextItemValuePrefsKey = @"NextItemValue";
NSString * const NextItemNamePrefsKey = @"NextItemName";



@interface AppDelegate ()

@end



@implementation AppDelegate

+ (void)initialize
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *factorySettings = @{
        NextItemValuePrefsKey : @75,
        NextItemNamePrefsKey : @"Coffee Cup"
    };
    
    [defaults registerDefaults:factorySettings];
}

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

- (UISceneConfiguration *)application:(UIApplication *)application
configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession
                              options:(UISceneConnectionOptions *)options
{
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration"
                                          sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application
didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {}

@end
