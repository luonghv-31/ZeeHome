import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeehome/network/forget_pass_request.dart';

class forgotPass extends StatefulWidget{
  @override
  _forgotPass createState() => _forgotPass();
}

class _forgotPass extends State<forgotPass>{

final inputEmailController = TextEditingController();

  Widget inputEmail(){
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
            controller: inputEmailController,
            
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

  Widget buildSendEmailBtn(){
    
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

        onPressed: () {          
           ResetPass.sendEmail(inputEmailController.text);
           print(inputEmailController);
        },
        child: Text('Gửi Email', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Quên mật khẩu',
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
                   inputEmail(),
                   SizedBox(height:10),
                   buildSendEmailBtn()
                      
                    ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
     
  }

