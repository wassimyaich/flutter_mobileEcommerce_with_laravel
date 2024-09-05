import 'package:flutkit/animation/shopping/controllers/home_controller.dart';
import 'package:flutkit/animation/shopping/models/category.dart';
import 'package:flutkit/animation/shopping/models/product.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/widgets/my_button.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutkit/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late ThemeData theme;

  late HomeController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = HomeController(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addCategories();
    });
  }

  @override
  void dispose() {
    // Dispose of the controller to clean up resources
    controller.dispose();
    super.dispose();
  }

  Widget _buildSingleCategory(Category category) {
    bool selected = category == controller.selectedCategory;
    bool last = controller.categories!.last == category;
    return MyContainer(
      margin: MySpacing.right(last ? 0 : 12),
      onTap: () {
        controller.changeSelectedCategory(category);
      },
      borderRadiusAll: 4,
      color: selected ? theme.colorScheme.primaryContainer : null,
      paddingAll: 12,
      child: Image(
        image: AssetImage(category.icon),
        height: 20,
        color: selected
            ? theme.colorScheme.primary
            : theme.colorScheme.onBackground.withAlpha(220),
        width: 20,
      ),
    );
  }

  Widget _buildProductList() {
    List<Widget> list = [];

    for (Product product in controller.products) {
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: MyContainer(
          onTap: () {
            controller.goToSingleProduct(product);
          },
          borderRadiusAll: 4,
          paddingAll: 16,
          margin: MySpacing.bottom(20),
          child: Row(
            children: [
              MyContainer(
                paddingAll: 0,
                borderRadiusAll: 4,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Hero(
                  tag: "product_image_${product.name}",
                  child: Image(
                    image: NetworkImage(product.imageUrls),
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              MySpacing.width(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                          tag: "product_${product.name}",
                          child: MyText.bodyMedium(
                            product.name,
                          ),
                        ),
                        Icon(
                          product.favorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_rounded,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                    MySpacing.height(4),
                    Hero(
                      tag: "${product.name}_${product.price}",
                      child: MyText.labelLarge(
                        '\$${product.price}',
                        fontWeight: 700,
                      ),
                    ),
                    MySpacing.height(6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                          tag: "${product.name}_${product.rating}",
                          child: MyContainer(
                            borderRadiusAll: 2,
                            padding: MySpacing.xy(8, 4),
                            color: theme.colorScheme.primary,
                            child: Row(
                              children: [
                                Icon(
                                  LucideIcons.star,
                                  color: theme.colorScheme.onPrimary,
                                  size: 12,
                                ),
                                MySpacing.width(4),
                                MyText.bodySmall(
                                  product.rating.toString(),
                                  fontWeight: 600,
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        MyContainer.bordered(
                          paddingAll: 4,
                          borderRadiusAll: 4,
                          child: Icon(
                            LucideIcons.plus,
                            size: 14,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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

  Future<void> addCategories() async {
    Future ft = Future(() {});
    if (controller.newCategories.isEmpty) {
      for (int i = 0; i < controller.categories!.length; i++) {
        ft = ft.then((_) {
          return Future.delayed(Duration(milliseconds: 100), () {
            controller.newCategories
                .add(_buildSingleCategory(controller.categories![i]));
            controller.listKey.currentState!.insertItem(i);
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: controller,
        tag: 'home_controller',
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    /* if (controller.uiLoading) {
      return Scaffold(
          body: Padding(
          padding: MySpacing.top(MySpacing.safeAreaTop(context) + 20),
          child: LoadingEffect.getSearchLoadingScreen(context, theme, theme.colorScheme),
      ));
    } else {*/
    return WillPopScope(
      onWillPop: () => controller.onWillPop(),
      child: Scaffold(
        body: ListView(
          padding: MySpacing.fromLTRB(
              20, MySpacing.safeAreaTop(context) + 20, 20, 0),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Hero(
                //   tag: "splash_username",
                //   child: MyText.titleLarge(
                //     'Hey Nency,',
                //     fontWeight: 700,
                //   ),
                // ),
                Hero(
                  tag: "splash_username",
                  child: FutureBuilder<SharedPreferences>(
                    future: SharedPreferences.getInstance(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String userName =
                            snapshot.data!.getString('name') ?? 'User';
                        return MyText.titleLarge(
                          userName,
                          fontWeight: 700,
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                RotationTransition(
                  turns: controller.bellAnimation,
                  key: controller.intro.keys[0],
                  child: InkWell(
                    onTap: () {
                      controller.goToNotification();
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          LucideIcons.bell,
                          color: theme.colorScheme.onBackground,
                          size: 20,
                        ),
                        Positioned(
                          bottom: -2,
                          right: -2,
                          child: MyContainer.rounded(
                            paddingAll: 3,
                            color: theme.colorScheme.primary,
                            child: Center(
                                child: MyText.bodySmall(
                              '2',
                              color: theme.colorScheme.onPrimary,
                              fontSize: 8,
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            MySpacing.height(4),
            FadeTransition(
              opacity: controller.fadeAnimation,
              child: MyText.bodySmall(
                'Begin your shopping !!',
                xMuted: true,
              ),
            ),
            MySpacing.height(20),
            FadeTransition(
              key: controller.intro.keys[1],
              opacity: controller.fadeAnimation,
              child: MyContainer(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadiusAll: 4,
                onTap: () {
                  controller.goToSubscription();
                },
                color: theme.colorScheme.primaryContainer,
                border: Border.all(color: theme.colorScheme.primaryContainer),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.titleMedium(
                          'Enjoy Upto \n50% Discount',
                          letterSpacing: 0.3,
                          fontWeight: 700,
                          color: theme.colorScheme.primary,
                        ),
                        MySpacing.height(4),
                        MyButton.small(
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          borderRadiusAll: 4,
                          backgroundColor: theme.colorScheme.primary,
                          onPressed: () {
                            controller.goToSubscription();
                          },
                          child: MyText.labelLarge(
                            'Subscribe',
                            letterSpacing: 0.3,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                    MyContainer(
                      paddingAll: 0,
                      borderRadiusAll: 4,
                      height: 100,
                      width: 150,
                      clipBehavior: Clip.hardEdge,
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(Images.shoppingBannerPhoto),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            MySpacing.height(20),
            FadeTransition(
              opacity: controller.fadeAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText.bodyLarge(
                    'Top Categories',
                    letterSpacing: 0,
                    fontWeight: 600,
                  ),
                  MyText.bodySmall(
                    'SEE ALL',
                    fontWeight: 700,
                    letterSpacing: 0.3,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
            ),
            MySpacing.height(20),
            SizedBox(
              key: controller.intro.keys[2],
              height: 50,
              child: AnimatedList(
                  scrollDirection: Axis.horizontal,
                  key: controller.listKey,
                  initialItemCount: controller.newCategories.length,
                  itemBuilder: (context, index, animation) {
                    return SlideTransition(
                        position: animation.drive(controller.offset),
                        child: controller.newCategories[index]);
                  }),
            ),
            MySpacing.height(20),
            FadeTransition(
              opacity: controller.fadeAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText.bodyLarge(
                    'New Arrivals',
                    letterSpacing: 0,
                    fontWeight: 600,
                  ),
                  MyText.bodySmall(
                    'VIEW MORE',
                    fontWeight: 700,
                    letterSpacing: 0.3,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
            ),
            MySpacing.height(20),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: _buildProductList(),
            ),
          ],
        ),
      ),
    );
    //}
  }
}
