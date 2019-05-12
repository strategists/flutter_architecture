import 'package:flutter/material.dart';
import 'arch/arch.dart';
import 'package:flutter_architecture/page/page.dart';
import 'style/style.dart';

class Shelf extends PageProviderNode {
  @override
  Widget buildPage(BuildContext context) {
    return _ShelfPage();
  }
}

class _ShelfPage extends StatefulWidget {
  @override
  _ShelfPageState createState() {
    return _ShelfPageState();
  }
}

class _ShelfPageState extends State<_ShelfPage> {
  PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    var barItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          activeIcon: Icon(Icons.home),
          icon: Icon(Icons.my_location),
          title: Text("首页")),
      BottomNavigationBarItem(
          activeIcon: Icon(Icons.adjust),
          icon: Icon(Icons.account_circle),
          title: Text("账户")),
    ];
    return BottomNavigationBar(
      onTap: (i) => _pageController.jumpToPage(i),
      currentIndex: _currentIndex,
      items: barItems,
    );
  }

  Widget _buildBody() {
    return WillPopScope(
      child: PageView(
        children: <Widget>[HomePage(), MinePage()],
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        physics: NeverScrollableScrollPhysics(),
      ),
      onWillPop: () {
        //todo
        return Future.value(true);
      },
    );
  }
}

class PageViewManager {}
