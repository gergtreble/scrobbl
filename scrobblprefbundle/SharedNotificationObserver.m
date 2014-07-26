#import "SharedNotificationObserver.h"

@implementation SharedNotificationObserver

+(SharedNotificationObserver *)sharedInstance{

    static SharedNotificationObserver *inst = nil;
    if (!inst)
    {
        inst = [[[self class] alloc] init];

        if (!inst.center){
            inst.center = [NSDistributedNotificationCenter defaultCenter];
            [inst registerForNotifications];
        }
    }
    return inst;

}

-(void)unregisterForNotifications{

    [self.center removeObserver:self];
}

-(void)dealloc{

    [self unregisterForNotifications];
}

-(void)registerForNotifications{

    [self.center addObserver:self selector:@selector(didGetTracksInQueue:) name:@"queueTracks" object:@"com.pb.scrobbled"];
    [self.center addObserver:self selector:@selector(didGetDeletedTracksInQueue:) name:@"deletedTracks" object:@"com.pb.scrobbled"];
}

-(void)getTracksInQueue{

    [self.center postNotificationName:@"getTracksInQueue" object:@"com.pb.scrobbled" userInfo:nil deliverImmediately:YES];
}

-(void)getQueueCount{

    [self.center postNotificationName:@"getQueueCount" object:@"com.pb.scrobbled" userInfo:nil deliverImmediately:YES];
}

-(void)didGetTracksInQueue:(NSNotification *)notification{

    [self.delegate gotTracksInQueue:[notification userInfo]];
}

-(void)didGetDeletedTracksInQueue:(NSNotification *)notification{

    [self.delegate tracksWereDeleted:[notification userInfo]];
}

-(void)deleteTrackInQueue:(NSDictionary *)info{

    // The key must be a timestamp; the value does not matter.

    [self.center postNotificationName:@"deleteTrackInQueue" object:@"com.pb.scrobbled" userInfo:info deliverImmediately:YES];
}

@end
