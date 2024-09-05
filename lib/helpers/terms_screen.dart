import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/utils/generator.dart';
import 'package:flutkit/helpers/widgets/my_button.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class TermsScreen extends StatefulWidget {
  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    WidgetsBinding.instance.addPostFrameCallback((_) => _showDialog());
  }

  void _showDialog() {
    showDialog(
        context: context, builder: (BuildContext context) => TermsDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              LucideIcons.chevronLeft,
              size: 20,
            ),
          ),
        ),
        body: Center(
          child: MyButton(
              elevation: 0,
              borderRadiusAll: 4,
              onPressed: () {
                _showDialog();
              },
              padding: MySpacing.xy(20, 16),
              child: MyText.bodyMedium("Read Terms",
                  fontWeight: 600, color: theme.colorScheme.onPrimary)),
        ));
  }
}

class TermsDialog extends StatefulWidget {
  @override
  _TermsDialogState createState() => _TermsDialogState();
}

class _TermsDialogState extends State<TermsDialog> {
  bool? isChecked = false;

  late String text1, text2, text3, text4;

  @override
  void initState() {
    super.initState();
    text1 = Generator.getDummyText(16);
    text2 = Generator.getDummyText(12);
    text3 = Generator.getDummyText(20);
    text4 = Generator.getDummyText(24);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: MyText.titleLarge(
                      "Terms & Conditions",
                      fontWeight: 600,
                    ),
                  ),
                ),
                Icon(
                  LucideIcons.download,
                  size: 24,
                )
              ],
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: MyText.titleMedium("1. Return policy",
                  color: theme.colorScheme.primary, fontWeight: 600),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: MyText.bodyMedium(
                text1,
                color: theme.colorScheme.onBackground,
                fontWeight: 500,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: MyText.titleMedium(
                "2. Replace Policy",
                color: theme.colorScheme.primary,
                fontWeight: 600,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: MyText.bodyMedium(text2,
                  color: theme.colorScheme.onBackground,
                  fontWeight: 500,
                  height: 1.25,
                  letterSpacing: 0.1),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: MyText.titleMedium("3. Coupon policy",
                  color: theme.colorScheme.primary, fontWeight: 600),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: MyText.bodyMedium(text3,
                  color: theme.colorScheme.onBackground,
                  fontWeight: 500,
                  height: 1.25,
                  letterSpacing: 0.1),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: MyText.titleMedium("4. Other",
                  color: theme.colorScheme.primary, fontWeight: 600),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: MyText.bodyMedium(text4,
                  color: theme.colorScheme.onBackground,
                  fontWeight: 500,
                  height: 1.25,
                  letterSpacing: 0.1),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 0),
                        child: MyText.bodyMedium(
                            "Buying this product, you agree to the all conditions",
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500)),
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 8),
                alignment: AlignmentDirectional.centerEnd,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: MyText.bodyMedium("Decline", fontWeight: 600)),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: MyText.bodyMedium("Accept",
                            fontWeight: 600, color: theme.colorScheme.primary)),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
