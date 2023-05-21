import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:zeehome/model/houses/house.dart';
import 'package:zeehome/network/house/my_house_list_request.dart';
import 'package:zeehome/screens/houseList/components/houseItem.dart';

class HouseList extends StatefulWidget {

  final String ownerId;
  const HouseList({Key? key, required this.ownerId}) : super(key: key);

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  static const _pageSize = 5;

  final PagingController<int, House> _pagingController =
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
      final newItems = await MyHouseListRequest.fetchMyHouseList(widget.ownerId, true, _pageSize, (pageKey ~/ _pageSize));

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        // final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
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
    child: PagedListView<int, House>.separated(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<House>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          return HouseItem(itemInfo: item, refreshCallBack: refreshCallBack,);
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
