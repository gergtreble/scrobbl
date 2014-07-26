#import <Preferences/Preferences.h>
#import "SharedPrefs.h"
#import "../FXKeychain/FXKeychain/FXKeychain.h"

@interface lastFmAuthController: PSListController  {
}
@property (nonatomic) FXKeychain *keychain;
@end

@implementation lastFmAuthController

@synthesize keychain;

-(id)specifiers{

    if(_specifiers == nil) {
        _specifiers = [self loadSpecifiersFromPlistName:@"lastFmAuthController" target:self];
    }

    return _specifiers;
}

-(FXKeychain *)keychain{

    /*
        Preferences.app access group is "apple", using it as well.
        Security.framework won't let us access the keychain otherwise.
    */

    if (!keychain){
        keychain = [[FXKeychain alloc] initWithService:@"pb.scrobbled" accessGroup:@"apple" accessibility:FXKeychainAccessibleAlways];
    }
    return keychain;

}

-(NSString *)getLogin:(PSSpecifier *)specifier{

    NSString *login = [[SharedPrefs sharedInstance].prefs objectForKey:@"lastfm_user"];

    if (login){
        NSLog(@"Found a login in NSUserDefaults, moving it to keychain");
        [self.keychain setObject:login forKey:@"login"];

        [[SharedPrefs sharedInstance].prefs removeObjectForKey:@"lastfm_user"];
        [[SharedPrefs sharedInstance].defaults setPersistentDomain:[SharedPrefs sharedInstance].prefs forName:@"org.nodomain.scrobbled"];
        [[SharedPrefs sharedInstance].defaults synchronize];
    }

    return [self.keychain objectForKey:@"login"];
}

-(NSString *)getPassword:(PSSpecifier *)specifier{

    NSString *password = [[SharedPrefs sharedInstance].prefs objectForKey:@"lastfm_password"];

    if (password){
        NSLog(@"Found a password in NSUserDefaults, moving it to keychain");
        [self.keychain setObject:password forKey:@"password"];

        [[SharedPrefs sharedInstance].prefs removeObjectForKey:@"lastfm_password"];
        [[SharedPrefs sharedInstance].defaults setPersistentDomain:[SharedPrefs sharedInstance].prefs forName:@"org.nodomain.scrobbled"];
        [[SharedPrefs sharedInstance].defaults synchronize];
    }

    return [self.keychain objectForKey:@"password"];
}

-(void)setLogin:(NSString *)login forSpecifier:(PSSpecifier *)specifier{
    [self.keychain setObject:login forKey:@"login"];
}

-(void)setPassword:(NSString *)password forSpecifier:(PSSpecifier *)specifier{
    [self.keychain setObject:password forKey:@"password"];
}

@end
