

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


///用于表示下拉刷新以及上拉加载更多
class RefreshLoadMoreExample1 extends StatefulWidget {
  @override
  _RefreshLoadMoreExample1State createState() => _RefreshLoadMoreExample1State();
}

class _RefreshLoadMoreExample1State extends State<RefreshLoadMoreExample1> {
  final List<int> _items = List.generate(20, (index) => index);
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent && !_isLoadingMore) {
        _loadMoreItems();
      }
    });
  }


  ///用于下拉刷新加载item
  Future<void> _refreshItems() async {
    // _scrollController.animateTo(
    //     -300,
    //   duration: Duration(milliseconds: 300),
    //   curve: Curves.easeOut,
    // );
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _items.insertAll(0, List.generate(10, (index) => _items.length + index));
    });

    // 等待刷新指示器消失后，将 CustomScrollView 滑动到顶部
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  ///用于上拉加载更多
  Future<void> _loadMoreItems() async {
    setState(() {
      _isLoadingMore = true;
    });

    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _items.addAll(List.generate(10, (index) => _items.length + index));
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pull to Refresh & Load More'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshItems,
        color: Colors.red,
        backgroundColor: Colors.blue,
        // displacement: 100,
        // edgeOffset: 100,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 100.0,
              ),
            ),


            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  if (index == _items.length) {
                    return _isLoadingMore
                        ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                        : SizedBox.shrink();
                  }
                  return ListTile(
                    title: Text('Item ${_items[index]}'),
                  );
                },
                childCount: _items.length + 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}