import 'package:app_smart_home/config/size_config.dart';
import 'package:app_smart_home/provider/base_view.dart';
import 'package:app_smart_home/view/home_view/body.dart';
import 'package:app_smart_home/view/menu_view/menu.dart';
import 'package:app_smart_home/view_models/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/home-page';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BaseView<HomePageViewModel>(
        onModelReady: (model) => {},
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
                    horizontal: getProportionateScreenWidth(
                      4,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi, Tam',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(60),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xffdadada),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(45, 45)),
                        ),
                        child: IconButton(
                          splashRadius: 25,
                          icon: const Icon(
                            FontAwesomeIcons.solidUser,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            // Navigator.of(context).pushNamed(EditProfile.routeName);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ));
                          },
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(5),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xffdadada),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(45, 45)),
                        ),
                        child: IconButton(
                          splashRadius: 25,
                          icon: const Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.grey,
                            size: 30,
                          ),
                          onPressed: () {
                            // Navigator.of(context).pushNamed(EditProfile.routeName);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => Favourites(
                            //         model: model,
                            //       ),
                            //     ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(
                    getProportionateScreenHeight(
                      35,
                    ),
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
                      ]),
                ),
              ),
              drawer: SizedBox(
                  width: getProportionateScreenWidth(270),
                  child: const MenuPage()),
              body: TabBarView(
                children: <Widget>[
                  Body(
                    model: model,
                  ),
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
              // bottomNavigationBar: BottomNavBar(model: model),
            ),
          );
        });
  }
}
// class HomePage extends StatelessWidget {
//   static String routeName = '/home-screen';
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: appBar(),
//         body: Column(
//       children: [
//         Container(
//           margin: const EdgeInsets.all(10),
//           padding: const EdgeInsets.all(8.0),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey, width: 2),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(5), // Làm tròn góc cho hình ảnh
//             child: Image.asset(
//               'assets/images/image1.png', // Đường dẫn tới hình ảnh trong assets
//               width: 444, // Kích thước chiều rộng
//               height: 250, // Kích thước chiều cao
//               fit: BoxFit.cover, // Làm cho hình ảnh vừa với Container
//             ),
//           ),
//         ),
//         Container(
//             margin: EdgeInsets.all(20),
//             padding: const EdgeInsets.all(10), // Padding xung quanh GridView
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: GridView.builder(
//                 shrinkWrap:
//                     true, // Cho phép GridView thu nhỏ lại để vừa trong Container
//                 physics:
//                     const NeverScrollableScrollPhysics(), // Ngăn không cho GridView cuộn
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2, // Số cột
//                   childAspectRatio: 1.0, // Tỷ lệ chiều rộng/chiều cao của mỗi ô
//                   crossAxisSpacing: 8.0, // Khoảng cách giữa các cột
//                   mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
//                 ),
//                 itemCount: 4, // Tổng số ô bạn muốn hiển thị
//                 itemBuilder: (context, index) {
//                   return Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: index % 2 == 0
//                             ? [
//                                 Color(0xff33394D),
//                                 Color(0xff484B65)
//                               ] // Gradient cho thiết bị bật
//                             : [
//                                 Color(0xffE4E3E3),
//                                 Color(0xffC7C6C5)
//                               ], // Gradient cho thiết bị tắt
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.device_hub, // Biểu tượng thiết bị
//                           size: 50,
//                           color: Colors.white,
//                         ),
//                         Text(
//                           'Device ${index + 1}', // Tên thiết bị
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Switch(
//                           value:
//                               index % 2 == 0, // Trạng thái bật/tắt của Switch
//                           onChanged: (bool value) {
//                             // Hành động khi trạng thái Switch thay đổi
//                             // Bạn có thể thêm logic để cập nhật trạng thái thiết bị
//                           },
//                           activeColor: Color(0xffFF8A00),
//                           inactiveThumbColor: Colors.grey,
//                         ),
//                       ],
//                     ),
//                   );
//                 }))
//       ],
//     ));
//   }

  // AppBar appBar() {
  //   return AppBar(
  //     title: const Text(
  //       'My Home',
  //       style: TextStyle(
  //           color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
  //     ),
  //     backgroundColor: Colors.white,
  //     centerTitle: true,
  // leading: GestureDetector(
  //   onTap: () {},
  //   child: Container(
  //     margin: const EdgeInsets.all(10),
  //     alignment: Alignment.center,
  //     width: 37,
  //     decoration: BoxDecoration(
  //         color: const Color(0xffDBE0E7),
  //         borderRadius: BorderRadius.circular(10)),
  //     child: SvgPicture.asset(
  //       'lib/assets/icons/chevron.left.svg',
  //       height: 20,
  //       width: 20,
  //     ),
  //   ),
  // ),
  // actions: [
  //   GestureDetector(
  //     onTap: () {},
  //     child: Container(
  //       margin: const EdgeInsets.all(10),
  //       alignment: Alignment.center,
  //       width: 37,
  //       decoration: BoxDecoration(
  //           color: const Color(0xffDBE0E7),
  //           borderRadius: BorderRadius.circular(10)),
  //       child: SvgPicture.asset(
  //         'lib/assets/icons/chevron.left.svg',
  //         height: 20,
  //         width: 20,
  //       ),
  //     ),
  //   ),
  // ],
  //   );
  // }
// }
