import 'package:flutkit/animation/shopping_manager/controllers/orders_controller.dart';
import 'package:flutkit/animation/shopping_manager/model/order.dart';
import 'package:flutkit/helpers/extensions/double_extension.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/theme/constant.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_progress_bar.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late ThemeData theme;
  late OrdersController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingManagerTheme;
    controller = OrdersController();
    outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
        init: controller,
        tag: 'orders_controller',
        // theme: theme,
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: MySpacing.fromLTRB(
                    20, MySpacing.safeAreaTop(context) + 16, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleRow(),
                    MySpacing.height(16),
                    status(),
                    MySpacing.height(16),
                    ordersView()
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget titleRow() {
    return Row(
      children: [
        MyContainer(
          width: 10,
          height: 24,
          color: theme.colorScheme.primaryContainer,
          borderRadiusAll: 2,
        ),
        MySpacing.width(8),
        MyText.titleMedium(
          "Orders",
          fontWeight: 600,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyContainer(
                color: controller.viewType == OrderViewType.active
                    ? theme.colorScheme.primaryContainer
                    : Colors.transparent,
                paddingAll: 8,
                onTap: () {
                  controller.changeOrderView(OrderViewType.active);
                },
                child: MyText.bodySmall(
                  "ACTIVE",
                  fontSize: 11,
                  fontWeight: 700,
                  color: controller.viewType == OrderViewType.active
                      ? theme.colorScheme.onPrimaryContainer
                      : theme.colorScheme.onBackground,
                ),
              ),
              // MySpacing.width(8),
              MyContainer(
                color: controller.viewType == OrderViewType.past
                    ? theme.colorScheme.primaryContainer
                    : Colors.transparent,
                paddingAll: 8,
                onTap: () {
                  controller.changeOrderView(OrderViewType.past);
                },
                child: MyText.bodySmall(
                  "PAST",
                  fontSize: 11,
                  fontWeight: 700,
                  color: controller.viewType == OrderViewType.past
                      ? theme.colorScheme.onPrimaryContainer
                      : theme.colorScheme.onBackground,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget status() {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: MyContainer.bordered(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.titleMedium(
                    'Completed',
                    fontWeight: 700,
                  ),
                  MySpacing.height(8),
                  MyText.titleSmall(
                    '128',
                    fontWeight: 700,
                  ),
                  MySpacing.height(12),
                  MyText.bodySmall(
                    'Progress',
                    fontWeight: 600,
                    muted: true,
                  ),
                  MySpacing.height(6),
                  MyProgressBar(
                    width: 140,
                    inactiveColor: Constant.softColors.green.color,
                    activeColor: Constant.softColors.green.onColor,
                    height: 4,
                    progress: 0.4,
                  ),
                ],
              ),
            ),
          ),
          MySpacing.width(16),
          Expanded(
            child: MyContainer.bordered(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.titleMedium(
                    'Past',
                    fontWeight: 700,
                  ),
                  MySpacing.height(8),
                  MyText.titleSmall(
                    '245',
                    fontWeight: 700,
                  ),
                  MySpacing.height(12),
                  MyText.bodySmall(
                    'Progress',
                    fontWeight: 600,
                    muted: true,
                  ),
                  MySpacing.height(6),
                  MyProgressBar(
                    width: 140,
                    inactiveColor: theme.colorScheme.secondaryContainer,
                    activeColor: theme.colorScheme.onSecondaryContainer,
                    height: 4,
                    progress: 0.7,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ordersView() {
    return Column(
      children: [...controller.orders.map((order) => orderView(order))],
    );
  }

  Widget orderView(Order order) {
    return MyContainer(
      onTap: () {
        controller.goToOrder(order);
      },
      margin: MySpacing.bottom(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.bodySmall(
                "Order - ${order.id}",
                fontWeight: 700,
              ),
              MyText.bodySmall(
                "${DateFormat("d MMM").format(order.date)}, ${DateFormat("jm").format(order.date)}",
                fontWeight: 600,
                muted: true,
              ),
            ],
          ),
          MySpacing.height(12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyContainer.none(
                borderRadiusAll: Constant.containerRadius.small,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image(
                  image: AssetImage(order.image),
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              MySpacing.width(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodySmall(
                      order.name,
                      fontWeight: 600,
                    ),
                    MySpacing.height(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText.bodySmall(
                          '\$${order.price.precise}',
                          fontWeight: 700,
                        ),
                        MyContainer(
                          borderRadiusAll: Constant.containerRadius.xs,
                          padding: MySpacing.fromLTRB(8, 3, 8, 5),
                          color:
                              controller.getColorFromStatus(order.status).color,
                          child: MyText.bodySmall(
                            controller.getTextFromStatus(order.status),
                            fontSize: 10,
                            color: controller
                                .getColorFromStatus(order.status)
                                .onColor,
                            fontWeight: 600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
