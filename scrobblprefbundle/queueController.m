#import "SharedNotificationObserver.h"
#import <Preferences/PSEditableListController.h>
#import <Preferences/PSSpecifier.h>

extern NSString* PSDeletionActionKey;

@interface queueController: PSEditableListController<SharedNotificationObserverDelegate> {
    SharedNotificationObserver *observer;
}
@property NSDictionary *tracks;
@end

@implementation queueController

-(id)init{

    self = [super init];
    if (self)
    {
        observer = [SharedNotificationObserver sharedInstance];
        observer.delegate = self;
        [observer getTracksInQueue];
    }

    return self;
}

-(PSSpecifier *)specifierWithTimestamp:(NSNumber *)timestamp trackName:(NSString *)trackName{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    NSString *title = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]]];
    PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:title target:self set:nil get:@selector(trackForSpecifier:) detail:nil cell:PSTitleValueCell edit:0];
    [specifier setProperty:trackName forKey:@"trackName"];
    [specifier setProperty:[timestamp stringValue] forKey:@"id"];
    [specifier setProperty:timestamp forKey:@"timestamp"];
    [specifier setProperty:NSStringFromSelector(@selector(removedSpecifier:)) forKey:PSDeletionActionKey];
    return specifier;
}

-(NSString *)trackForSpecifier:(PSSpecifier *)specifier{

    return [specifier propertyForKey:@"trackName"];
}

-(void)removedSpecifier:(PSSpecifier *)specifier{

    [observer deleteTrackInQueue:@{[[specifier propertyForKey:@"timestamp"] stringValue]:@""}];
}

-(void)tracksWereDeleted:(NSDictionary *)tracks{

    for (NSString *timestamp in tracks){

        [self removeSpecifierID:timestamp animated:YES];
    }
}

-(void)gotTracksInQueue:(NSDictionary *)tracks{

    NSMutableArray *specifiers = [[NSMutableArray alloc] init];
    for (NSNumber *timestamp in tracks){
        [specifiers addObject:[self specifierWithTimestamp:[NSNumber numberWithLongLong: [timestamp longLongValue]] trackName:[tracks objectForKey:timestamp]]];
    }

    [self insertContiguousSpecifiers:specifiers atIndex:0 animated:YES];
}

@end
