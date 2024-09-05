import 'package:flutkit/animation/shopping_manager/controllers/profile_controller.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/theme/constant.dart';
import 'package:flutkit/helpers/widgets/my_button.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ThemeData theme;
  late ProfileController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingManagerTheme;
    controller = ProfileController();
    outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: controller,
        tag: 'profile_controller',
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
                    MySpacing.height(20),
                    statistics(),
                    MySpacing.height(24),
                    status(),
                    MySpacing.height(24),
                    other(),
                    MySpacing.height(32),
                    account()
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
          "My Shop",
          fontWeight: 600,
        ),
      ],
    );
  }

  Widget statistics() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: MyContainer(
              paddingAll: 12,
              child: Row(
                children: [
                  MyContainer(
                      paddingAll: 10,
                      color: Constant.softColors.green.color,
                      child: Icon(
                        Icons.inventory_2_outlined,
                        size: 18,
                        color: Constant.softColors.green.onColor,
                      )),
                  MySpacing.width(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodySmall(
                        'Products',
                        fontWeight: 600,
                      ),
                      MySpacing.height(4),
                      MyText.bodyMedium(
                        '114',
                        fontWeight: 600,
                      ),
                    ],
                  )
                ],
              ),
            )),
            MySpacing.width(16),
            Expanded(
                child: MyContainer(
              paddingAll: 10,
              child: Row(
                children: [
                  MyContainer(
                      paddingAll: 10,
                      color: Constant.softColors.blue.color,
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: 18,
                        color: Constant.softColors.blue.onColor,
                      )),
                  MySpacing.width(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodySmall(
                        'Orders',
                        fontWeight: 600,
                      ),
                      MySpacing.height(4),
                      MyText.bodyMedium(
                        '284',
                        fontWeight: 600,
                      ),
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
        MySpacing.height(16),
        Row(
          children: [
            Expanded(
                child: MyContainer(
              paddingAll: 12,
              child: Row(
                children: [
                  MyContainer(
                      paddingAll: 10,
                      color: Constant.softColors.violet.color,
                      child: Icon(
                        LucideIcons.users,
                        size: 18,
                        color: Constant.softColors.violet.onColor,
                      )),
                  MySpacing.width(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodySmall(
                        'Users',
                        fontWeight: 600,
                      ),
                      MySpacing.height(4),
                      MyText.bodyMedium(
                        '489',
                        fontWeight: 600,
                      ),
                    ],
                  )
                ],
              ),
            )),
            MySpacing.width(16),
            Expanded(
                child: MyContainer(
              paddingAll: 10,
              child: Row(
                children: [
                  MyContainer(
                      paddingAll: 10,
                      color: Constant.softColors.pink.color,
                      child: Icon(
                        Icons.alt_route_outlined,
                        size: 18,
                        color: Constant.softColors.pink.onColor,
                      )),
                  MySpacing.width(12),
                  Row(
                    children: [
                      MyText.bodySmall(
                        'View All',
                        fontWeight: 600,
                      ),
                      MySpacing.width(4),
                      Icon(
                        LucideIcons.chevronRight,
                        size: 16,
                      )
                    ],
                  ),
                ],
              ),
            )),
          ],
        ),
      ],
    );
  }

  Widget status() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.bodySmall(
          'Shop Status',
          fontWeight: 600,
          muted: true,
        ),
        MySpacing.height(20),
        Row(
          children: [
            MyContainer(
              onTap: () {
                controller.changeShopStatus(ShopStatus.close);
              },
              color: controller.shopStatus == ShopStatus.close
                  ? theme.colorScheme.primaryContainer
                  : null,
              padding: MySpacing.fromLTRB(12, 8, 12, 8),
              child: Row(
                children: [
                  Icon(Icons.work_off_outlined,
                      size: 20,
                      color: controller.shopStatus == ShopStatus.close
                          ? theme.colorScheme.onPrimaryContainer
                          : null),
                  MySpacing.width(8),
                  MyText.bodySmall("Close",
                      color: controller.shopStatus == ShopStatus.close
                          ? theme.colorScheme.onPrimaryContainer
                          : null)
                ],
              ),
            ),
            MySpacing.width(16),
            MyContainer(
              onTap: () {
                controller.changeShopStatus(ShopStatus.open);
              },
              color: controller.shopStatus == ShopStatus.open
                  ? theme.colorScheme.primaryContainer
                  : null,
              padding: MySpacing.fromLTRB(12, 8, 12, 8),
              child: Row(
                children: [
                  Icon(Icons.work_outline,
                      size: 20,
                      color: controller.shopStatus == ShopStatus.open
                          ? theme.colorScheme.onPrimaryContainer
                          : null),
                  MySpacing.width(8),
                  MyText.bodySmall("Open",
                      color: controller.shopStatus == ShopStatus.open
                          ? theme.colorScheme.onPrimaryContainer
                          : null)
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget other() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.bodySmall(
          'Activity',
          fontWeight: 600,
          muted: true,
        ),
        MySpacing.height(20),
        Row(
          children: [
            MyContainer(
              paddingAll: 8,
              color: Constant.softColors.blue.color,
              child: Icon(
                Icons.account_balance_wallet_outlined,
                size: 20,
                color: Constant.softColors.blue.onColor,
              ),
            ),
            MySpacing.width(16),
            Expanded(child: MyText.bodyMedium('Payments')),
            MySpacing.width(16),
            Row(
              children: [
                MyContainer.rounded(
                  height: 24,
                  width: 24,
                  paddingAll: 0,
                  color: theme.colorScheme.primary,
                  child: Center(
                    child: MyText.bodySmall(
                      '4',
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
                MySpacing.width(4),
                Icon(
                  LucideIcons.chevronRight,
                  size: 18,
                  color: theme.colorScheme.primary,
                )
              ],
            )
          ],
        ),
        MySpacing.height(16),
        Row(
          children: [
            MyContainer(
              paddingAll: 8,
              color: Constant.softColors.green.color,
              child: Icon(
                Icons.location_on_outlined,
                size: 20,
                color: Constant.softColors.green.onColor,
              ),
            ),
            MySpacing.width(16),
            Expanded(child: MyText.bodyMedium('Shop Location')),
            MySpacing.width(16),
            Icon(
              LucideIcons.chevronRight,
              size: 20,
            )
          ],
        ),
        MySpacing.height(16),
        Row(
          children: [
            MyContainer(
              paddingAll: 8,
              color: Constant.softColors.orange.color,
              child: Icon(
                Icons.privacy_tip_outlined,
                size: 20,
                color: Constant.softColors.orange.onColor,
              ),
            ),
            MySpacing.width(16),
            Expanded(child: MyText.bodyMedium('Privacy')),
            MySpacing.width(16),
            Row(
              children: [
                MyText.bodySmall(
                  'Action Needed',
                  color: theme.colorScheme.error,
                  fontWeight: 600,
                ),
                MySpacing.width(4),
                Icon(
                  LucideIcons.chevronRight,
                  size: 18,
                  color: theme.colorScheme.error,
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget account() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.bodySmall(
          'My Account',
          fontWeight: 600,
          xMuted: true,
        ),
        MySpacing.height(8),
        MyButton.text(
            padding: MySpacing.zero,
            onPressed: () {},
            child: MyText.bodyMedium(
              'Switch to another account',
              color: theme.colorScheme.primary,
              fontWeight: 600,
            )),
        MySpacing.height(20),
        Center(
          child: MyButton(
              backgroundColor: theme.colorScheme.errorContainer,
              elevation: 0,
              padding: MySpacing.xy(20, 16),
              borderRadiusAll: Constant.buttonRadius.small,
              onPressed: () {
                controller.logout(context);
              },
              child: MyText(
                'Logout',
                color: theme.colorScheme.onErrorContainer,
                fontWeight: 600,
              )),
        )
      ],
    );
  }
}
