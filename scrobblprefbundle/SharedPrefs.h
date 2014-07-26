@interface SharedPrefs : NSObject

@property (nonatomic) NSUserDefaults *defaults;
@property (nonatomic) NSMutableDictionary *prefs;

+(SharedPrefs *)sharedInstance;

@end
