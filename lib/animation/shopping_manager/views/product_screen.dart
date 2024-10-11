import 'package:flutkit/animation/shopping_manager/controllers/product_controller.dart';
import 'package:flutkit/animation/shopping_manager/model/product.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/theme/constant.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutkit/helpers/widgets/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController(product));

    return GetBuilder<ProductController>(
      init: controller,
      tag: 'product_controller',
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(LucideIcons.chevronLeft, size: 20),
              onPressed: () {
                controller.goBack();
              },
            ),
            title: MyText.titleMedium(controller.product.name),
            actions: [
              IconButton(
                icon: Icon(LucideIcons.check, size: 20),
                onPressed: () {
                  controller.updateProduct();
                },
              ),
              SizedBox(width: 20),
            ],
          ),
          body: SingleChildScrollView(
            padding: MySpacing.fromLTRB(20, 4, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    MyContainer.none(
                      width: MediaQuery.of(context).size.width,
                      borderRadiusAll: Constant.containerRadius.small,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: controller.selectedImage != null
                          ? Image.file(
                              controller.selectedImage!,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              controller.product.imageUrl,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: MyContainer.rounded(
                        paddingAll: 8,
                        onTap: () {
                          controller.updateProductImage();
                        },
                        splashColor: theme.colorScheme.onPrimary.withAlpha(40),
                        color: theme.colorScheme.primary,
                        borderRadiusAll: Constant.containerRadius.small,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Icon(
                          LucideIcons.edit2,
                          size: 16,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                MySpacing.height(20),
                MyText.bodySmall('NAME', fontWeight: 600, muted: true),
                MySpacing.height(8),
                nameField(controller),
                MySpacing.height(20),
                MyText.bodySmall('DESCRIPTION', fontWeight: 600, muted: true),
                MySpacing.height(8),
                descriptionField(controller),
                MySpacing.height(20),
                MyText.bodySmall('PRICE', fontWeight: 600, muted: true),
                MySpacing.height(8),
                priceField(controller),
                MySpacing.height(20),
                Row(
                  children: [
                    MyText.bodySmall('QUANTITY', fontWeight: 600, muted: true),
                    MySpacing.width(20),
                    Expanded(child: quantityField(controller)),
                  ],
                ),
                MySpacing.height(20),
                agreementField(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget nameField(ProductController controller) {
    return TextFormField(
      style: MyTextStyle.bodyMedium(),
      cursorColor: AppTheme.shoppingManagerTheme.colorScheme.primary,
      decoration: InputDecoration(
        hintStyle: MyTextStyle.bodySmall(
            color: AppTheme.shoppingManagerTheme.colorScheme.onBackground),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        filled: true,
        fillColor: AppTheme.shoppingManagerTheme.cardTheme.color,
        isDense: true,
      ),
      controller: controller.nameTE,
      textCapitalization: TextCapitalization.sentences,
    );
  }

  Widget descriptionField(ProductController controller) {
    return TextFormField(
      style: MyTextStyle.bodyMedium(),
      cursorColor: AppTheme.shoppingManagerTheme.colorScheme.primary,
      decoration: InputDecoration(
        hintStyle: MyTextStyle.bodySmall(
            color: AppTheme.shoppingManagerTheme.colorScheme.onBackground),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        filled: true,
        fillColor: AppTheme.shoppingManagerTheme.cardTheme.color,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      ),
      minLines: 3,
      maxLines: 5,
      controller: controller.descriptionTE,
      textCapitalization: TextCapitalization.sentences,
    );
  }

  Widget priceField(ProductController controller) {
    return TextFormField(
      style: MyTextStyle.bodyMedium(),
      cursorColor: AppTheme.shoppingManagerTheme.colorScheme.primary,
      decoration: InputDecoration(
        hintStyle: MyTextStyle.bodySmall(
            color: AppTheme.shoppingManagerTheme.colorScheme.onBackground),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        filled: true,
        fillColor: AppTheme.shoppingManagerTheme.cardTheme.color,
        isDense: true,
      ),
      controller: controller.priceTE,
      keyboardType: TextInputType.number,
    );
  }

  Widget quantityField(ProductController controller) {
    return Row(
      children: [
        MyContainer(
          paddingAll: 8,
          color: controller.isQuanDecreable()
              ? AppTheme.shoppingManagerTheme.colorScheme.primaryContainer
              : Colors.grey,
          onTap: () {
            controller.decreaseQuan();
          },
          child: Icon(
            LucideIcons.minus,
            size: 16,
            color: controller.isQuanDecreable()
                ? AppTheme.shoppingManagerTheme.colorScheme.onPrimaryContainer
                : Colors.grey,
          ),
        ),
        SizedBox(
          width: 28,
          child: Center(
            child: MyText.bodyMedium(controller.quantity.toString()),
          ),
        ),
        MyContainer(
          onTap: () {
            controller.increaseQuan();
          },
          paddingAll: 8,
          color: AppTheme.shoppingManagerTheme.colorScheme.primary,
          child: Icon(
            LucideIcons.plus,
            size: 16,
            color: AppTheme.shoppingManagerTheme.colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }

  Widget agreementField(ProductController controller) {
    return Row(
      children: [
        SizedBox(
          width: 28,
          height: 28,
          child: Checkbox(
            activeColor: AppTheme.shoppingManagerTheme.colorScheme.primary,
            value: controller.agreementChecked,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (bool? value) {
              controller.toggleAgreement();
            },
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: MyText.bodySmall(
            'I accept all terms & condition for these item changes',
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
