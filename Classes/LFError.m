#import "LFError.h"

@implementation LFError

-(NSString *)description{

    return [NSString stringWithFormat:@"%u: %@",(unsigned)self.error, self.message];
}

@end
