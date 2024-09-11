import 'package:flutkit/animation/shopping/controllers/cart_controller.dart';
import 'package:flutkit/animation/shopping/models/cart.dart';
import 'package:flutkit/helpers/extensions/extensions.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/widgets/my_button.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_dashed_divider.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutkit/loading_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  late ThemeData theme;

  late CartController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = CartController(this);
  }

  @override
  void dispose() {
    // Dispose of the controller to clean up resources
    controller.dispose();
    super.dispose();
  }

  Widget _buildCartList() {
    List<Widget> list = [];

    for (Cart cart in controller.carts) {
      bool increaseAble = controller.increaseAble(cart);
      bool decreaseAble = controller.decreaseAble(cart);
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: MyContainer(
          margin: MySpacing.bottom(20),
          borderRadiusAll: 4,
          paddingAll: 12,
          child: Row(
            children: [
              MyContainer(
                paddingAll: 0,
                borderRadiusAll: 4,
                height: 80,
                width: 80,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(cart.product.imageUrls),
                ),
              ),
              MySpacing.width(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      cart.product.name,
                      fontWeight: 700,
                    ),
                    MySpacing.height(8),
                    MyText.bodyMedium(
                      '\$${cart.product.price}',
                      fontWeight: 700,
                    ),
                    MySpacing.height(8),
                    Row(
                      children: [
                        MyText.bodySmall(
                          'Size : ${cart.selectedSize}',
                          fontWeight: 600,
                        ),
                        MySpacing.width(20),
                        MyText.bodySmall('Color : '),
                        MyContainer(
                            paddingAll: 8,
                            borderRadiusAll: 2,
                            color: cart.selectedColor,
                            child: Container()),
                        MySpacing.width(30),
                        IconButton(
                          icon: Icon(Icons.delete, size: 28, color: Colors.red),
                          onPressed: () {
                            controller.removeProductFromCart(cart.id);
                            // Implement logic to remove the cart item
                            // This might involve updating controller.carts
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.width(20),
              Column(
                children: [
                  MyContainer(
                    onTap: () {
                      controller.increment(cart);
                    },
                    bordered: increaseAble,
                    paddingAll: 4,
                    borderRadiusAll: 2,
                    border: Border.all(color: theme.colorScheme.primary),
                    color: increaseAble
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onBackground.withAlpha(200),
                    child: Icon(
                      LucideIcons.plus,
                      size: 12,
                      color: increaseAble
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onPrimary,
                    ),
                  ),
                  MySpacing.height(8),
                  MyText.bodyMedium(
                    cart.quantity
                        .toString(), //////////////////////////////////////////////////////////////////////////////////
                    fontWeight: 700,
                  ),
                  MySpacing.height(8),
                  MyContainer(
                    onTap: () {
                      controller.decrement(cart);
                    },
                    paddingAll: 4,
                    borderRadiusAll: 2,
                    bordered: decreaseAble,
                    border: Border.all(
                        color: theme.colorScheme.primary.withAlpha(120)),
                    color: decreaseAble
                        ? theme.colorScheme.primary.withAlpha(28)
                        : theme.colorScheme.onBackground.withAlpha(200),
                    child: Icon(
                      LucideIcons.minus,
                      size: 12,
                      color: decreaseAble
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
    }
    return Column(
      children: list,
    );
  }

  Widget _billingWidget() {
    return FadeTransition(
      opacity: controller.fadeAnimation,
      child: MyContainer(
        borderRadiusAll: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyMedium(
              'Billing Information',
              muted: true,
              fontWeight: 700,
            ),
            MySpacing.height(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.bodyMedium(
                  'Order Total',
                  fontWeight: 600,
                ),
                MyText.bodyMedium(
                  '\$${controller.order.precise}',
                  fontWeight: 700,
                ),
              ],
            ),
            MySpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.bodyMedium(
                  'Tax',
                  fontWeight: 600,
                ),
                MyText.bodyMedium(
                  '\$${controller.tax.precise}',
                  fontWeight: 700,
                ),
              ],
            ),
            MySpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.bodyMedium(
                  'Offer',
                  fontWeight: 600,
                ),
                MyText.bodyMedium(
                  '- \$${controller.offer.precise}',
                  fontWeight: 700,
                ),
              ],
            ),
            MySpacing.height(12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  child: MyDashedDivider(
                    dashSpace: 4,
                    dashWidth: 8,
                    color: theme.colorScheme.onBackground.withAlpha(180),
                    height: 1.2,
                  ),
                )
              ],
            ),
            MySpacing.height(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.bodyMedium(
                  'Grand Total',
                  fontWeight: 700,
                ),
                MyText.bodyMedium(
                  '\$${controller.total.precise}',
                  fontWeight: 800,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: controller,
        tag: 'cart_controller',
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Scaffold(
        body: Container(
            padding: MySpacing.top(MySpacing.safeAreaTop(context) + 20),
            child: LoadingEffect.getCartLoadingScreen(
              context,
            )),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: MyText.titleMedium(
            'Cart',
            fontWeight: 700,
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: MySpacing.nTop(20),
          children: [
            _buildCartList(),
            _billingWidget(),
            MySpacing.height(20),
            FadeTransition(
              opacity: controller.fadeAnimation,
              child: MyButton.block(
                  onPressed: () {
                    controller.goToCheckout();
                  },
                  backgroundColor: theme.colorScheme.primary,
                  elevation: 0,
                  padding: MySpacing.xy(16, 20),
                  borderRadiusAll: 4,
                  child: Row(
                    children: [
                      SlideTransition(
                        position: controller.animation,
                        child: Image(
                          height: 22,
                          width: 22,
                          color: theme.colorScheme.onPrimary,
                          image: AssetImage(
                              'assets/images/apps/shopping2/icons/clear_cart_outline.png'),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: MyText.bodyMedium(
                            'Checkout',
                            fontWeight: 600,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      );
    }
  }
}
