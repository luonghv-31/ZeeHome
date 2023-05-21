import 'package:flutter/material.dart';
import 'package:zeehome/components/starRating.dart';
import 'package:zeehome/model/user.dart';
import 'package:zeehome/screens/following/followScreen.dart';
import 'package:zeehome/screens/user/editUserDetailScreen.dart';
import 'package:zeehome/utils/constants.dart';
import 'package:intl/intl.dart';

class UserDetail extends StatelessWidget {
  final User user;
  final Size size;
  final f = DateFormat('dd-MM-yyyy');
  final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
  UserDetail({Key? key, required this.user, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background_app.png'),
            fit: BoxFit.fill,
          ),
        ),
      child: Column(
        children: [
          Container(
            height: size.height * 0.25,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    bottom: 36 + kDefaultPadding,
                  ),
                  height: size.height * 0.25 - 27,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Color.fromARGB(255, 255, 255, 255),
                        BlendMode.dstATop,
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                ),
                Positioned(
                  top: 32,
                  left: 12,
                  child: CircleAvatar(
                    backgroundColor: secondaryColor10LightTheme,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: secondaryColor40LightTheme,
                        size: 24.0,
                        semanticLabel: 'Text to announce in accessibility modes',
                      ),
                    )
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    height: 54,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 10),
                          blurRadius: 50,
                          color: kPrimaryColor.withOpacity(0.23),
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Row(
                              children: [
                                const Text('Số dư: '),
                                Text((user.balance / 100).toString()),
                              ],
                            )
                        ),
                        Image.asset('assets/icon/money-bag.png'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, left: 10, right: 10),
            padding: const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: DefaultTextStyle(
              style: const TextStyle(color: Color.fromARGB(255, 100, 100, 100), fontSize: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Thông tin cá nhân', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),),
                  const SizedBox(height: 12),
                  Align(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.brown.shade800,
                      backgroundImage: NetworkImage(user.image),
                    ),
                  ),
                  const SizedBox(height: 24,),
                  Row(
                    children: [
                      const Text('Họ và tên: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      Text('${user.firstName} ${user.lastName}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Mô tả: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      Text(user.intro.toString()),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Ngày sinh: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      Text(user.birthDate),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Giới tính: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      Text(user.gender.toString() == 'male' ? 'Nam' : 'Nữ'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Ngày đăng ký: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      Text(f.format(inputFormat.parse(user.registerAt.toString()))),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(scaleInTransition(EditUserDetailScreen()));
                        },
                        icon: const Icon(
                          Icons.near_me,
                          color: secondaryColor40LightTheme,
                          size: 24.0,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                        label: const Text("Chỉnh sửa"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor10LightTheme,
                          foregroundColor: textColorLightTheme,
                          minimumSize: const Size(100, 40),
                          maximumSize: const Size(160, 40),
                          elevation: 0,
                          fixedSize: const Size(double.infinity, 40),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12,),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(scaleInTransition(const FollowingListScreen()));
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: secondaryColor40LightTheme,
                          size: 24.0,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                        label: const Text("Theo dõi"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor10LightTheme,
                          foregroundColor: textColorLightTheme,
                          minimumSize: const Size(100, 40),
                          maximumSize: const Size(160, 40),
                          elevation: 0,
                          fixedSize: const Size(double.infinity, 40),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, left: 10, right: 10),
            padding: const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: DefaultTextStyle(
              style: const TextStyle(color: Color.fromARGB(255, 100, 100, 100), fontSize: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Đánh giá', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),),
                  const SizedBox(height: 12),
                  StarRating(starCount: 5, rating: 1.4, onRatingChanged: (d) {}, color: Colors.red),
                ],
              ),
            ),
          ),

        ],
      )
    );
  }
}
