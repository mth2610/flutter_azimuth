#import "AzimuthPlugin.h"
#import <azimuth/azimuth-Swift.h>

@implementation AzimuthPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAzimuthPlugin registerWithRegistrar:registrar];
}
@end
