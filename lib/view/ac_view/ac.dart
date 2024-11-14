import 'package:app_smart_home/provider/base_view.dart';
import 'package:app_smart_home/view/ac_view/body.dart';
import 'package:flutter/material.dart';
import 'package:app_smart_home/view_models/ac_viewmodel.dart';

class ACPage extends StatelessWidget {
  static String routeName = '/ac-page';

  const ACPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ACViewModel>(
      onModelReady: (model) {
        // Tải lại trạng thái lưu trữ từ SharedPreferences khi khởi tạo
        model.loadState();
      },
      builder: (context, model, child) {
        return Material(
          child: Scaffold(
            backgroundColor: const Color(0xFFF2F2F2),
            body: Body(
              model: model,
            ),
          ),
        );
      },
    );
  }
}
