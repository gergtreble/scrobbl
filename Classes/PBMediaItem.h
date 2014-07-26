#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MediaRemote.h"

@interface PBMediaItem : NSManagedObject

@property NSString *title;
@property NSString *artist;
@property NSString *album;
@property NSNumber *duration;
@property NSNumber *timestamp;
@property NSNumber *ignoredCode;

@end
