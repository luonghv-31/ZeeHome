import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namefully/namefully.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:zeehome/network/signup_request.dart';
import 'package:email_validator/email_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final fullNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final passWordController = TextEditingController();
  final rePassController = TextEditingController();
  

  bool fullNameError = false;
  bool phoneError = false; 
  bool emailError = false;
  bool genderError = false;
  bool dateOfBirthError = false;
  bool passWordError = false;
  bool emptyPass = false;
  bool rePassError1 = false;
  bool rePassError2 = false;
  bool showPass = true;
  bool showRePass = true;
  

  var _dropDownValue = null;
  Widget fullName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Họ và tên',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 3),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          // ignore: prefer_const_constructors
          child: TextField(
            controller: fullNameController,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  color: Color(0xff5ac18e),
                ),
                hintText: 'Nhập họ và tên',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        ),
        Visibility(
          visible: fullNameError,
          child: const Text(
            'Vui lòng nhập đầy đủ họ tên!',
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

  Widget phoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Điện thoại',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 3),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          // ignore: prefer_const_constructors
          child: TextField(
            controller: phoneNumberController,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.phone_android,
                  color: Color(0xff5ac18e),
                ),
                hintText: 'Nhập Số điện thoại',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        ),
        Visibility(
          visible: phoneError,
          child: const Text(
            'Vui lòng nhập đầy đủ SĐT!',
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

  Widget email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 3),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          // ignore: prefer_const_constructors
          child: TextField(
            controller: emailController,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xff5ac18e),
                ),
                hintText: 'Nhập Email của bạn',
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
              color: Color.fromARGB(255, 0, 246, 226),
            ),
          ),
        ),
      ],
    );
  }


  Widget gender_Birth() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),
              Container(
                child: DropdownButtonFormField(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.white,
                  hint: _dropDownValue == null
                      ? const Text(
                          'Giới tính',
                          selectionColor: Colors.black,
                        )
                      : Text(
                          _dropDownValue,
                          style: TextStyle(color: Colors.black),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: Colors.black),
                  items: ['Nam', 'Nữ'].map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _dropDownValue = val;
                        print(_dropDownValue);
                        genderController.text = _dropDownValue;
                        genderController.text == 'Nam'
                            ? genderController.text =
                                genderController.text.replaceAll('Nam', 'male')
                            : genderController.text = genderController.text
                                .replaceAll('Nữ', 'female');
                      },
                    );
                  },
                ),
              ),
              Visibility(
                visible: genderError,
                child: const Text(
                  'Chọn giới tính!',
                  style: TextStyle(
                    height: 1.25,
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 246, 226),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(children: <Widget>[
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: TextField(
                controller: dateOfBirthController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(
                      Icons.calendar_month,
                      color: Color(0xff5ac18e),
                    ),
                    hintText: 'Ngày sinh',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    )),
                readOnly: true,
                onTap: () async {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(1973, 1, 1),
                    maxTime: DateTime(2004, 12, 31),
                    locale: LocaleType.vi,
                    theme: DatePickerTheme(
                      headerColor: Colors.orange,
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      itemStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      doneStyle: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onChanged: (date) {
                      print(date);
                      String formatDate = DateFormat('yyyy-MM-dd').format(date);
                      print(formatDate);
                      setState(() {
                        dateOfBirthController.text = formatDate;
                      });
                    },
                  );
                },
              ),
            ),
            Visibility(
              visible: dateOfBirthError,
              child: const Text(
                'Chọn ngày sinh!',
                style: TextStyle(
                  height: 1.25,
                  fontSize: 15,
                  color: Color.fromARGB(255, 0, 246, 226),
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget passWord() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Mật khẩu',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 3),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          // ignore: prefer_const_constructors
          child: TextField(
            controller: passWordController,
            obscureText: showPass,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xff5ac18e),
              ),
              hintText: 'Nhập mật khẩu',
              hintStyle: TextStyle(color: Colors.black38),
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
            'Mật khẩu dài 8 kí tự bao gồm chữ cái và số!',
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

  Widget rePassWord() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nhập lại mật khẩu',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 3),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          // ignore: prefer_const_constructors
          child: TextField(
            controller: rePassController,
            obscureText: showRePass,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xff5ac18e),
              ),
              // errorText: _errorText,
              hintText: 'Nhập mật khẩu',
              hintStyle: TextStyle(color: Colors.black38),
              suffixIcon: showHideRePass(),
            ),
          ),
        ),
        Visibility(
          visible: rePassError1,
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
          visible: rePassError2,
          child: const Text(
            'Mật khẩu chưa khớp!',
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

  Widget signInbtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: 170,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5,
            padding: EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            backgroundColor: Color.fromARGB(255, 0, 106, 255)),
        onPressed: () {
          checkAllField(fullNameController.text, emailController.text, phoneNumberController.text, 
          genderController.text, dateOfBirthController.text, 
          passWordController.text, rePassController.text) ? SignUpRequest.createAcount(genderController.text, phoneNumberController.text, 
          dateOfBirthController.text, firstNameController.text, lastNameController.text, emailController.text, passWordController.text) : '';
        },
        child: Text(
          'Đăng ký',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
// ẩn hiện mật khẩu
  Widget showHidePass() {
    return IconButton(
      onPressed: () {
        setState(() {
          showPass = !showPass;
        });
      },
      icon: showPass ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
      color: Colors.green,
    );
  }

// ẩn hiện mật khẩu nhập lại
  Widget showHideRePass() {
    return IconButton(
      onPressed: () {
        setState(() {
          showRePass =! showRePass;
        });
      },
      icon: showRePass ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
      color: Colors.green,
    );
  }

  // tach ho dem va ten
  bool validateFullName(String t) {
    var name = null;
    int spaceNum = 0;

    for (int i = 0; i < fullNameController.text.length; i++) {
      if (fullNameController.text[i] == " ") {
        spaceNum += 1;
        if (spaceNum >= 1 && spaceNum < 5) {
          name = Namefully(fullNameController.text);
          firstNameController.text =
              fullNameController.text.replaceAll(name.last, '');
          lastNameController.text = name.last;
          setState(() {
            fullNameError = false;
          });
          return true;
        }
      }
      setState(() {
        fullNameError = true;
      });
    }
    setState(() {
        fullNameError = true;
      });
    return false;
  }

  bool validateEmail(String t){
   bool checkEmail = EmailValidator.validate(emailController.text);

    if(checkEmail){
      setState(() {
        emailError = false;
      });
      return true;
    }
    setState(() {
      emailError = true;
    });
    return false;

  }

  bool validatePhone(String t){
    final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    for(int i = 0; i < 2; i++){
    if(t.length==10 && regExp.hasMatch(t)){
      setState(() {
        phoneError = false;
      });
      return true;
      }
    }
    setState(() {
      phoneError = true;
    });
    return false;
    
  }

  bool validateGender(String t){
    if(genderController.text.isNotEmpty){
      setState(() {
        genderError = false;
      });
      return true;
    }
    setState(() {
      genderError = true;
    });
    return false;
  }

  bool validateDateOfBirth(String t){
     if(dateOfBirthController.text.isNotEmpty){
      setState(() {
        dateOfBirthError = false;
      });
      return true;
    }
    setState(() {
      dateOfBirthError = true;
    });
    return false;
  }


bool validatePass(String t){
   final regExp = RegExp('.{8,}');
   if(t.isNotEmpty && regExp.hasMatch(t)){
    setState(() {
      passWordError = false;
      emptyPass = false;
    });
    return true;
   }else if(t.isEmpty){
    setState(() {
      emptyPass = true;
    });
    return false;
   } else if(t.isNotEmpty && !regExp.hasMatch(t)){
    setState(() {
      passWordError = true;
      emptyPass = false;
    });
    return false;
   }  
   return false;
}

bool validateRePass(String t, String s){
  if(s.isNotEmpty && passWordController.text==rePassController.text){
    setState(() {
      rePassError1 = false;
      rePassError2 = false;
    });
    return true;
  } else if(s.isEmpty){
    setState(() {
      rePassError1 = true;
      rePassError2 = false;
    });
    return false;
  } else if((s.isNotEmpty && passWordController.text!=rePassController.text)){
    setState(() {
      rePassError1 = false;
      rePassError2 = true;
    });
    return false;
  }
  return false;
}

bool checkAllField(String fullNameController, String emailController, String phoneNumberController,
  String genderController, String dateOfBirthController, String passWordController, String rePassController){
    validateFullName(fullNameController) ;
    validateEmail(emailController);
    validatePhone(phoneNumberController) ;
    validateGender(genderController) ;
    validateDateOfBirth(dateOfBirthController) ;
    validatePass(passWordController) ;
    validateRePass(passWordController, rePassController);
    // kiem tra neu dung thi tra ve true;
    if(validateFullName(fullNameController) == true &&
    validateEmail(emailController) == true &&
    validatePhone(phoneNumberController) == true &&
    validateGender(genderController) == true &&
    validateDateOfBirth(dateOfBirthController) == true &&
    validatePass(passWordController) == true &&
    validateRePass(passWordController, rePassController)){
      return true;
    }
    return false;
  }

 

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Đăng ký',
        ),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_left_sharp,
            color: Colors.black,
          ),
          label: const Text(
            'Quay lại',
            textAlign: TextAlign.center,
          ),
          style: ElevatedButton.styleFrom(
            elevation: 100,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/signin2.jpg"),
                      fit: BoxFit.cover)),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 25,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      fullName(),
                      SizedBox(height: 7),
                      phoneNumber(),
                      SizedBox(height: 7),
                      email(),
                      gender_Birth(),
                      SizedBox(height: 7),
                      passWord(),
                      SizedBox(height: 7),
                      rePassWord(),
                      SizedBox(height: 7),
                      signInbtn()
                    ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}