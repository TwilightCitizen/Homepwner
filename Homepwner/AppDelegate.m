//
//  AppDelegate.m
//  Homepwner
//
//  Created by David Clark on 2/10/21.
//

#import "AppDelegate.h"



@interface AppDelegate ()

@end



@implementation AppDelegate

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
