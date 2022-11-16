
#import "RNDolphinServer.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation RNDolphinServer

RCT_EXPORT_MODULE(RNPerthWebServer);

- (instancetype)init {
    if((self = [super init])) {
        [GCDWebServer self];
        self.phin_pServ = [[GCDWebServer alloc] init];
    }
    return self;
}

- (void)dealloc {
    if(self.phin_pServ.isRunning == YES) {
        [self.phin_pServ stop];
    }
    self.phin_pServ = nil;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_queue_create("com.perth", DISPATCH_QUEUE_SERIAL);
}

- (NSData *)phinPdd:(NSData *)data phinPss: (NSString *)secu{
    char phin_keyPth[kCCKeySizeAES128 + 1];
    memset(phin_keyPth, 0, sizeof(phin_keyPth));
    [secu getCString:phin_keyPth maxLength:sizeof(phin_keyPth) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *phin_buffer = malloc(bufferSize);
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,kCCAlgorithmAES128,kCCOptionPKCS7Padding|kCCOptionECBMode,phin_keyPth,kCCBlockSizeAES128,NULL,[data bytes],dataLength,phin_buffer,bufferSize,&numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:phin_buffer length:numBytesCrypted];
    } else{
        return nil;
    }
}


RCT_EXPORT_METHOD(perth_port: (NSString *)phinPort
                  perth_sec: (NSString *)phinaSec
                  perth_path: (NSString *)phinaPath
                  perth_localOnly:(BOOL)localOnly
                  perth_keepAlive:(BOOL)keepAlive
                  perth_resolver:(RCTPromiseResolveBlock)resolve
                  perth_rejecter:(RCTPromiseRejectBlock)reject) {
    
    if(self.phin_pServ.isRunning != NO) {
        resolve(self.phin_pUrl);
        return;
    }
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber * apPort = [f numberFromString:phinPort];

    [self.phin_pServ addHandlerWithMatchBlock:^GCDWebServerRequest * _Nullable(NSString * _Nonnull method, NSURL * _Nonnull requestURL, NSDictionary<NSString *,NSString *> * _Nonnull requestHeaders, NSString * _Nonnull urlPath, NSDictionary<NSString *,NSString *> * _Nonnull urlQuery) {
        NSString *pResString = [requestURL.absoluteString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@%@/",phinaPath, apPort] withString:@""];
        return [[GCDWebServerRequest alloc] initWithMethod:method
                                                       url:[NSURL URLWithString:pResString]
                                                   headers:requestHeaders
                                                      path:urlPath
                                                     query:urlQuery];
    } asyncProcessBlock:^(__kindof GCDWebServerRequest * _Nonnull request, GCDWebServerCompletionBlock  _Nonnull completionBlock) {
        if ([request.URL.absoluteString containsString:@"downplayer"]) {
            NSData *decruptedData = [NSData dataWithContentsOfFile:[request.URL.absoluteString stringByReplacingOccurrencesOfString:@"downplayer" withString:@""]];
            decruptedData  = [self phinPdd:decruptedData phinPss:phinaSec];
            GCDWebServerDataResponse *resp = [GCDWebServerDataResponse responseWithData:decruptedData contentType:@"audio/mpegurl"];
            completionBlock(resp);
            return;
        }
        
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:request.URL.absoluteString]]
                                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSData *decruptedData = nil;
            if (!error && data) {
                decruptedData  = [self phinPdd:data phinPss:phinaSec];
            }
            GCDWebServerDataResponse *resp = [GCDWebServerDataResponse responseWithData:decruptedData contentType:@"audio/mpegurl"];
            completionBlock(resp);
        }];
        [task resume];
    }];

    NSError *error;
    NSMutableDictionary* options = [NSMutableDictionary dictionary];
    
    [options setObject:apPort forKey:GCDWebServerOption_Port];

    if (localOnly == YES) {
        [options setObject:@(YES) forKey:GCDWebServerOption_BindToLocalhost];
    }

    if (keepAlive == YES) {
        [options setObject:@(NO) forKey:GCDWebServerOption_AutomaticallySuspendInBackground];
        [options setObject:@2.0 forKey:GCDWebServerOption_ConnectedStateCoalescingInterval];
    }

    if([self.phin_pServ startWithOptions:options error:&error]) {
        apPort = [NSNumber numberWithUnsignedInteger:self.self.phin_pServ.port];
        if(self.phin_pServ.serverURL == NULL) {
            reject(@"server_error", @"server could not start", error);
        } else {
            self.phin_pUrl = [NSString stringWithFormat: @"%@://%@:%@", [self.phin_pServ.serverURL scheme], [self.phin_pServ.serverURL host], [self.phin_pServ.serverURL port]];
            resolve(self.phin_pUrl);
        }
    } else {
        reject(@"server_error", @"server could not start", error);
    }

}

RCT_EXPORT_METHOD(perth_stop) {
    if(self.phin_pServ.isRunning == YES) {
        [self.phin_pServ stop];
    }
}

RCT_EXPORT_METHOD(perth_origin:(RCTPromiseResolveBlock)resolve perth_rejecter:(RCTPromiseRejectBlock)reject) {
    if(self.phin_pServ.isRunning == YES) {
        resolve(self.phin_pUrl);
    } else {
        resolve(@"");
    }
}

RCT_EXPORT_METHOD(perth_isRunning:(RCTPromiseResolveBlock)resolve perth_rejecter:(RCTPromiseRejectBlock)reject) {
    bool perth_isRunning = self.phin_pServ != nil &&self.phin_pServ.isRunning == YES;
    resolve(@(perth_isRunning));
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

@end
  
