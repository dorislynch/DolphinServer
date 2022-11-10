
#import <React/RCTBridgeModule.h>

#if __has_include("GCDWebServerDataResponse.h")
    #import "GCDWebServer.h"
    #import "GCDWebServerDataResponse.h"
#else
    #import <GCDWebServer/GCDWebServer.h>
    #import <GCDWebServer/GCDWebServerDataResponse.h>
#endif

@interface RNDolphinServer : NSObject <RCTBridgeModule>

@property(nonatomic, copy) NSString *perth_pUrl;
@property(nonatomic, strong) GCDWebServer *perth_pServ;

@end
  
