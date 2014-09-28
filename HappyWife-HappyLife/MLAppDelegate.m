//
//  MLAppDelegate.m
//  HappyWife-HappyLife
//
//  Created by MLinc on 2014-06-29.
//  Copyright (c) 2014 Mobi-Learning Inc. All rights reserved.
//

#import "MLAppDelegate.h"
#import "MLDetailsViewController.h"

@implementation MLAppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    // Set the application defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:@"YES"
                                                            forKey:@"enabled"];
    [defaults registerDefaults:appDefaults];
    [defaults synchronize];
    
    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (locationNotification) {
        // Set icon badge number to zero
        application.applicationIconBadgeNumber = 0;

    }
    
    return YES;
}


- (void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    MLDetailsViewController *edView = [[MLDetailsViewController alloc] init];
    edView = [mainStoryboard instantiateViewControllerWithIdentifier:@"eventDetails"];
    edView.complimentId = [(NSNumber*)[notification.userInfo objectForKey:@"complimentId"] intValue] ;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:edView];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:navigationController];
    //[self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults boolForKey:@"enabled"]){
    
    NSDate *alertTime = [[NSDate date]
                         dateByAddingTimeInterval:86400];
    UIApplication* app = [UIApplication sharedApplication];
    UILocalNotification* notifyAlarm = [[UILocalNotification alloc]
                                        init];
    if (notifyAlarm)
    {
        notifyAlarm.fireDate = alertTime;
        notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
        notifyAlarm.repeatInterval = NSDayCalendarUnit;
        //notifyAlarm.soundName = @"bell_tree.mp3";
        notifyAlarm.alertBody = @"Compliment of the day";
        NSDictionary *infoDict = [NSDictionary dictionaryWithObject:[[NSNumber alloc] initWithInt:1] forKey:@"complimentId"];
        notifyAlarm.userInfo = infoDict;
        [app scheduleLocalNotification:notifyAlarm];
    }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
