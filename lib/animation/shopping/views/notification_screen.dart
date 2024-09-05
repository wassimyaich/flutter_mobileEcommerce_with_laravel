import 'package:flutkit/animation/shopping/controllers/notification_controller.dart';
import 'package:flutkit/helpers/extensions/extensions.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutkit/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late ThemeData theme;

  late NotificationController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = NotificationController();
  }

  Widget _buildSingleCoupon(
      String icon, String coupon, String time, String couponCode) {
    return MyContainer(
      paddingAll: 16,
      margin: MySpacing.bottom(20),
      borderRadiusAll: 4,
      child: Row(
        children: [
          MyContainer(
            color: theme.colorScheme.primary,
            paddingAll: 10,
            borderRadiusAll: 4,
            child: Image(
              height: 24,
              width: 24,
              image: AssetImage(icon),
              color: theme.colorScheme.onPrimary,
            ),
          ),
          MySpacing.width(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(
                  coupon,
                  fontWeight: 700,
                ),
                MySpacing.height(8),
                MyText.bodySmall(
                  time,
                  muted: true,
                ),
                MySpacing.height(2),
              ],
            ),
          ),
          MySpacing.width(20),
          MyContainer(
            borderRadiusAll: 4,
            padding: MySpacing.xy(8, 4),
            color: theme.colorScheme.primary.withAlpha(40),
            child: MyText.bodySmall(
              couponCode,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        init: controller,
        tag: 'notification_controller',
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: false,
              actions: [
                InkWell(
                    onTap: () {
                      controller.goBack();
                    },
                    child: Container(
                        margin: MySpacing.x(16), child: Icon(Icons.clear_all))),
              ],
              title: MyText.bodyLarge(
                'Notification',
                fontWeight: 600,
              ),
            ),
            body: ListView(
              padding: MySpacing.nTop(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.bodyMedium(
                      'TODAY',
                      muted: true,
                      fontWeight: 600,
                    ),
                    MyText.bodyMedium(
                      'Mark as read',
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ),
                MySpacing.height(16),
                MyContainer(
                  paddingAll: 16,
                  borderRadiusAll: 4,
                  color: theme.colorScheme.primaryContainer,
                  child: Row(
                    children: [
                      MyContainer(
                        color: theme.colorScheme.primary,
                        paddingAll: 10,
                        borderRadiusAll: 4,
                        child: Image(
                          height: 24,
                          width: 24,
                          image: AssetImage(Images.discountBubble),
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                      MySpacing.width(16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.bodyMedium(
                            'Cashback 50%',
                            fontWeight: 700,
                            color: theme.colorScheme.primary,
                          ),
                          MySpacing.height(2),
                          MyText.bodySmall(
                            'Get 50% cashback for the next top up',
                            xMuted: true,
                            color: theme.colorScheme.primary,
                          ),
                          MySpacing.height(2),
                          Row(
                            children: [
                              MyText.bodySmall(
                                'Top up now',
                                color: theme.colorScheme.primary,
                              ),
                              MySpacing.width(4),
                              Icon(
                                LucideIcons.chevronRight,
                                color: theme.colorScheme.primary,
                                size: 16,
                              ).autoDirection(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                MySpacing.height(20),
                MyText.bodyMedium(
                  'YESTERDAY',
                  muted: true,
                  fontWeight: 600,
                ),
                MySpacing.height(20),
                _buildSingleCoupon(Images.discountCoupon, 'Daily Cashback',
                    '8:00 AM', '#DAILY'),
                _buildSingleCoupon(Images.discountCircle,
                    'Use BLCK10 Promo Code', '3:40 PM', '#BLCK10'),
                _buildSingleCoupon(Images.discountBubble, 'Cyber Monday Deal',
                    '10:39 AM', '#MON'),
                MyText.bodyMedium(
                  'LAST 7 DAYS',
                  muted: true,
                  fontWeight: 600,
                ),
                MySpacing.height(20),
                _buildSingleCoupon(Images.discountCoupon,
                    'Use NOV10 Promo Code', '3:40 PM', '#NOV10'),
                _buildSingleCoupon(Images.discountBubble,
                    '30% Black friday deal', '12:50 PM', '#FRI30'),
              ],
            ),
          );
        });
  }
}
