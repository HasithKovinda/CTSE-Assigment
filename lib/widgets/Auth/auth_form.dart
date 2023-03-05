import 'dart:io';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String userName, String password,
      bool isLogin, BuildContext context) submitBtn;
  final bool loading;
  const AuthForm({Key? key, required this.submitBtn, required this.loading})
      : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userName = '';
  String _emailAddress = '';
  String _password = '';

//get the user input after clicked the button
  void formSubmit() {
    final _isValid = _formKey.currentState!.validate();

    if (_isValid) {
      _formKey.currentState!.save();
      //close the keyboard by after submit the from
      FocusScope.of(context).unfocus();
      widget.submitBtn(
        _emailAddress.trim(),
        _userName.trim(),
        _password.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin)
                  TextFormField(
                      key: const ValueKey('userName'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'User Name must contain at least 4 characters';
                        } else {
                          return null;
                        }
                      },
                      decoration:
                          const InputDecoration(label: Text('User Name')),
                      onSaved: (newValue) => _userName = newValue as String),
                TextFormField(
                  key: const ValueKey('email'),
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: false,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      const InputDecoration(label: Text('Email Address')),
                  onSaved: (newValue) => _emailAddress = newValue as String,
                ),
                TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Password must contain at least 5 characters';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(label: Text('Password')),
                    obscureText: true,
                    onSaved: (newValue) => _password = newValue as String),
                const SizedBox(
                  height: 10,
                ),
                if (widget.loading)
                  CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                if (!widget.loading)
                  ElevatedButton(
                    onPressed: formSubmit,
                    style: ElevatedButton.styleFrom(
                        primary: Colors.pink,
                        onPrimary: Colors.white,
                        fixedSize: const Size(80, 30),
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Text(_isLogin ? 'Login' : ' Signup'),
                  ),
                if (!widget.loading)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    child: Text(_isLogin
                        ? 'Create New Account'
                        : 'I already have an account'),
                  )
              ],
            )),
      )),
    ));
  }
}
