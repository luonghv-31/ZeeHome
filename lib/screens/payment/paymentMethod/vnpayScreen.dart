
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/authProvider.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/network/payment/vnpay_request.dart';
import 'package:url_launcher/url_launcher.dart';

class VnpayScreen extends StatefulWidget {
  const VnpayScreen({super.key});

  @override
  _VnpayScreenState createState() => _VnpayScreenState();
}

class _VnpayScreenState extends State<VnpayScreen> {

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


  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
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
                          GetVnpayRequest.fetchVnPay(authProvider.accessToken, int.parse(amountController.text) * 100, 'string').then((value) => {
                            _launchUrl(value),
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
                            const Text('Nạp tiền phương thức Vnpay', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
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
