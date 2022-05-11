//
//  Serializer.h
//  PokemonGames
//
//  Created by noverio joe on 13/02/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Serializer : NSObject
+(NSString*)toJsonStringFromObject : (id) object;
+(NSString *)hmac:(NSString *)plaintext withKey:(NSString *)key;
+(NSString*)sha256:(NSString *)clear;
+(NSString*)formattedDuration:(NSTimeInterval)interval;
@end

NS_ASSUME_NONNULL_END
