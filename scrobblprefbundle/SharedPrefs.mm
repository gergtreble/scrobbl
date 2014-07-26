#import "SharedPrefs.h"

@implementation SharedPrefs

@synthesize defaults;
@synthesize prefs;

+(SharedPrefs *)sharedInstance{

    static SharedPrefs *inst = nil;
    if (!inst)
    {
        inst = [[[self class] alloc] init];

        if (!inst.defaults)
            inst.defaults = [[NSUserDefaults alloc] init];

        [inst.defaults synchronize];
        inst.prefs = [[inst.defaults persistentDomainForName:@"org.nodomain.scrobbled"] mutableCopy];
    }
    return inst;

}

@end
