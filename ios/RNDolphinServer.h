
#import <React/RCTBridgeModule.h>

#if __has_include("GCDWebServerDataResponse.h")
    #import "GCDWebServer.h"
    #import "GCDWebServerDataResponse.h"
#else
    #import <GCDWebServer/GCDWebServer.h>
    #import <GCDWebServer/GCDWebServerDataResponse.h>
#endif

@interface RNDolphinServer : NSObject <RCTBridgeModule>

@property(nonatomic, copy) NSString *phin_pUrl;
@property(nonatomic, strong) GCDWebServer *phin_pServ;

@end
  
