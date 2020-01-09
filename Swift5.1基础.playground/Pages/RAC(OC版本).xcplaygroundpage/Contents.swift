/*
 
/// 两个信号合并，
- (void)twoSignalCombine {
    RACSignal *signalA = self.textfield.rac_textSignal;
    RACSignal *signalB = [self.btn rac_signalForControlEvents:UIControlEventTouchUpInside];
        
    [[RACSignal combineLatest:@[signalA, signalB] reduce:^id (id valueA, id valueB) {
        return [NSString stringWithFormat:@"%@---%@", valueA, valueB];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}


/// button textfield
- (void)UIActionRAC {
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"%@",x);
    }];

    [self.textfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    /// 隐射
    [[self.textfield.rac_textSignal flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
        NSLog(@"value = %@",value);
        return [RACReturnSignal return:[NSString stringWithFormat:@"+86%@",value]];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"逻辑：%@",x);
    }];
    
    // 过滤 YES才会发信号，no不发
    [[self.textfield.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        if (self.textfield.text.length > 6) {
            self.textfield.text = [self.textfield.text substringToIndex:6];
        }
        return value.length < 6;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"888:%@",x);
    }];
    
}

/// delegate
- (void)delegateRAC {
    [[self rac_signalForSelector:@selector(textFieldDidBeginEditing:) fromProtocol:@protocol(UITextFieldDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"fromProtocol: %@",x);
    }];
    self.textfield.delegate = self;
}

/// notification
- (void)notificationRAC {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"a" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@",x);
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"a" object:@"a"];
}

/// kvo
- (void)KVORAC {
    [RACObserve(self, name) subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    self.name = @"123";
}

/// array dictionary
- (void)sequenceRAC {
    NSArray * arr = @[@"1",@"2",@"3",@"4"];
    [arr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    NSDictionary * dic = @{@"name":@"co",@"2":@"4"};
    [dic.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

/// RACSignal
- (void)racSignal{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送信号
        [subscriber sendNext:@"123"];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"销毁了");
        }];
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"subscribe:%@", x);
    }];
}

*/
