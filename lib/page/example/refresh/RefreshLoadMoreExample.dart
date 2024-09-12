

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


///用于表示下拉刷新以及上拉加载更多
class RefreshLoadMoreExample extends StatefulWidget {




  @override
  _RefreshLoadMoreExampleState createState() => _RefreshLoadMoreExampleState();
}

class _RefreshLoadMoreExampleState extends State<RefreshLoadMoreExample> {
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

  Future<void> _refreshItems() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _items.clear();
      _items.addAll(List.generate(20, (index) => index));
    });
  }

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
        title: Text('下拉刷新，上拉加载更多'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshItems,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _items.length + 1,
          itemBuilder: (context, index) {
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