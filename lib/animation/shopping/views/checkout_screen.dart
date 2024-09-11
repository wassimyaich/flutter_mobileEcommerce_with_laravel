import 'package:flutkit/animation/shopping/controllers/checkout_controller.dart';
import 'package:flutkit/animation/shopping/models/shipping_address.dart';
import 'package:flutkit/helpers/localizations/language.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/widgets/my_button.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutkit/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  late ThemeData theme;

  late CheckOutController controller;
  // Boolean to toggle between address list and form
  bool showAddressForm = false;
  // Controllers for the form fields
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = CheckOutController();
  }

  Widget buildTabs() {
    List<Widget> tabs = [];

    for (int i = 0; i < controller.tabs.length; i++) {
      bool selected = controller.currentPage == i;
      tabs.add(Expanded(
        flex: selected ? 4 : 3,
        child: MyContainer(
          onTap: () {
            controller.onPageChanged(i, fromUser: true);
          },
          color: selected ? theme.colorScheme.primary : theme.cardTheme.color,
          paddingAll: 12,
          borderRadiusAll: 0,
          child: Column(
            children: [
              Icon(
                controller.tabs[i].iconData,
                size: 20,
                color: selected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onBackground,
              ),
              MyText.bodySmall(
                controller.tabs[i].name,
                fontWeight: 600,
                color: selected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onBackground,
              ),
            ],
          ),
        ),
      ));
    }

    return Row(
      children: tabs,
    );
  }

  Widget _buildSingleShippingAddress(ShippingAddress shippingAddress) {
    bool selected = controller.addressSelected == shippingAddress;
    return MyContainer.bordered(
      onTap: () {
        controller.selectShippingAddress(shippingAddress);
      },
      borderRadiusAll: 4,
      margin: MySpacing.bottom(20),
      border: Border.all(
          color: selected
              ? theme.colorScheme.primary
              : theme.colorScheme.onBackground),
      color: selected
          ? theme.colorScheme.primary.withAlpha(40)
          : theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.home,
                size: 20,
                color: theme.colorScheme.onBackground.withAlpha(220),
              ),
              MySpacing.width(12),
              MyText.bodyMedium(
                shippingAddress.paymentMethod,
                fontWeight: 700,
              ),
              MySpacing.width(12),
              shippingAddress.isDefault
                  ? MyContainer(
                      borderRadiusAll: 4,
                      padding: MySpacing.xy(8, 4),
                      color: theme.colorScheme.primary,
                      child: MyText.bodySmall(
                        'Default',
                        color: theme.colorScheme.onPrimary,
                        fontSize: 11,
                      ),
                    )
                  : Container(),
              selected
                  ? Expanded(
                      child: Align(
                        alignment: Language.autoDirection<AlignmentGeometry>(
                            Alignment.centerRight, Alignment.centerLeft)!,
                        child: MyContainer.roundBordered(
                          paddingAll: 4,
                          border: Border.all(color: theme.colorScheme.primary),
                          color: theme.colorScheme.primary.withAlpha(40),
                          child: Icon(
                            Icons.check,
                            color: theme.colorScheme.primary,
                            size: 10,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          MySpacing.height(8),
          MyText.bodySmall(
            shippingAddress.name,
            fontWeight: 600,
          ),
          MySpacing.height(4),
          MyText.bodySmall(
            shippingAddress.phone,
            fontWeight: 600,
          ),
          MySpacing.height(8),
          MyText.bodySmall(
            shippingAddress.address,
            muted: true,
          ),
        ],
      ),
    );
  }

  Widget buildShippingAddressForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: addressController,
            decoration: InputDecoration(labelText: 'Address'),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(labelText: 'Phone Number'),
            keyboardType: TextInputType.phone,
          ),
          MySpacing.height(20),
          ElevatedButton(
            onPressed: () {
              ShippingAddress newAddress = ShippingAddress(
                id: DateTime.now().millisecondsSinceEpoch,
                name: nameController.text,
                address: addressController.text,
                phone: phoneController.text,
                email: '', // Add if needed
                paymentMethod: '', // Add if needed
                isDefault: true, items: [],
              );

              // Add new address to the list and switch back to the address list view
              controller.addressList.add(newAddress);
              setState(() {
                showAddressForm = false;
              });
            },
            child: Text('Save Address'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutController>(
        init: controller,
        tag: 'check_out_controller',
        builder: (controller) {
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: MyText.titleMedium(
                'Checkout',
                fontWeight: 600,
              ),
              leading: InkWell(
                onTap: () {
                  controller.goBack();
                },
                child: Icon(
                  LucideIcons.chevronLeft,
                  size: 20,
                ),
              ),
            ),
            body: Column(
              children: [
                MySpacing.height(8),
                MyContainer(
                  margin: MySpacing.x(20),
                  paddingAll: 0,
                  color: Colors.transparent,
                  borderRadiusAll: 4,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: buildTabs(),
                ),
                MySpacing.height(20),
                Expanded(
                  child: PageView(
                    allowImplicitScrolling: true,
                    pageSnapping: true,
                    physics: ClampingScrollPhysics(),
                    controller: controller.pageController,
                    onPageChanged: (int page) {
                      controller.onPageChanged(page);
                    },
                    children: [shippingInfo(), paymentInfo(), placedInfo()],
                  ),
                ),
              ],
            ),
          );
        });
  }

  // Widget shippingInfo() {
  //   return Container(
  //     padding: MySpacing.x(20),
  //     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //       MyText.labelLarge(
  //         'Select delivery address',
  //         fontWeight: 600,
  //       ),
  //       // MySpacing.height(20),
  //       // ...controller.addressList!
  //       //     .map((shippingAddress) =>
  //       //         _buildSingleShippingAddress(shippingAddress))
  //       //     .toList(),
  //       Row(
  //         children: [
  //           MyButton(
  //             padding: MySpacing.xy(16, 16),
  //             onPressed: () {
  //               //  here Shipping Address
  //             },
  //             borderRadiusAll: 4,
  //             elevation: 0,
  //             splashColor: theme.colorScheme.primary.withAlpha(30),
  //             backgroundColor: theme.colorScheme.primaryContainer,
  //             child: Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Icon(
  //                   LucideIcons.plus,
  //                   color: theme.colorScheme.primary,
  //                   size: 18,
  //                 ),
  //                 MySpacing.width(8),
  //                 MyText.labelMedium(
  //                   'Shipping Address',
  //                   color: theme.colorScheme.primary,
  //                   fontWeight: 600,
  //                 ),
  //               ],
  //             ),
  //           ),
  //           MySpacing.width(20),
  //           Expanded(
  //             child: MyButton(
  //               padding: MySpacing.y(18),
  //               onPressed: () {
  //                 controller.nextPage();
  //               },
  //               borderRadiusAll: 4,
  //               elevation: 0,
  //               splashColor: theme.colorScheme.onPrimary.withAlpha(30),
  //               backgroundColor: theme.colorScheme.primary,
  //               child: MyText.labelMedium(
  //                 'Proceed to Payment',
  //                 color: theme.colorScheme.onPrimary,
  //                 fontWeight: 600,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ]),
  //   );
  // }
  Widget shippingInfo() {
    return Container(
      padding: MySpacing.x(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MyText.labelLarge(
          'Select delivery address',
          fontWeight: 600,
        ),
        MySpacing.height(20),
        // If showAddressForm is true, show the form, otherwise show the address list
        showAddressForm
            ? buildShippingAddressForm()
            : Column(
                children: [
                  ...controller.addressList
                      .map((shippingAddress) =>
                          _buildSingleShippingAddress(shippingAddress))
                      .toList(),
                  MySpacing.height(20),
                  Row(
                    children: [
                      MyButton(
                        padding: MySpacing.xy(16, 16),
                        onPressed: () {
                          // Switch to the form view
                          setState(() {
                            showAddressForm = true;
                          });
                        },
                        borderRadiusAll: 4,
                        elevation: 0,
                        splashColor: theme.colorScheme.primary.withAlpha(30),
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              LucideIcons.plus,
                              color: theme.colorScheme.primary,
                              size: 18,
                            ),
                            MySpacing.width(8),
                            MyText.labelMedium(
                              'Shipping Address',
                              color: theme.colorScheme.primary,
                              fontWeight: 600,
                            ),
                          ],
                        ),
                      ),
                      MySpacing.width(20),
                      Expanded(
                        child: MyButton(
                          padding: MySpacing.y(18),
                          onPressed: () {
                            controller.nextPage();
                          },
                          borderRadiusAll: 4,
                          elevation: 0,
                          splashColor:
                              theme.colorScheme.onPrimary.withAlpha(30),
                          backgroundColor: theme.colorScheme.primary,
                          child: MyText.labelMedium(
                            'Proceed to Payment',
                            color: theme.colorScheme.onPrimary,
                            fontWeight: 600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ]),
    );
  }

  Widget paymentInfo() {
    return Container(
      padding: MySpacing.x(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.labelLarge(
            'Select payment method',
            fontWeight: 600,
          ),
          MySpacing.height(20),
          MyContainer.bordered(
            onTap: () {
              controller.selectPaymentMethod(1);
            },
            borderRadiusAll: 4,
            margin: MySpacing.bottom(20),
            border: Border.all(
                color: controller.paymentMethodSelected == 1
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onBackground),
            color: controller.paymentMethodSelected == 1
                ? theme.colorScheme.primary.withAlpha(40)
                : theme.scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      LucideIcons.creditCard,
                      size: 20,
                      color: theme.colorScheme.onBackground.withAlpha(220),
                    ),
                    MySpacing.width(8),
                    MyText.bodyMedium(
                      'Credit Card',
                      fontWeight: 700,
                    ),
                    controller.paymentMethodSelected == 1
                        ? Expanded(
                            child: Align(
                              alignment:
                                  Language.autoDirection<AlignmentGeometry>(
                                      Alignment.centerRight,
                                      Alignment.centerLeft)!,
                              child: MyContainer.roundBordered(
                                paddingAll: 4,
                                border: Border.all(
                                    color: theme.colorScheme.primary),
                                color: theme.colorScheme.primary.withAlpha(40),
                                child: Icon(
                                  Icons.check,
                                  color: theme.colorScheme.primary,
                                  size: 10,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                MySpacing.height(8),
                MyText.bodySmall(
                  'Nency AnGhan',
                  fontWeight: 600,
                ),
                MySpacing.height(4),
                MyText.bodySmall(
                  '**** **** **** 7865',
                  fontWeight: 600,
                ),
                MySpacing.height(4),
                MyText.bodySmall(
                  'Expiry: 06/25',
                  fontWeight: 600,
                ),
                MySpacing.height(20),
                MyText.bodySmall(
                  'Secure checkout powered by OnePay',
                  muted: true,
                ),
              ],
            ),
          ),
          MyContainer.bordered(
            onTap: () {
              controller.selectPaymentMethod(2);
            },
            borderRadiusAll: 4,
            margin: MySpacing.bottom(20),
            border: Border.all(
                color: controller.paymentMethodSelected == 2
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onBackground),
            color: controller.paymentMethodSelected == 2
                ? theme.colorScheme.primary.withAlpha(40)
                : theme.scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      LucideIcons.dollarSign,
                      size: 18,
                      color: theme.colorScheme.onBackground.withAlpha(220),
                    ),
                    MySpacing.width(8),
                    MyText.bodyMedium(
                      'Cash on delivery',
                      fontWeight: 700,
                    ),
                    controller.paymentMethodSelected == 2
                        ? Expanded(
                            child: Align(
                              alignment:
                                  Language.autoDirection<AlignmentGeometry>(
                                      Alignment.centerRight,
                                      Alignment.centerLeft)!,
                              child: MyContainer.roundBordered(
                                paddingAll: 4,
                                border: Border.all(
                                    color: theme.colorScheme.primary),
                                color: theme.colorScheme.primary.withAlpha(40),
                                child: Icon(
                                  Icons.check,
                                  color: theme.colorScheme.primary,
                                  size: 10,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                MySpacing.height(8),
                MyText.bodySmall(
                  'Additional \$ 20 charges for COD services.',
                  muted: true,
                ),
              ],
            ),
          ),
          MyText.labelLarge(
            'Do you have promo code?',
            fontWeight: 700,
          ),
          MySpacing.height(20),
          MyContainer(
            paddingAll: 12,
            borderRadiusAll: 4,
            child: Row(
              children: [
                Icon(
                  LucideIcons.creditCard,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                MySpacing.width(16),
                Expanded(
                    child: MyText.labelLarge(
                  'Black Friday Promo',
                  fontWeight: 600,
                )),
                MySpacing.width(16),
                MyContainer(
                  borderRadiusAll: 2,
                  padding: MySpacing.xy(8, 4),
                  color: theme.colorScheme.primary.withAlpha(40),
                  child: MyText.bodySmall(
                    'BLCK20',
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          MySpacing.height(20),
          MyContainer(
            paddingAll: 12,
            borderRadiusAll: 4,
            child: Row(
              children: [
                Icon(
                  LucideIcons.creditCard,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                MySpacing.width(16),
                Expanded(
                    child: MyText.labelLarge(
                  'Cyber Week Deal',
                  fontWeight: 600,
                )),
                MySpacing.width(16),
                MyContainer(
                  borderRadiusAll: 2,
                  padding: MySpacing.xy(8, 4),
                  color: theme.colorScheme.primary.withAlpha(40),
                  child: MyText.bodySmall(
                    'CYBR00',
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          MySpacing.height(20),
          MyButton.block(
            onPressed: () async {
              // controller.nextPage();
              String phone = phoneController.text;
              String address = addressController.text;

              // Get selected payment method
              String paymentMethod = controller.paymentMethodSelected == 1
                  ? 'Credit Card'
                  : 'Cash on Delivery';

              // Call createShippingAddress method
              try {
                ShippingAddress newAddress =
                    await ShippingAddress.createShippingAddress(
                  phone,
                  address,
                  paymentMethod,
                );

                // If successful, navigate or show confirmation
                Get.snackbar(
                    "Success", "Shipping address created successfully");
                controller.nextPage(); // Proceed to order confirmation
              } catch (e) {
                Get.snackbar("Error", "Failed to create shipping address: $e");
              }
            },
            borderRadiusAll: 4,
            elevation: 0,
            padding: MySpacing.xy(20, 20),
            splashColor: theme.colorScheme.onPrimary.withAlpha(30),
            backgroundColor: theme.colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.bodyMedium(
                  'Place Order',
                  fontWeight: 600,
                  color: theme.colorScheme.onPrimary,
                ),
                MyText.bodyMedium(
                  '\$ 251.55',
                  fontWeight: 700,
                  color: theme.colorScheme.onPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget placedInfo() {
    return Padding(
      padding: MySpacing.x(20),
      child: Column(
        children: [
          Container(
              margin: MySpacing.all(20),
              child: Image(
                image: AssetImage(Images.shoppingOrderSuccess),
              )),
          MySpacing.height(20),
          MyText.titleLarge(
            'Order Success',
            fontWeight: 700,
          ),
          MySpacing.height(8),
          MyText.labelLarge(
            'Your packet will be sent to your \naddress, thanks for order',
            textAlign: TextAlign.center,
            xMuted: true,
          ),
          MySpacing.height(24),
          MyButton.block(
            onPressed: () {
              controller.goBack();
            },
            borderRadiusAll: 4,
            elevation: 0,
            padding: MySpacing.y(20),
            splashColor: theme.colorScheme.onPrimary.withAlpha(30),
            backgroundColor: theme.colorScheme.primary,
            child: MyText.labelLarge(
              'Back To Home',
              color: theme.colorScheme.onPrimary,
              fontWeight: 600,
            ),
          ),
        ],
      ),
    );
  }
}
