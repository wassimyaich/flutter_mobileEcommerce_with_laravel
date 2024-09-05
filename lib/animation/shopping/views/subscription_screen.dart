import 'package:flutkit/animation/shopping/controllers/subscription_controller.dart';
import 'package:flutkit/animation/shopping/models/subscription.dart';
import 'package:flutkit/helpers/extensions/extensions.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/widgets/my_button.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutkit/loading_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late ThemeData theme;

  late SubscriptionController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = SubscriptionController();
  }

  Widget _buildSingleBenefit(String benefit) {
    return Row(
      children: [
        MyContainer.rounded(
          paddingAll: 4,
          margin: MySpacing.y(6),
          color: theme.colorScheme.primary.withAlpha(28),
          child: Icon(
            LucideIcons.check,
            size: 12,
            color: theme.colorScheme.primary,
          ),
        ),
        MySpacing.width(12),
        MyText.bodySmall(
          benefit,
          xMuted: true,
        ),
      ],
    );
  }

  List<Widget> _buildSubscriptionList() {
    List<Widget> list = [];

    for (Subscription subscription in controller.subscriptions!) {
      bool selected = subscription == controller.subscription;
      list.add(
        MyContainer.bordered(
          onTap: () {
            controller.selectSubscription(subscription);
          },
          color: selected
              ? theme.colorScheme.primary.withAlpha(30)
              : theme.cardTheme.color,
          border: selected
              ? Border.all(color: theme.colorScheme.primary)
              : Border.all(color: theme.colorScheme.onBackground),
          borderRadiusAll: 4,
          padding: MySpacing.xy(32, 24),
          child: Column(
            children: [
              MyText.titleMedium(
                subscription.period,
                fontWeight: 700,
              ),
              MySpacing.height(4),
              MyText.bodySmall(
                subscription.trial,
                fontSize: 10,
                xMuted: true,
              ),
              MySpacing.height(20),
              MyText.bodyLarge(
                '\$${subscription.price}',
                fontWeight: 700,
                color: selected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onBackground,
              ),
              MySpacing.height(2),
              MyText.bodySmall(
                subscription.description,
                fontSize: 10,
                xMuted: true,
              ),
              MySpacing.height(20),
              Row(
                children: [
                  Icon(
                    LucideIcons.barChart2,
                    size: 18,
                    color: theme.colorScheme.onBackground.withAlpha(160),
                  ),
                  MySpacing.width(8),
                  Icon(LucideIcons.edit2,
                      size: 18,
                      color: theme.colorScheme.onBackground.withAlpha(160)),
                  MySpacing.width(8),
                  Icon(LucideIcons.calendar,
                      size: 18,
                      color: theme.colorScheme.onBackground.withAlpha(160)),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(
        init: controller,
        tag: 'subscription_controller',
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Scaffold(
        body: Padding(
          padding: MySpacing.top(MySpacing.safeAreaTop(context) + 20),
          child: LoadingEffect.getSearchLoadingScreen(context),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () {
              controller.goBack();
            },
            child: Icon(
              LucideIcons.chevronLeft,
              size: 20,
            ).autoDirection(),
          ),
          title: MyText.titleMedium(
            'Get Premium Features',
            color: theme.colorScheme.onBackground,
            fontWeight: 600,
          ),
        ),
        body: Padding(
          padding: MySpacing.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildSubscriptionList(),
              ),
              MySpacing.height(24),
              Container(
                padding: MySpacing.x(40),
                child: Column(
                  children: [
                    _buildSingleBenefit('Sale benefits before 24 hrs'),
                    _buildSingleBenefit('Discount upto 50%'),
                    _buildSingleBenefit('Access to premium items'),
                    _buildSingleBenefit('Explore trending items first'),
                  ],
                ),
              ),
              MySpacing.height(32),
              MyText.bodySmall(
                'Get ready to enjoy premium benefits with us. Get upgraded with your account and never miss any benefit updated on your favourite items.',
                textAlign: TextAlign.center,
                muted: true,
              ),
              MySpacing.height(40),
              MyButton.block(
                onPressed: () {
                  controller.goBack();
                },
                elevation: 0,
                borderRadiusAll: 4,
                padding: MySpacing.y(20),
                splashColor: theme.colorScheme.onPrimary.withAlpha(30),
                backgroundColor: theme.colorScheme.primary,
                child: MyText.labelLarge(
                  'Try free and subscribe',
                  fontWeight: 600,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
