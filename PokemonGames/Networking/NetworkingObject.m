//
//  NetworkingObject.m
//  PokemonGames
//
//  Created by noverio joe on 13/02/22.
//


#import "NetworkingObject.h"
#import "Serializer.h"
#import <AFNetworking/AFNetworking.h>

@interface NetworkingObject()
@property NSArray<NSString*> *listBypassedUrl;
@property NSData* certificateData;
@end
@implementation NetworkingObject

-(id)init {
    if ( self = [super init] ) {
        self.listBypassedUrl = @[@"https://run.mocky.io/v3/",@"https://api.pokemontcg.io/v2"];
    }
    return self;
}

+ (NetworkingObject*)sharedManager {
    static NetworkingObject *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(BOOL)checkByPassHTTPSWithUrl : (NSString*)url{
    BOOL returnValue = NO;
    for (NSString* value in self.listBypassedUrl) {
        if ([url containsString:value]){
            returnValue = YES;
        }
    }
    return returnValue;
}

-(void)performRequestWithHTTPRequest : (NSMutableURLRequest*)httpRequest onCompleted : (void (^)(id))onPerformWithUrlFinish{
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    if ([self checkByPassHTTPSWithUrl:[httpRequest.URL absoluteString]]){
        AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [policy setValidatesDomainName:NO];
        [policy setAllowInvalidCertificates:YES];
        manager.securityPolicy = policy;
    }
    else{
        //Get The Certificates
        AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
        policy.pinnedCertificates = [NSSet setWithArray:@[self.certificateData]];
        [policy setValidatesDomainName:YES];
        [policy setAllowInvalidCertificates:NO];
        manager.securityPolicy = policy;
    }
    
    
    [[manager dataTaskWithRequest:httpRequest uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error != nil){
            onPerformWithUrlFinish(@"SYSTEM_UNAVAILABLE");
        }else{
            onPerformWithUrlFinish(responseObject);
        }
    }] resume];
}

-(void)performRequestWithAction : (NSString*)actionMethod requestData : (NSDictionary*)data onCompleted : (void (^)(id))onPerformWithUrlFinish{
    NSURL *URL = [NSURL URLWithString:[self.basedUrl stringByAppendingString:actionMethod]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    if ([self checkByPassHTTPSWithUrl:actionMethod]){
        AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [policy setValidatesDomainName:NO];
        [policy setAllowInvalidCertificates:YES];
        manager.securityPolicy = policy;
    }
    else{

        AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
        policy.pinnedCertificates = [NSSet setWithArray:@[self.certificateData]];
        [policy setValidatesDomainName:YES];
        [policy setAllowInvalidCertificates:NO];
        manager.securityPolicy = policy;
    }

    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    [manager POST:[URL absoluteString] parameters:data progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        onPerformWithUrlFinish(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        onPerformWithUrlFinish(@"SYSTEM UNAVAILABLE");
    }];
}

-(void)performRequestWithUrlEncoded : (NSString*)url requestData : (NSDictionary*)data onCompleted : (void (^)(id))onPerformWithUrlFinish{
    NSURL *URL = [NSURL URLWithString:url];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    if ([self checkByPassHTTPSWithUrl:url]){
        AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [policy setValidatesDomainName:NO];
        [policy setAllowInvalidCertificates:YES];
        manager.securityPolicy = policy;
    }else{
        AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
        policy.pinnedCertificates = [NSSet setWithArray:@[self.certificateData]];
        [policy setValidatesDomainName:YES];
        [policy setAllowInvalidCertificates:NO];
        manager.securityPolicy = policy;
    }
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager POST:[URL absoluteString] parameters:data progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        onPerformWithUrlFinish(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        onPerformWithUrlFinish(@"SYSTEM UNAVAILABLE");
    }];
}

-(void)performRequestGetWithAction : (NSString*)actionMethod requestData : (NSString*)data onCompleted : (void (^)(id))onPerformWithUrlFinish{
    NSURL *URL = [NSURL URLWithString:[self.basedUrl stringByAppendingString:actionMethod]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    if ([self checkByPassHTTPSWithUrl:actionMethod]){
        AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [policy setValidatesDomainName:NO];
        [policy setAllowInvalidCertificates:YES];
        manager.securityPolicy = policy;
    }
    else{
        //Get The Certificates
        AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
        policy.pinnedCertificates = [NSSet setWithArray:@[self.certificateData]];
        [policy setValidatesDomainName:YES];
        [policy setAllowInvalidCertificates:NO];
        manager.securityPolicy = policy;

    }
   
        
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    [manager GET:[URL absoluteString] parameters:data progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        onPerformWithUrlFinish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        onPerformWithUrlFinish(@"SYSTEM UNAVAILABLE");
        
    }];
}
@end
