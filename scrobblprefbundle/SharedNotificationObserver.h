#import "NSDistributedNotificationCenter.h"

@protocol SharedNotificationObserverDelegate <NSObject>

-(void)tracksWereDeleted:(NSDictionary *)tracks;
-(void)gotTracksInQueue:(NSDictionary *)tracks;

@end

@interface SharedNotificationObserver : NSObject {

}

@property NSDistributedNotificationCenter *center;
@property id <SharedNotificationObserverDelegate> delegate;

+(SharedNotificationObserver *)sharedInstance;

-(void)getTracksInQueue;
-(void)getQueueCount;

-(void)deleteTrackInQueue:(NSDictionary *)info;

-(void)didGetTracksInQueue:(NSNotification *)notification;
-(void)didGetDeletedTracksInQueue:(NSNotification *)notification;

@end
