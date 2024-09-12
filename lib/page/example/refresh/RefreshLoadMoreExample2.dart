import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RefreshLoadMoreExample2 extends StatefulWidget {
  @override
  _RefreshLoadMoreExample2State createState() => _RefreshLoadMoreExample2State();
}

class _RefreshLoadMoreExample2State extends State<RefreshLoadMoreExample2> {
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
      _items.insert(0, _items.length);  // 插入新数据到列表顶部
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
        title: Text('Pull to Refresh & Load More'),
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