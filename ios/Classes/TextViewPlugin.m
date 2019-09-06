#import "TextViewPlugin.h"
//#import "GeneratedPluginRegistrant.h"

@interface MyNativeView : UIView<FlutterPlatformView>

@property (nonatomic, strong) FlutterMethodChannel* channel;

- (instancetype)initWithWithFrame:(CGRect)frame
                   viewIdentifier:(int64_t)viewId
                        arguments:(id _Nullable)args
                  binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end


@interface TextViewPlugin ()
{
    NSObject<FlutterBinaryMessenger>*_messenger;
}

@end

@implementation TextViewPlugin


- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager{
    self = [super init];
    if (self) {
        _messenger = messager;
    }
    return self;
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
            return [[MyNativeView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
                                         
 } 
  

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
 
    TextViewPlugin * channel = [[TextViewPlugin alloc] initWithMessenger:registrar.messenger]; 
    [registrar registerViewFactory:channel withId:@"TextViewPlugin"];
        
    
}


@end



@implementation MyNativeView


- (instancetype)initWithWithFrame:(CGRect)frame
                   viewIdentifier:(int64_t)viewId
                        arguments:(id _Nullable)args
                  binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
                  
    self = [super initWithFrame:frame];
    if (self) { 
        self.backgroundColor = [UIColor redColor];      
        NSString* channelName = [NSString stringWithFormat:@"plugins.felix.angelov/textview_%lld", viewId];
            _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        __weak __typeof__(self) weakSelf = self;
        [_channel setMethodCallHandler:^(FlutterMethodCall *  call, FlutterResult  result) {
            [weakSelf onMethodCall:call result:result];
        }];        
    }
    return self;
}
 

- (nonnull UIView *)view { 
    return self;
}  

- (void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {

  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS" stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } 
  else if ([@"setText" isEqualToString:call.method]){ 
     result(@"hello");
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}
 
@end
