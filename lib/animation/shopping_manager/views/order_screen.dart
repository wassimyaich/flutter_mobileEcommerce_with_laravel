import 'package:flutkit/animation/shopping_manager/controllers/order_controller.dart';
import 'package:flutkit/animation/shopping_manager/model/order.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/theme/constant.dart';
import 'package:flutkit/helpers/widgets/my_button.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutkit/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OrderScreen extends StatefulWidget {
  final Order order;

  const OrderScreen(this.order, {Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late ThemeData theme;
  late OrderController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingManagerTheme;
    controller = OrderController(widget.order);
    outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: theme.dividerColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
        init: controller,
        tag: 'order_controller',
        // theme: theme,
        builder: (controller) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    polylines: controller.polylines,
                    markers: controller.markers,
                    onMapCreated: controller.onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: controller.center,
                      zoom: 16,
                      bearing: 116,
                    ),
                    buildingsEnabled: false,
                    compassEnabled: false,
                  ),
                ),
                Container(
                  padding: MySpacing.all(20),
                  child: Column(
                    children: [status()],
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget status() {
    return MyContainer(
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () {
                    controller.goBack();
                  },
                  child: Icon(
                    LucideIcons.chevronLeft,
                    size: 20,
                  )),
              MySpacing.width(8),
              ClipRRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadius: BorderRadius.circular(28),
                  child: Image(
                    image: AssetImage(Images.profiles[1]),
                    height: 32,
                    width: 32,
                  )),
              MySpacing.width(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium(
                      "John nikol",
                      fontWeight: 600,
                    ),
                    MySpacing.height(2),
                    MyText.bodySmall(
                      "On the way",
                      fontWeight: 600,
                      muted: true,
                      fontSize: 11,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Constant.softColors.star,
                    size: 20,
                  ),
                  MySpacing.width(4),
                  MyText.bodyMedium(
                    "4.6",
                    fontWeight: 600,
                  ),
                  MySpacing.width(2),
                  MyText.bodySmall(
                    "(30)",
                    muted: true,
                    fontWeight: 600,
                  ),
                ],
              )
            ],
          ),
          Divider(
            height: 36,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodySmall(
                    'Estimate Time',
                    xMuted: true,
                    fontWeight: 600,
                  ),
                  MySpacing.height(8),
                  Row(
                    children: [
                      MyText.titleLarge(
                        '30-35',
                        fontWeight: 600,
                      ),
                      MySpacing.width(4),
                      MyText.bodySmall(
                        'minute',
                        fontWeight: 600,
                        muted: true,
                        letterSpacing: 0,
                      ),
                    ],
                  ),
                ],
              ),
              MyContainer.bordered(
                padding: MySpacing.xy(12, 8),
                child: Column(
                  children: [
                    MyText.bodySmall(
                      'Today',
                      fontWeight: 600,
                    ),
                    MySpacing.height(4),
                    MyText.bodyMedium(
                      '10:48',
                      fontWeight: 700,
                    ),
                  ],
                ),
              )
            ],
          ),
          MySpacing.height(8),
          Row(
            children: [
              Row(
                children: [
                  MyContainer.bordered(
                    paddingAll: 4,
                    child: Icon(
                      LucideIcons.chevronDown,
                      size: 10,
                    ),
                  ),
                  MySpacing.width(4),
                  MyText.bodySmall(
                    'Details',
                    fontWeight: 600,
                    xMuted: true,
                  )
                ],
              ),
              MySpacing.width(16),
              Expanded(
                  child: MyButton(
                onPressed: () {},
                elevation: 0,
                borderRadiusAll: Constant.buttonRadius.small,
                backgroundColor: theme.colorScheme.primary,
                padding: MySpacing.y(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LucideIcons.phoneCall,
                      color: theme.colorScheme.onPrimary,
                      size: 16,
                    ),
                    MySpacing.width(8),
                    MyText.bodyMedium(
                      "Connect",
                      color: theme.colorScheme.onPrimary,
                    )
                  ],
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
