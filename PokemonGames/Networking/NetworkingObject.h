//
//  NetworkingObject.h
//  PokemonGames
//
//  Created by noverio joe on 13/02/22.
//
#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NetworkingObject : NSObject

@property NSString* basedUrl;

-(void)performRequestWithHTTPRequest : (NSMutableURLRequest*)httpRequest onCompleted : (void (^)(id))onPerformWithUrlFinish;
//-(void)performRequestWithAction : (NSString*)actionMethod requestData : (NSDictionary*)data onCompleted : (void (^)(id))onPerformWithUrlFinish;
//-(void)performRequestWithUrlEncoded : (NSString*)url requestData : (NSDictionary*)data onCompleted : (void (^)(id))onPerformWithUrlFinish;
//-(void)performRequestGetWithAction : (NSString*)actionMethod requestData : (NSString*)data onCompleted : (void (^)(id))onPerformWithUrlFinish;

+(NetworkingObject*)sharedManager;

@end

NS_ASSUME_NONNULL_END
