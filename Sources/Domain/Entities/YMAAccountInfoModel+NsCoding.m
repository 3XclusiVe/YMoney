//
//  YMoney
//
//  Created by Дмитрий on 09.12.15.
//  Copyright © 2015 DMA. All rights reserved.
//

#import "YMAAccountInfoModel+NSCoding.h"

NSString * kAccountIdKey = @"accountId";
NSString * kBalanceKey = @"balance";
NSString * kCurrencyKey = @"currency";
NSString * kAccountStatusKey = @"accountStatus";
NSString * kAccountTypeKey = @"accountType";
NSString * kAvatarKey = @"avatar";

@implementation YMAAccountInfoModel (NSCoding)

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.account forKey:kAccountIdKey];
    [encoder encodeObject:self.balance forKey:kBalanceKey];
    [encoder encodeObject:self.currency forKey:kCurrencyKey];
    [encoder encodeInt:self.accountStatus forKey:kAccountStatusKey];
    [encoder encodeInt:self.accountType forKey:kAccountTypeKey];
    [encoder encodeObject:self.avatar forKey:kAvatarKey];
}

- (id<NSCoding>)initWithCoder:(NSCoder *)decoder {
    
    self = [self decode:decoder];
    
    return self;
}

#pragma mark - Private methods
-(instancetype) decode:(NSCoder *)decoder {
    
    NSString* accountId = [decoder decodeObjectForKey: kAccountIdKey];
    NSString* balance = [decoder decodeObjectForKey:kBalanceKey];
    NSString* currency = [decoder decodeObjectForKey:kCurrencyKey];
    YMAAccountStatus status = [decoder decodeIntForKey:kAccountStatusKey];
    YMAAccountType type = [decoder decodeIntForKey:kAccountTypeKey];
    YMAAvatarModel* avatar = [decoder decodeObjectForKey:kAvatarKey];
    
    
    return [YMAAccountInfoModel accountInfoWithAccount:accountId
                                               balance:balance
                                              currency:currency
                                         accountStatus:status
                                           accountType:type
                                                avatar:avatar
                                        balanceDetails:nil
                                           cardsLinked:nil
                                    servicesAdditional:nil
                                          yamoneyCards:nil];
    
}



@end
