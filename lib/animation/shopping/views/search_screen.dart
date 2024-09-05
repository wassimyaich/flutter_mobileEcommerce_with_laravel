import 'package:flutkit/animation/shopping/controllers/search_controller.dart';
import 'package:flutkit/animation/shopping/models/product.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutkit/helpers/widgets/my_text_style.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late SearchController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = SearchController(this);
  }

  @override
  void dispose() {
    // Dispose of the controller to clean up resources
    controller.dispose();
    super.dispose();
  }

  Widget _buildSingleProduct(Product product) {
    return FadeTransition(
      opacity: controller.fadeAnimation,
      child: MyContainer(
        onTap: () {
          controller.goToProductScreen(product);
        },
        borderRadiusAll: 4,
        paddingAll: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyContainer(
              paddingAll: 0,
              borderRadiusAll: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                children: [
                  Hero(
                    tag: "product_image_${product.name}",
                    child: Image(
                      image: NetworkImage(product.imageUrls),
                      height: 155,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Icon(
                      product.favorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            MySpacing.height(6),
            Hero(
              tag: "product_${product.name}",
              child: MyText.bodyMedium(
                product.name,
                fontWeight: 600,
              ),
            ),
            MySpacing.height(2),
            Hero(
              tag: "${product.name}_${product.price}",
              child: MyText.bodyMedium(
                '\$${product.price}',
                fontWeight: 700,
              ),
            ),
            MySpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Hero(
                  tag: "${product.name}_${product.rating}",
                  child: MyContainer(
                    borderRadiusAll: 4,
                    padding: MySpacing.xy(8, 4),
                    color: theme.colorScheme.primary,
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.star,
                          color: theme.colorScheme.onPrimary,
                          size: 12,
                        ),
                        MySpacing.width(6),
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
                  paddingAll: 2,
                  borderRadiusAll: 6,
                  child: Icon(
                    LucideIcons.plus,
                    size: 16,
                  ),
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
    return GetBuilder<SearchController>(
        init: controller,
        tag: 'search_controller',
        builder: (controller) {
          return Theme(
            data: theme.copyWith(
                colorScheme: theme.colorScheme.copyWith(
                    secondary: theme.colorScheme.primary.withAlpha(40))),
            child: _buildBody(),
          );
        });
  }

  Widget _buildBody() {
    /* if (controller.uiLoading) {
      return Scaffold(
          body: Padding(
        padding: MySpacing.top(MySpacing.safeAreaTop(context) + 20),
        child:
            LoadingEffect.getSearchLoadingScreen(context, theme, theme.colorScheme),
      ));
    } else {*/
    return Scaffold(
      key: controller.scaffoldKey,
      endDrawer: endDrawer(),
      body: ListView(
        padding:
            MySpacing.fromLTRB(20, MySpacing.safeAreaTop(context) + 20, 20, 20),
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: MyTextStyle.bodyMedium(),
                  cursorColor: theme.colorScheme.primary,
                  decoration: InputDecoration(
                    hintText: "Search your product ...",
                    hintStyle: MyTextStyle.bodySmall(
                        color: theme.colorScheme.onBackground),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: theme.cardTheme.color,
                    prefixIcon: Icon(
                      LucideIcons.search,
                      size: 16,
                      color: theme.colorScheme.onBackground.withAlpha(150),
                    ),
                    isDense: true,
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) {
                    controller.searchProducts(value);
                  },
                ),
              ),
              MySpacing.width(20),
              MyContainer(
                paddingAll: 12,
                borderRadiusAll: 4,
                onTap: () {
                  controller.openEndDrawer();
                },
                color: theme.colorScheme.primaryContainer,
                child: Icon(
                  LucideIcons.sliders,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
            ],
          ),
          MySpacing.height(20),
          GridView.builder(
              padding: MySpacing.zero,
              shrinkWrap: true,
              itemCount: controller.products!.length,
              physics: ClampingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: controller.findAspectRatio(),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemBuilder: (BuildContext context, int index) {
                return _buildSingleProduct(controller.products![index]);
              }),
        ],
      ),
    );
    // }
  }

  Widget endDrawer() {
    return Container(
      margin:
          MySpacing.fromLTRB(20, MySpacing.safeAreaTop(context) + 20, 20, 20),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: theme.scaffoldBackgroundColor,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Drawer(
        child: Container(
          color: theme.scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: MySpacing.xy(16, 12),
                color: theme.colorScheme.primary,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: MyText(
                          "Filter",
                          fontWeight: 700,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    MyContainer.rounded(
                        onTap: () {
                          controller.closeEndDrawer();
                        },
                        paddingAll: 6,
                        color: theme.colorScheme.onPrimary.withAlpha(80),
                        child: Icon(
                          LucideIcons.x,
                          size: 12,
                          color: theme.colorScheme.onPrimary,
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                padding: MySpacing.all(20),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText.bodyMedium(
                        "Type",
                        color: theme.colorScheme.onBackground,
                        fontWeight: 600,
                      ),
                      MyText.bodySmall(
                        "${controller.selectedChoices.length} selected",
                        color: theme.colorScheme.onBackground,
                        fontWeight: 600,
                        xMuted: true,
                      ),
                    ],
                  ),
                  MySpacing.height(16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _buildType(),
                  ),
                  MySpacing.height(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText.bodyMedium(
                        "Price Range",
                        color: theme.colorScheme.onBackground,
                        fontWeight: 600,
                      ),
                      MyText.bodySmall(
                        "\$${controller.selectedRange.start.toInt()} - \$${controller.selectedRange.end.toInt()}",
                        color: theme.colorScheme.primary,
                        fontWeight: 600,
                        letterSpacing: 0.35,
                      )
                    ],
                  ),
                  MySpacing.height(16),
                  RangeSlider(
                      activeColor: theme.colorScheme.primary,
                      inactiveColor: theme.colorScheme.primary.withAlpha(100),
                      // max: 10000,
                      // min: 0,
                      max: controller.selectedRange.end,
                      min: controller.selectedRange.start,
                      values: controller.selectedRange,
                      onChanged: (RangeValues newRange) {
                        controller.onChangePriceRange(newRange);
                      }),
                ],
              )),
              Row(
                children: [
                  Expanded(
                      child: MyContainer(
                    onTap: () {
                      controller.closeEndDrawer();
                    },
                    color: Colors.transparent,
                    padding: MySpacing.y(12),
                    child: Center(
                      child: MyText(
                        "Clear",
                        color: theme.colorScheme.primary,
                        fontWeight: 600,
                      ),
                    ),
                  )),
                  Expanded(
                      child: MyContainer.none(
                    onTap: () {
                      controller.closeEndDrawer();
                    },
                    padding: MySpacing.y(12),
                    color: theme.colorScheme.primary,
                    child: Center(
                      child: MyText(
                        "Apply",
                        color: theme.colorScheme.onPrimary,
                        fontWeight: 600,
                      ),
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // List<Widget> _buildType() {
  //   List<Widget> choices = [];
  //   for (var item in controller.categoryList) {
  //     bool selected = controller.selectedChoices.contains(item);
  //     if (selected) {
  //       choices.add(MyContainer.none(
  //           color: theme.colorScheme.primary.withAlpha(28),
  //           bordered: true,
  //           borderRadiusAll: 20,
  //           paddingAll: 8,
  //           border: Border.all(color: theme.colorScheme.primary),
  //           onTap: () {
  //             controller.removeChoice(item);
  //           },
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Icon(
  //                 Icons.check,
  //                 size: 14,
  //                 color: theme.colorScheme.primary,
  //               ),
  //               MySpacing.width(6),
  //               MyText.bodySmall(
  //                 item,
  //                 fontSize: 11,
  //                 color: theme.colorScheme.primary,
  //               )
  //             ],
  //           )));
  //     } else {
  //       choices.add(MyContainer.none(
  //         color: theme.cardTheme.color,
  //         borderRadiusAll: 20,
  //         padding: MySpacing.xy(12, 8),
  //         onTap: () {
  //           controller.addChoice(item);
  //         },
  //         child: MyText.bodySmall(
  //           item,
  //           color: theme.colorScheme.onBackground,
  //           fontSize: 11,
  //         ),
  //       ));
  //     }
  //   }
  //   return choices;
  // }
  List<Widget> _buildType() {
    List<Widget> choices = [];
    for (var item in controller.categoryList) {
      bool selected = controller.selectedChoices.contains(item);
      if (selected) {
        choices.add(MyContainer.none(
            color: theme.colorScheme.primary.withAlpha(28),
            bordered: true,
            borderRadiusAll: 20,
            paddingAll: 8,
            border: Border.all(color: theme.colorScheme.primary),
            onTap: () {
              controller.removeChoice(item);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check,
                  size: 14,
                  color: theme.colorScheme.primary,
                ),
                MySpacing.width(6),
                MyText.bodySmall(
                  item,
                  fontSize: 11,
                  color: theme.colorScheme.primary,
                )
              ],
            )));
      } else {
        choices.add(MyContainer.none(
          color: theme.cardTheme.color,
          borderRadiusAll: 20,
          padding: MySpacing.xy(12, 8),
          onTap: () {
            controller.addChoice(item);
          },
          child: MyText.bodySmall(
            item,
            color: theme.colorScheme.onBackground,
            fontSize: 11,
          ),
        ));
      }
    }
    return choices;
  }
}
