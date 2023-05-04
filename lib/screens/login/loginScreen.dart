import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/auth.dart';
import 'package:zeehome/model/authProvider.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/network/auth/auth_request.dart';
import 'package:zeehome/network/user/user_request.dart';
import 'package:zeehome/screens/home/homeScreen.dart';
import 'package:zeehome/screens/login/signUpScreen.dart';
import 'package:zeehome/screens/login/forgotPassScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isShowHidePass = true;
  bool emptyPass = false;
  bool passWordError = false;
  bool emailError = false;
  bool isRememberMe = false;
  late SharedPreferences sharedPreferences;

  Auth auth = Auth(access_token: '', refresh_token: '');

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> getLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('email');
    String? password = prefs.getString('pass');

    if (username != null && password != null) {
      emailController.text = username;
      passwordController.text = password;
      setState(() {
        isRememberMe = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getLoginInfo();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ]),
          height: 60,
          // ignore: prefer_const_constructors
          child: TextField(
            controller: emailController,
            // keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.account_circle_outlined,
                color: Color(0xff5ac18e),
              ),
              hintText: 'Nhập email của bạn',
              hintStyle: TextStyle(color: Colors.black38)),
          ),
        ),
        Visibility(
          visible: emailError,
          child: const Text(
            'Vui lòng nhập đúng định dạng Email!',
            style: TextStyle(
              height: 1.25,
              fontSize: 15,
              color: Color.fromARGB(255, 221, 255, 0),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Mật khẩu',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          // ignore: prefer_const_constructors
          child: TextField(
            controller: passwordController,
            obscureText: isShowHidePass,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14),
              prefixIcon: const Icon(
                Icons.lock,
                color: Color(0xff5ac18e),
              ),
              hintText: 'Nhập mật khẩu',
              hintStyle: const TextStyle(color: Colors.black38),
              suffixIcon: showHidePass(),
            ),
          ),
        ),
        Visibility(
          visible: emptyPass,
          child: const Text(
            'Không được bỏ trống!',
            style: TextStyle(
              height: 1.25,
              fontSize: 15,
              color: Color.fromARGB(255, 0, 246, 226),
            ),
          ),
        ),
        Visibility(
          visible: passWordError,
          child: const Text(
            'Mật khẩu dài 8 kí tự!',
            style: TextStyle(
              height: 1.25,
              fontSize: 15,
              color: Color.fromARGB(255, 0, 246, 226),
            ),
          ),
        ),
      ],
    );
  }

  Widget showHidePass() {
    return IconButton(
      onPressed: () {
        setState(() {
          isShowHidePass = !isShowHidePass;
        });
      },
      icon:
          isShowHidePass ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
      color: Colors.green,
    );
  }

  Widget buidForgotPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.only(right: 0),
        ),
        onPressed: () {
          Navigator.of(context).push(scaleIn(forgotPass()));
        },
        child: const Text(
          'Quên mật khẩu?',
          style:
              TextStyle(color: Color(0xffCFA1E6), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildRememberCb() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: const Color(0xffCFA1E6)),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.black,
              activeColor: const Color(0xffCFA1E6),
              onChanged: (bool? value) {
                setState(() {
                  isRememberMe = value!;
                  if (isRememberMe == true) {
                    SharedPreferences.getInstance().then((prefs) {
                      prefs.setString('email', emailController.text);
                      prefs.setString('pass', passwordController.text);                      
                    });
                  } else {
                    SharedPreferences.getInstance().then((prefs) {
                      prefs.remove("email");
                      prefs.remove("pass");
                    });
                  }
                });
              },
            ),
          ),
          const Text(
            'Ghi nhớ tài khoản',
            style: TextStyle(
              color: Color(0xffCFA1E6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoginBtn() {
    return Consumer2<AuthProvider, UserProvider>(
        builder: (context, authProvider, userProvider, child) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        width: 170,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 5,
              padding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              backgroundColor: const Color.fromARGB(255, 0, 106, 255)),
          onPressed: () {
            SignInRequest.fetchAuth(
                emailController.text, passwordController.text)
                .then((data) {
              setState(() {
                access_token:
                data.access_token;
                reresh_token:
                data.refresh_token;
              });
              authProvider.setAccessToken(data.access_token);
              GetUserRequest.fetchUser(data.access_token)
                  .then((data) => {
                userProvider.set(
                    data.gender,
                    data.phoneNumber,
                    data.intro,
                    data.image,
                    data.birthDate,
                    data.firstName,
                    data.lastName,
                    data.email,
                    data.registerAt,
                    data.banned,
                    data.avgRating,
                    data.title,
                    data.role,
                    data.userId,
                    data.balance),
                Navigator.of(context)
                    .push(scaleIn(HomeScreen()))
              });
            });
            checkAllField(emailController.text, passwordController.text)
                ? {
                    SignInRequest.fetchAuth(
                            emailController.text, passwordController.text)
                        .then((data) {
                      setState(() {
                        access_token:
                        data.access_token;
                        reresh_token:
                        data.refresh_token;
                      });
                      authProvider.setAccessToken(data.access_token);
                      GetUserRequest.fetchUser(data.access_token)
                          .then((data) => {
                                userProvider.set(
                                    data.gender,
                                    data.phoneNumber,
                                    data.intro,
                                    data.image,
                                    data.birthDate,
                                    data.firstName,
                                    data.lastName,
                                    data.email,
                                    data.registerAt,
                                    data.banned,
                                    data.avgRating,
                                    data.title,
                                    data.role,
                                    data.userId,
                                    data.balance),
                                Navigator.of(context)
                                    .push(scaleIn(HomeScreen()))
                              });
                    })
                  }
                : '';
          },
          child: Text(
            'Đăng nhập',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      );
    });
  }

  Widget buildAccount() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(scaleIn(SignUpScreen()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Chưa có tài khoản?',
              style: TextStyle(
                color: Color.fromARGB(255, 251, 251, 251),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: ' Đăng kí ngay.',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 248, 249),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateEmail(String t) {
    bool checkEmailField = EmailValidator.validate(emailController.text);
    if (checkEmailField) {
      setState(() {
        emailError = false;
      });
      return true;
    } else {
      setState(() {
        emailError = true;
      });
      return false;
    }
    return false;
  }

  bool validatePass(String t) {
    final regExp = RegExp('.{8,}');
    if (t.isNotEmpty && regExp.hasMatch(t)) {
      setState(() {
        passWordError = false;
        emptyPass = false;
      });
      return true;
    } else if (t.isEmpty) {
      setState(() {
        emptyPass = true;
      });
      return false;
    } else if (t.isNotEmpty && !regExp.hasMatch(t)) {
      setState(() {
        passWordError = true;
        emptyPass = false;
      });
      return false;
    }
    return false;
  }

  bool checkAllField(String emailController, String passwordController) {
    validateEmail(emailController);
    validatePass(passwordController);
    if (validateEmail(emailController) && validatePass(passwordController)) {
      return true;
    }
    return false;
  }

  Route scaleIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = 0.9;
        var end = 1.0;
        var curve = Curves.easeInOutBack;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var tween2 =
            Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

        return ScaleTransition(
          scale: animation.drive(tween),
          child: FadeTransition(
            opacity: animation.drive(tween2),
            child: page,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      // width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 2))
                          ]),
                      child: Image.asset(
                        "assets/logo.png",
                        width: 60,
                        height: 60,
                      ),
                    ),
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Zee ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 40,
                              fontWeight: FontWeight.w900)),
                      TextSpan(
                          text: 'Home',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 40,
                              fontWeight: FontWeight.w500))
                    ])),
                    SizedBox(
                      height: 50,
                    ),
                    buildEmail(),
                    SizedBox(
                      height: 20,
                    ),
                    buildPassword(),
                    buidForgotPassBtn(),
                    buildRememberCb(),
                    buildLoginBtn(),
                    buildAccount(),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
