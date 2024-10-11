// import 'dart:io'; // For File
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutkit/animation/shopping_manager/controllers/add_product_controller.dart';
import 'package:flutkit/animation/shopping_manager/model/category.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/theme/constant.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutkit/helpers/widgets/my_text_style.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddProductController controller = Get.put(AddProductController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: MyText.titleMedium('Add Product'),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.check, size: 20),
            onPressed: () {
              controller.addProduct();
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
                      : Placeholder(
                          fallbackHeight: 200,
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
                    splashColor: AppTheme
                        .shoppingManagerTheme.colorScheme.onPrimary
                        .withAlpha(40),
                    color: AppTheme.shoppingManagerTheme.colorScheme.primary,
                    borderRadiusAll: Constant.containerRadius.small,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Icon(
                      LucideIcons.edit2,
                      size: 16,
                      color:
                          AppTheme.shoppingManagerTheme.colorScheme.onPrimary,
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
            MyText.bodySmall('CATEGORY', fontWeight: 600, muted: true),
            MySpacing.height(8),
            categoryDropdown(controller),
            MySpacing.height(20),
          ],
        ),
      ),
    );
  }

  Widget nameField(AddProductController controller) {
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
      controller: controller.nameTE.value,
      textCapitalization: TextCapitalization.sentences,
    );
  }

  Widget descriptionField(AddProductController controller) {
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
      controller: controller.descriptionTE.value,
      textCapitalization: TextCapitalization.sentences,
    );
  }

  Widget priceField(AddProductController controller) {
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
      controller: controller.priceTE.value,
      keyboardType: TextInputType.number,
    );
  }

  Widget quantityField(AddProductController controller) {
    return Obx(() {
      // Wrap the widget with Obx to listen for changes
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
    });
  }

  Widget categoryDropdown(AddProductController controller) {
    return Obx(() {
      return DropdownButtonFormField<Category>(
        value: controller.selectedCategory.value,
        items: controller.categories.map((category) {
          return DropdownMenuItem<Category>(
            value: category,
            child: Text(category.name), // Display category name
          );
        }).toList(),
        onChanged: (Category? newCategory) {
          controller.selectedCategory.value =
              newCategory; // Set the selected category
        },
        decoration: InputDecoration(
          hintStyle: MyTextStyle.bodySmall(
              color: AppTheme.shoppingManagerTheme.colorScheme.onBackground),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          filled: true,
          fillColor: AppTheme.shoppingManagerTheme.cardTheme.color,
          isDense: true,
        ),
      );
    });
  }
}
