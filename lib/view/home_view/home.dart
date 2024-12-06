import 'package:flutter/material.dart';
import 'package:app_smart_home/config/size_config.dart';
import 'package:app_smart_home/view/home_view/body.dart';
import 'package:app_smart_home/view/menu_view/menu.dart';
import 'package:app_smart_home/view_models/home_viewmodel.dart';
import 'package:app_smart_home/provider/base_view.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/home-page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BaseView<HomePageViewModel>(
      onModelReady: (model) {
        model.startAutoRefresh(); // Bắt đầu tự động làm mới khi HomePage được mở
      },
      onModelDisposed: (model) {
        model.stopAutoRefresh(); // Dừng tự động làm mới khi HomePage bị đóng
      },
      builder: (context, model, child) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: getProportionateScreenHeight(60),
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi, Tam',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(
                  getProportionateScreenHeight(20),
                ),
                child: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.white.withOpacity(0.3),
                  indicatorColor: const Color(0xFF464646),
                  tabs: [
                    Tab(
                      child: Text(
                        'Meeting Room',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Office',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Garage',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            drawer: SizedBox(
              width: getProportionateScreenWidth(270),
              child: const MenuPage(),
            ),
            body: TabBarView(
              children: <Widget>[
                Body(model: model),
                Center(
                  child: Text(
                    'To be Built Soon',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                const Center(
                  child: Text('under construction'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
