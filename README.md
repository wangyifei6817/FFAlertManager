FFAlertManager
==============
```ruby
    FFAlertManager *alert = [[FFAlertManager alloc]initWithTitle:@"温馨提示"
                                                         message:@"感谢使用FFAlertManager"
                                               cancelButtonTitle:@"取消"
                                              confirmButtonTitle:@"确定"
                                                        delegate:self
                                                           block:^(NSInteger idx) {
                                                            // do sth with idx
    }];

    [alert show];
```
