import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_news/common/widget/line_view.dart';

typedef PullRefreshCallback = Future<void> Function();

///@describe 自定义ListView（下拉刷新，上拉加载更多）
///
///@author mi
///
///@time 2019/10/28
// ignore: must_be_immutable
class PullToRefreshListView extends StatefulWidget {
  //item回调方法
  IndexedWidgetBuilder itemBuilder;

  //条目数
  int itemCount;

  double lineViewHeight = 0;

  //分割线
  Widget separatorView = LineView(height: 1);

  //刷新回调
  PullRefreshCallback onRefresh;

  //加载更多回调
  PullRefreshCallback onMoreRefresh;

  //是否有下一页
  bool hasMore = true;

  //是否显示加载更多提示
  bool showMore = false;

  //是否正在加载中
  bool isLoading = false;

  PullToRefreshListView({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    required this.onRefresh,
    required this.onMoreRefresh,
    this.hasMore = false,
    this.isLoading = false,
  }) : super(key: key);

  PullToRefreshListView.separated({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    required this.separatorView,
    required this.onRefresh,
    required this.onMoreRefresh,
    this.hasMore = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListViewState();
  }
}

//1、AutomaticKeepAliveClientMixin 保持各Tab状态，避免initState调用。
//2、并实现对应的方法bool get wantKeepAlive => true
class ListViewState extends State<PullToRefreshListView>
    with AutomaticKeepAliveClientMixin {
  late ScrollController _controller;

  final globalKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();

    //PrintUtil.println('PullToRefreshListView.initState--->');

    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (!widget.isLoading) {
          if (widget.hasMore) {
            setState(() {
              widget.isLoading = true;
              widget.showMore = true;
            });
            widget.onMoreRefresh();
          } else {
            setState(() {
              widget.showMore = true;
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    //手动停止滑动监听
    //PrintUtil.println('PullToRefreshListView.dispose');
    _controller.dispose();
  }

  Widget buildLoadingWidget() {
    return Center(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('Loading...',
                style: TextStyle(color: Colors.blue, fontSize: 16)),
          ]),
    );
  }

  Widget buildNODataWidget() {
    return Center(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      const Text('No data'),
      GestureDetector(
          onTap: _onTap,
          child: const Text(
            ' Click refresh',
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ))
    ]));
  }

  void _onTap() {
    widget.onRefresh();
  }

  void update(List<String> data){
    int size = widget.itemCount - data.length;
      if(size > 0){
        for(int i = size - 1 ; i >= 0 ; i++){
          globalKey.currentState!.removeItem(i, (context, animation) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                //让透明度变化的更快一些
                curve: const Interval(0.5, 1.0),
              ),
              // 不断缩小列表项的高度
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0.0,
                child: _buildItem(i, context),
              ),
            );
          },
          duration: const Duration(seconds: 0));
        }
      } else if(size < 0) {
        for(int i = 0 ; i < -size ; i++) {
          globalKey.currentState!.insertItem(i, duration: const Duration(seconds: 0));
        }
      }
  }

  void removeItem(int index, List<String> data) {
    globalKey.currentState!.removeItem(
      index,
      (context, animation) {
        // 删除过程执行的是反向动画，animation.value 会从1变为0
        var item = _buildItem(index, context);
        data.removeAt(index);
        widget.itemCount = data.length;
        // 删除动画是一个合成动画：渐隐 + 缩小列表项告诉
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            //让透明度变化的更快一些
            curve: const Interval(0.5, 1.0),
          ),
          // 不断缩小列表项的高度
          child: SizeTransition(
            sizeFactor: animation,
            axisAlignment: 0.0,
            child: item,
          ),
        );
      },
      duration: const Duration(milliseconds: 300), // 动画时间为 200 ms
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    log("itemCount:${widget.itemCount}");
    if (widget.itemCount <= 0) {
      return buildNODataWidget();
    }

    return RefreshIndicator(
      onRefresh: () {
        setState(() {
          widget.isLoading = false;
          widget.showMore = false;
        });
        return widget.onRefresh();
      },
      child: AnimatedList(
        key: globalKey,
        controller: _controller,
        itemBuilder: (
          BuildContext context,
          int index,
          Animation<double> animation,
        ) {
          return _buildItem(index, context);
        },
        initialItemCount: widget.itemCount + 1,

        ///解决item太少导致无法下拉刷新问题
        physics: const AlwaysScrollableScrollPhysics(),
      ),
    );
  }

  Widget _buildItem(int index, BuildContext context) {
    if (index == widget.itemCount) {
      if (widget.showMore) {
        return widget.hasMore ? const LoadMoreView() : const NoMoreView();
      } else {
        return Container();
      }
    } else {
      return widget.itemBuilder(context, index);
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class LoadMoreView extends StatelessWidget {
  const LoadMoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
          SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2)),
          Padding(
              padding: EdgeInsets.all(10),
              child: Text('loading',
                  style: TextStyle(color: Colors.grey, fontSize: 13)))
        ]));
  }
}

class NoMoreView extends StatelessWidget {
  const NoMoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(
            padding: EdgeInsets.all(2),
            child: Text('The end',
                style: TextStyle(color: Colors.grey, fontSize: 13))));
  }
}
