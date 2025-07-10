//perfect
import 'package:dragable_app/app.dart';
import 'package:dragable_app/constants/icons.dart';
import 'package:dragable_app/constants/sizes.dart';
import 'package:dragable_app/widgets/txtfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _onLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: displaysize.height * .02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: displaysize.height * .1),
              Txt('Hello, Welcome Back 👋🏻', size: sizes.titleLarge(context), font: Font.semiBold),

              SizedBox(height: displaysize.height * .02),
              SizedBox(
                width: displaysize.width * .8,
                child: Txt(
                  'Provide your email id & password to login and access your account.',
                  size: sizes.bodyMedium(context),
                  font: Font.medium,
                ),
              ),
              SizedBox(height: displaysize.height * .04),
              Center(child: Image.asset(icons.illust2, height: displaysize.height * .3)),
              SizedBox(height: displaysize.height * .02),
              Column(
                children: List.generate(2, (index) {
                  final fieldData = ['Email ID', 'Password'];
                  return Column(
                    children: [
                      SizedBox(height: displaysize.height * .02),
                      TextField(
                        decoration: InputDecoration(
                          hintText: fieldData[index],
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(height: displaysize.height * .02),
              Center(
                child: SizedBox(
                  width: displaysize.width,
                  height: displaysize.height * .06,
                  child: CupertinoButton.filled(
                    child: Center(
                      child: Txt(
                        'Log In',
                        font: Font.semiBold,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    onPressed: () {
                      _onLogin(context);
                    },
                  ),
                ),
              ),
              SizedBox(height: displaysize.height * .03),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      indent: displaysize.height * .01,
                      endIndent: displaysize.height * .01,
                    ),
                  ),
                  Txt('Or', color: Theme.of(context).colorScheme.primary),
                  Expanded(
                    child: Divider(
                      indent: displaysize.height * .01,
                      endIndent: displaysize.height * .01,
                    ),
                  ),
                ],
              ),
              SizedBox(height: displaysize.height * .03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  final fielddata = [icons.apple, icons.facebook, icons.google];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: displaysize.height * .01),
                    child: GestureDetector(
                      onTap: () {
                        _onLogin(context);
                      },
                      child: CircleAvatar(
                        radius: displaysize.height * .03,
                        child: Center(
                          child: Image.asset(
                            fielddata[index],
                            height: displaysize.height * .025,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
