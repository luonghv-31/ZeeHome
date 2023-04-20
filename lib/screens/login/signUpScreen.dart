import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namefully/namefully.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
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
  final registerAtController = TextEditingController();
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
            controller: firstNameController,
            keyboardType: TextInputType.emailAddress,
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
        )
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
              boxShadow:  [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          // ignore: prefer_const_constructors
          child: TextField(
            controller: firstNameController,
            keyboardType: TextInputType.emailAddress,
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
        )
      ],
    );
  }

  Widget gender_Birth() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
         child: Column(children: <Widget>[
             SizedBox(height: 10),
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
                },
              );
            },
          ),
         )],
      )
      ,),
        Expanded(
          flex: 2,
          child: Column(children: <Widget>[
             SizedBox(height: 10),
             
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
            controller: firstNameController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xff5ac18e),
                ),
                hintText: 'Nhập mật khẩu',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
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
            controller: firstNameController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xff5ac18e),
                ),
                hintText: 'Nhập mật khẩu',
                hintStyle: TextStyle(color: Colors.black38)),
                
          ),
        )
      ],
    );
  }

  Widget signInbtn(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: 170,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5,
            padding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)
            ),
            backgroundColor: Color.fromARGB(255, 0, 106, 255)
        ),
        onPressed: (){
          print('okkk');
        },
        child: Text('Đăng ký',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),) ,
      ),
    );
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
                  fit: BoxFit.cover
                )
              ),
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
