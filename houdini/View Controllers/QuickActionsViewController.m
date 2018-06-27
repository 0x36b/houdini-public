//
//  QuickActionsViewController.m
//  houdini
//

#import <Foundation/Foundation.h>
#include "task_ports.h"
#include "triple_fetch_remote_call.h"
#include "apps_control.h"
#include "utilities.h"
#include "QuickActionsViewController.h"
#include <objc/runtime.h>
#include "HomeViewController.h"

#include <sys/utsname.h>
#include <sys/param.h>
#include <sys/mount.h>
#include <sys/sysctl.h>

@interface QuickActionsView ()
@property (weak, nonatomic) IBOutlet UIView *respringView;
@property (weak, nonatomic) IBOutlet UIView *rebootView;
@property (weak, nonatomic) IBOutlet UIView *clearSpaceView;
@property (weak, nonatomic) IBOutlet UISwitch *disableSystemUpdatesSwitch;
@end

@implementation QuickActionsView

- (void)viewDidLoad {
    _disableSystemUpdatesSwitch.exclusiveTouch = YES;
    self.disableSystemUpdatesSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"system_updates_disabled"];
    [self.respringView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapRespring:)]];
    [self.rebootView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapReboot:)]];
    [self.clearSpaceView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapClearSpace:)]];
}

- (void)didTapRespring:(UITapGestureRecognizer *)gestureRecognizer {
    HomeViewController *homeView = [[HomeViewController alloc] init];
    [homeView didTapRespring:gestureRecognizer];
}

- (void)didTapReboot:(UITapGestureRecognizer *)gestureRecognizer {
    HomeViewController *homeView = [[HomeViewController alloc] init];
    [homeView didTapReboot:gestureRecognizer];
}

- (void)didTapClearSpace:(UITapGestureRecognizer *)gestureRecognizer {
    HomeViewController *homeView = [[HomeViewController alloc] init];
    [homeView didTapClearSpace:gestureRecognizer];
}

- (IBAction)didChangeDisableSystemUpdatesSwitch:(id)sender {
    HomeViewController *homeView = [[HomeViewController alloc] init];
    [homeView didToggleDisableSystemUpdatesSwitch:sender];
    BOOL c = _disableSystemUpdatesSwitch.on;
    BOOL b = [[NSUserDefaults standardUserDefaults] boolForKey:@"system_updates_disabled"];
    [_disableSystemUpdatesSwitch setOn:b animated:YES];
    if (!c && !b) {
        show_alert(self, @"Feature disabled", @"This feature has been disabled due to some issues with the AppStore");
    }
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
