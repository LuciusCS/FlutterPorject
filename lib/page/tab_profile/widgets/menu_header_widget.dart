import 'package:flutter/material.dart';

// import '../../../../common/app_dimens.dart';
import '../../../common/base/app_dimens.dart';
// import '../../../widgets/app_devider.dart';


class MenuHeaderWidget extends StatelessWidget {
  final String title;

  MenuHeaderWidget({this.title = "", Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(left: AppDimens.marginNormal, top: AppDimens.marginLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: theme.textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: AppDimens.marginSmall),
          // AppDivider(),
        ],
      ),
    );
  }
}
