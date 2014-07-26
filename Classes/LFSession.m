#import "LFSession.h"

@implementation LFSession

-(id)copyWithZone:(NSZone *)zone{
    
    LFSession *ret = [[LFSession allocWithZone:zone] init];
    ret.subscriber = self.subscriber;
    ret.name = self.name;
    ret.key = self.key;
    return ret;
}

@end
