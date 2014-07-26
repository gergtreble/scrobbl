#import <Preferences/Preferences.h>
#import "sharedPrefs.h"
#import "../Classes/shared.h"
#import "MobileGestalt.h"
#import <GraphicsServices/GSCapability.h>
#import "SharedNotificationObserver.h"

@interface scrobblprefbundleListController: PSListController {
}

@end

@implementation scrobblprefbundleListController

-(id)init{

    self = [super init];
    if (self)
    {
        SharedNotificationObserver *observer = [SharedNotificationObserver sharedInstance];
        [observer getQueueCount];
    }
    return self;
}

- (id)specifiers {

	if(_specifiers == nil) {
		_specifiers = [self loadSpecifiersFromPlistName:@"scrobblprefbundle" target:self];
	}

    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_5_0) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setImage:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/scrobblprefbundle.bundle/Github.png"] forState:UIControlStateNormal];
        rightBtn.frame = CGRectMake(0, 0, 60, 60);

        [rightBtn addTarget:self action:@selector(githubButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        [[self navigationItem] setRightBarButtonItem:rightBarBtn];
    }

    if (kCFCoreFoundationVersionNumber < kCFCoreFoundationVersionNumber_iOS_7_0)
        [self removeSpecifierID:@"canScrobbleRadio"];

    Boolean hasRadio = 1;
    if (kCFCoreFoundationVersionNumber <= kCFCoreFoundationVersionNumber_iOS_6_1)
        hasRadio = GSSystemHasCapability(kGSCellularDataCapability);
    else
    {
        hasRadio = MGGetBoolAnswer(kMGHasBaseband);
    }

    if (!hasRadio)
    {
        [self removeSpecifierID:@"scrobbleOverEDGE"];
    }

	return _specifiers;
}

-(NSString *)tracksScrobbled{

    int itotalscrobbled = [[[SharedPrefs sharedInstance].prefs objectForKey:@"totalScrobbled"] integerValue];
    return [NSString stringWithFormat:@"%d", itotalscrobbled];
}

-(NSString *)queueCount{

    NSString *iqueuecount = [[SharedPrefs sharedInstance].prefs objectForKey:@"queueCount"];
    return iqueuecount;
}

-(NSString *)lastTrackScrobbled{

    NSString *iartist = [[[SharedPrefs sharedInstance].prefs objectForKey:@"lastScrobble"] objectForKey:@"artist"];
    NSString *ititle = [[[SharedPrefs sharedInstance].prefs objectForKey:@"lastScrobble"] objectForKey:@"title"];
    return [NSString stringWithFormat:@"%@ - %@", iartist, ititle];
}

-(NSString *)scrobblerState{

    int iscrobblerstate = [[[SharedPrefs sharedInstance].prefs objectForKey:@"scrobblerState"] integerValue];

    switch(iscrobblerstate) {
        case SCROBBLER_OFFLINE:
            return @"Offline";
        case SCROBBLER_AUTHENTICATING:
            return @"Authenticating";
        case SCROBBLER_READY:
            return @"Online";
        case SCROBBLER_SCROBBLING:
            return @"Scrobbling";
        case SCROBBLER_NOWPLAYING:
            return @"Updating Now Playing";
    }

    return @"Unknown";
}

-(void)restartDaemon{
    system("launchctl unload /System/Library/LaunchDaemons/org.nodomain.scrobbled.plist");
    system("launchctl load /System/Library/LaunchDaemons/org.nodomain.scrobbled.plist");

    [self reload];
}

-(void)githubButtonPressed{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/comscandiumplumbumd/scrobbl"]];
}

@end

