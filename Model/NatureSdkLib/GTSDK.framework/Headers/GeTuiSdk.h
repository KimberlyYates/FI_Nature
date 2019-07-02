#import <Foundation/Foundation.h>
typedef enum {
    SdkStatusStarting,  
    SdkStatusStarted,   
    SdkStatusStoped,    
    SdkStatusOffline,   
} SdkStatus;
#define kGtResponseBindType @"bindAlias"
#define kGtResponseUnBindType @"unbindAlias"
@protocol GeTuiSdkDelegate;
@interface GeTuiSdk : NSObject
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
#error "GeTuiSDK is requested iOS7 or iOS7 above version"
#endif
#pragma mark - 基本功能
+ (void)startSdkWithAppId:(NSString *)appid appKey:(NSString *)appKey appSecret:(NSString *)appSecret delegate:(id<GeTuiSdkDelegate>)delegate;
+ (void)destroy;
+ (void)resume;
#pragma mark -
+ (NSString *)version;
+ (NSString *)clientId;
+ (SdkStatus)status;
#pragma mark -
+ (BOOL)registerDeviceToken:(NSString *)deviceToken;
+ (BOOL)registerDeviceTokenData:(NSData *)deviceToken;
+ (BOOL)registerVoipToken:(NSString *)voipToken;
+ (BOOL)registerVoipTokenCredentials:(NSData *)voipToken;
#pragma mark -
+ (BOOL)setTags:(NSArray *)tags;
+ (void)setBadge:(NSUInteger)value;
+ (void)resetBadge;
+ (void)setChannelId:(NSString *)aChannelId;
+ (void)setPushModeForOff:(BOOL)isValue;
+ (void)bindAlias:(NSString *)alias andSequenceNum:(NSString *)aSn;
+ (void)unbindAlias:(NSString *)alias andSequenceNum:(NSString *)aSn andIsSelf:(BOOL)isSelf;
#pragma mark -
+ (void)handleRemoteNotification:(NSDictionary *)userInfo;
+ (void)handleVoipNotification:(NSDictionary *)payload;
+ (NSString*)handleApplinkFeedback:(NSURL* )webUrl;
+ (NSString *)sendMessage:(NSData *)body error:(NSError **)error;
+ (BOOL)sendFeedbackMessage:(NSInteger)actionId andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId;
#pragma mark -
+ (void)runBackgroundEnable:(BOOL)isEnable;
+ (void)lbsLocationEnable:(BOOL)isEnable andUserVerify:(BOOL)isVerify;
+ (void)clearAllNotificationForNotificationBar;
@end
#pragma mark - SDK Delegate
@protocol GeTuiSdkDelegate <NSObject>
@optional
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId;
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus;
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId;
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result;
- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error;
- (void)GeTuiSdkDidAliasAction:(NSString *)action result:(BOOL)isSuccess sequenceNum:(NSString *)aSn error:(NSError *)aError;
- (void)GetuiSdkDidQueryTag:(NSArray*)aTags sequenceNum:(NSString *)aSn error:(NSError *)aError;
- (void)GeTuiSdkDidOccurError:(NSError *)error;
@end
