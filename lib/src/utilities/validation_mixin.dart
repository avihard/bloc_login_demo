import 'dart:async';

import 'dart:math';

class ValidationMixin {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
        if(!email.contains('@')){
          sink.addError('Please enter a valid email.');
        }else {
          sink.add(email);
        }
      });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if(password.length > 8){
        sink.add(password);
      }else {
        sink.addError('Use more than 8 characters.');
      }
    }
  );
}
