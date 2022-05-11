//
//  BasicAPIRequestService.m
//  PokemonGames
//
//  Created by noverio joe on 13/02/22.
//

#import "BasicAPIRequestServices.h"

@implementation BasicAPIRequestServices

-(id)init {
    if ( self = [super init] ) {
        self.baseUrl = @"";
        
        self.cStringId = @"";
        self.cStringS = @"";
        
        self.API_KEY = @"4621617c-5942-4ada-b467-993423b7a8d9";
        self.API_SECRET = @"";
        
        self.grantType = @"";
        self.authorization = @"";
    }
    return self;
}




-(NSString*)getGenerateAuthSignatureSet{
    /* Noverio Joe: Generating Authtentication for OAuth Login --> Just In Case*/
    NSString* authorizationValue =[self.authorization lowercaseString];
    NSString* authorizationValueHash = [Serializer sha256:authorizationValue];
    self.timeStamp = [self getTimeStamp];
    NSString* stringSign = [authorizationValueHash lowercaseString];
    
    NSString* signatureSet = [[Serializer hmac:stringSign withKey:self.authorization] lowercaseString];
    return signatureSet;
}

-(NSString*)getTimeStamp{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSXXX"];
    return [NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
}

-(NSString*)getPOSTRequestSignatureWithRqtData : (NSDictionary*)requestData{
    /* Noverio Joe: Logic for Generating Request Signature Set --> If ANY */
    
    NSString* result = @"POST:";
    
    NSString *jsonStr = [Serializer toJsonStringFromObject:requestData];
    NSString* requestHash = [Serializer sha256:jsonStr];
    
    result = [result stringByAppendingString:[requestHash lowercaseString]];
    
    NSString* signatureSet = [[Serializer hmac:result withKey:self.API_SECRET] lowercaseString];
    return signatureSet;
}

-(NSString*)getGETRequestSignatureWithRqtData{
    /* Noverio Joe: Logic for Generating Request Signature Set --> If ANY */
    NSString* result = @"GET:";
    
    NSString* requestHash = [Serializer sha256:@""];
    
    result = [result stringByAppendingString:[requestHash lowercaseString]];
    
    NSString* signatureSet = [[Serializer hmac:result withKey:self.API_SECRET] lowercaseString];
    return signatureSet;
}

-(NSMutableURLRequest*)getBasicPOSTAuthRequest : (NSDictionary*)requestPayloadJson endpointUrl : (NSString*)url{
    NSURL *URL = [NSURL URLWithString:url];
    
    /* Noverio Joe: Logic for Generating Request Headers --> If ANY */
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:180];
    
    NSString* accessToken = [@"Bearer " stringByAppendingString:@"[ACCESS_TOKEN]"];
    self.timeStamp = [self getTimeStamp];
    NSString* signature = [self getPOSTRequestSignatureWithRqtData:requestPayloadJson];
    NSString* requestPayloadString = [Serializer toJsonStringFromObject:requestPayloadJson];
    
    [request setValue:accessToken forHTTPHeaderField:@"access_token"];
    [request setValue:self.API_KEY forHTTPHeaderField:@"X-Api-Key"];
    [request setValue:self.timeStamp forHTTPHeaderField:@"timestamp"];
    [request setValue:signature forHTTPHeaderField:@"signature"];
    [request setValue:accessToken forHTTPHeaderField:@"Authorization"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requestPayloadString dataUsingEncoding:NSUTF8StringEncoding]];
    
    return request;
}

-(NSMutableURLRequest*)getBasicGETAuthRequestWithEndpointUrl : (NSString*)url{
    NSURL *URL = [NSURL URLWithString:[url stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    /* Noverio Joe: Logic for Generating Request Headers --> If ANY */
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:180];
    
    NSString* accessToken = [@"Bearer " stringByAppendingString:@"[ACCESS_TOKEN]"];
    self.timeStamp = [self getTimeStamp];
    NSString* signature = [self getGETRequestSignatureWithRqtData];
    
    [request setValue:accessToken forHTTPHeaderField:@"access_token"];
    [request setValue:self.API_KEY forHTTPHeaderField:@"X-Api-Key"];
    [request setValue:self.timeStamp forHTTPHeaderField:@"timestamp"];
    [request setValue:signature forHTTPHeaderField:@"signature"];
    [request setValue:accessToken forHTTPHeaderField:@"Authorization"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    [request setHTTPMethod:@"GET"];
    
    return request;
}

-(NSMutableURLRequest*)getPOSTInitOAUTHTokenRequest : (NSDictionary*)requestPayloadJson endpointUrl : (NSString*)url{
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest* oauthRequestToken = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:180];
    NSString* requestPayloadString = [Serializer toJsonStringFromObject:requestPayloadJson];
    
    [oauthRequestToken setValue:self.authorization forHTTPHeaderField:@"oauth-authorization"];
    [oauthRequestToken setValue:[self getGenerateAuthSignatureSet] forHTTPHeaderField:@"signature"];
    [oauthRequestToken setValue:self.timeStamp forHTTPHeaderField:@"timestamp"];
    
    [oauthRequestToken setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [oauthRequestToken setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [oauthRequestToken setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    [oauthRequestToken setHTTPMethod:@"POST"];
    [oauthRequestToken setHTTPBody:[requestPayloadString dataUsingEncoding:NSUTF8StringEncoding]];
    
    return oauthRequestToken;
}

@end
