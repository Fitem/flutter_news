import 'package:flutter/material.dart';
import 'package:flutter_news/common/base/base_widget.dart';
import 'package:flutter_news/common/widget/line_view.dart';
import 'package:flutter_news/common/widget/pull_refresh_list_view.dart';

///  Name:
///  Created by leiguangwu on 2022/2/13
class SecondScreen extends StatefulWidget {

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<SecondScreen> {
  final globalKey = GlobalKey<ListViewState>();
  var data = <String>[];
  int counter = 20;
  ///是否有下一页
  final bool _hasMore = false;

  void onDelete(context, index) {
    globalKey.currentState?.removeItem(index, data);
  }

  // 构建列表项
  Widget buildItem(context, index) {
    String char = data[index];
    return ListTile(
      //数字不会重复，所以作为Key
      key: ValueKey(char),
      title: Text(char),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        // 点击时删除
        onPressed: () => onDelete(context, index),
      ),
    );
  }

  ///列表刷新
  Future<void> _onRefresh() async {
    if(mounted) {
      setState(() {
        data = [];
        for (var i = 0; i < counter; i++) {
          data.add('${i + 1}');
        }
        globalKey.currentState?.update(data);
      });
    }
  }

  ///请求加载更多
  Future<void> _loadMore() async {
    setState(() {
      for (var i = 0; i < counter; i++) {
        data.add('${i + 1}');
      }
      globalKey.currentState?.update(data);
    });
  }


  Widget buildBody() {
    return PullToRefreshListView.separated(
      key: globalKey,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return buildItem(context, index);
      },
      onRefresh: _onRefresh,
      onMoreRefresh: _loadMore,
      hasMore: _hasMore,
      separatorView: LineView(height: 0),
    );
  }

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

}
