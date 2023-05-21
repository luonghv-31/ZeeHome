import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeehome/model/following.dart';
import 'package:zeehome/network/user/get_all_following_request.dart';
import 'package:zeehome/screens/following/components/userItem.dart';

class FollowingList extends StatefulWidget {

  const FollowingList({Key? key}) : super(key: key);

  @override
  State<FollowingList> createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList> {
  static const _pageSize = 5;

  final PagingController<int, Users> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }


  Future<void> _fetchPage(int pageKey) async {
    try {
      SharedPreferences.getInstance().then((prefs) async {
        String access_token = prefs.get('access_token') as String;
        final newItems = await FollowingListRequest.fetchFollowingList(access_token, _pageSize, (pageKey ~/ _pageSize));

        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + newItems.length;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      });
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void refreshCallBack () {
    _pagingController.refresh();
  }

  Widget noItemFoundIndicator() {
    return(
        Align(
          alignment: Alignment.center,
          child: Column(
            children: const [
              SizedBox(height: 32,),
              Text('Không tìm thấy', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black),),
              SizedBox(height: 18,),
              Text('Danh sách tạm thời rỗng', style: TextStyle(fontSize: 14),),
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
    onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
    ),
    child: PagedListView<int, Users>.separated(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Users>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          return UserItem(users: item, refreshCallBack: refreshCallBack,);
        },
        noItemsFoundIndicatorBuilder: (_) => noItemFoundIndicator(),
        // noMoreItemsIndicatorBuilder: (_) => NoMoreItemsIndicator(),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 0,),
    ),
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
