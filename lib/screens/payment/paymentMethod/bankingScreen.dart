
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/authProvider.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/network/payment/banking_request.dart';
import 'package:flutter/services.dart';

class BankingScreen extends StatefulWidget {
  const BankingScreen({super.key});

  @override
  _BankingScreenState createState() => _BankingScreenState();
}

class _BankingScreenState extends State<BankingScreen> {

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: const Color.fromARGB(255, 166, 136, 255),
    primary: Colors.white,
    // minimumSize: const Size(176, 132),
    // maximumSize: const Size(176, 132),
    padding: const EdgeInsets.all(2),
    // padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  final _formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  Widget buildInfo(){
    return Consumer2<AuthProvider, UserProvider>(builder: (context, authProvider, userProvider, child) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tạo thanh toán', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black)),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhập số tiền cần thanh toán (vnd)'
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số tiền';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        debugPrint(amountController.text);
                        if (_formKey.currentState!.validate()) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('Đang chờ xử lý')),
                          // );
                          GetBankingRequest.fetchBanking(authProvider.accessToken, int.parse(amountController.text) * 100, 'string').then((value) => {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Tạo yêu cầu thanh toán thành công!'),
                                  content: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox( height: 12 ),
                                        RichText(
                                          text: TextSpan(
                                            style: DefaultTextStyle.of(context).style,
                                            children: const <TextSpan>[
                                              TextSpan(text: 'Quý khách vui lòng chuyển khoản tới stk: '),
                                              TextSpan(text: '08129312394', style: TextStyle(fontWeight: FontWeight.bold)),
                                              TextSpan(text: ', ngân hàng Teckcombank bank và chờ xác nhận từ admin.'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const Text('Nội dung chuyển khoản:'),
                                        const SizedBox(height: 8),
                                        ElevatedButton(
                                          style: raisedButtonStyle,
                                          onPressed: (){
                                            Clipboard.setData(ClipboardData(text: value)).then((_){
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Đã sao chép nội dung chuyển khoản!")));
                                            });
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 14),
                                                child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black54)),
                                              ),
                                              const Positioned(top: 0, right: 0,child: Icon(Icons.folder_copy, color: Colors.black54,),)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Cancel');

                                      },
                                      child: const Text('Xác nhận'),
                                    ),
                                  ],
                                ),
                            )
                          });
                        }
                      },
                      child: const Text('Tiếp tục', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      );
    });
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background_app.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.keyboard_backspace, color: Colors.white, size: 28,),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                             ),
                          const SizedBox(width: 16,),
                          const Text('Nạp tiền phương thức Banking', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                        ],
                      ),
                      const SizedBox(height: 32),
                      buildInfo(),
                    ],
                  ),
                ),
              )
            )
          ]),
        ),
      ),
    );
  }
}
