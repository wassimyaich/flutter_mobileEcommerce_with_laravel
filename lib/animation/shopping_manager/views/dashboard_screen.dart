import 'package:flutkit/animation/shopping_manager/controllers/dashboard_controller.dart';
import 'package:flutkit/helpers/theme/app_theme.dart';
import 'package:flutkit/helpers/theme/constant.dart';
import 'package:flutkit/helpers/widgets/my_container.dart';
import 'package:flutkit/helpers/widgets/my_spacing.dart';
import 'package:flutkit/helpers/widgets/my_text.dart';
import 'package:flutkit/charts_sample_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ThemeData theme;
  late DashboardController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingManagerTheme;
    controller = DashboardController();
    outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: theme.dividerColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: controller,
        tag: 'dashboard_controller',
        // theme: theme,
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: MySpacing.fromLTRB(
                    20, MySpacing.safeAreaTop(context) + 16, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.titleLarge(
                      "Dashboard",
                      fontWeight: 600,
                    ),
                    MySpacing.height(16),
                    alert(),
                    MySpacing.height(16),
                    overview(),
                    MySpacing.height(20),
                    statistics(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget alert() {
    return MyContainer(
      color: Constant.softColors.green.color,
      child: Row(
        children: [
          MyText.bodySmall(
            'Alert: ',
            color: Constant.softColors.green.onColor,
            fontWeight: 700,
          ),
          MyText.bodySmall(
            'Your shop is approved for outside delivery',
            color: Constant.softColors.green.onColor,
            fontWeight: 600,
            fontSize: 11,
          )
        ],
      ),
    );
  }

  Widget timeFilter() {
    return PopupMenuButton(
      color: theme.colorScheme.background,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constant.containerRadius.small)),
      elevation: 1,
      child: MyContainer.bordered(
          paddingAll: 12,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText.bodySmall(
                controller.time,
              ),
              MySpacing.width(8),
              Icon(
                LucideIcons.chevronDown,
                size: 14,
              )
            ],
          )),
      itemBuilder: (BuildContext context) => [
        ...controller.filterTime.map((time) => PopupMenuItem(
            onTap: () {
              controller.changeFilter(time);
            },
            padding: MySpacing.x(16),
            height: 36,
            child: MyText.bodyMedium(time)))
      ],
    );
  }

  Widget overview() {
    return Column(
      children: [
        MyContainer(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MyContainer(
                      width: 10,
                      height: 20,
                      color: theme.colorScheme.primaryContainer,
                      borderRadiusAll: 2,
                    ),
                    MySpacing.width(8),
                    MyText.titleSmall(
                      "Overview",
                      fontWeight: 600,
                    ),
                  ],
                ),
                timeFilter()
              ],
            ),
            MySpacing.height(20),
            status()
          ],
        )),
      ],
    );
  }

  Widget status() {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: MyContainer.bordered(
              color: theme.colorScheme.background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodySmall(
                    'Customers',
                    fontWeight: 600,
                    muted: true,
                  ),
                  MySpacing.height(8),
                  MyText.titleLarge(
                    '248',
                    fontWeight: 700,
                  ),
                  MySpacing.height(8),
                  MyContainer(
                      borderRadiusAll: Constant.containerRadius.small,
                      paddingAll: 6,
                      color: theme.colorScheme.primaryContainer,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.arrowUp,
                            size: 12,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                          MySpacing.width(2),
                          MyText.bodySmall(
                            "28%",
                            color: theme.colorScheme.onPrimaryContainer,
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
          MySpacing.width(20),
          Expanded(
              child: MyContainer(
            color: theme.colorScheme.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodySmall(
                  'Income',
                  fontWeight: 600,
                  muted: true,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                MySpacing.height(8),
                MyText.titleLarge(
                  '148k',
                  fontWeight: 700,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                MySpacing.height(8),
                MyContainer(
                    borderRadiusAll: Constant.containerRadius.small,
                    paddingAll: 6,
                    color: theme.colorScheme.errorContainer,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LucideIcons.arrowDown,
                          size: 12,
                          color: theme.colorScheme.onErrorContainer,
                        ),
                        MySpacing.width(2),
                        MyText.bodySmall(
                          "45%",
                          fontWeight: 600,
                          color: theme.colorScheme.onErrorContainer,
                        )
                      ],
                    ))
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget statistics() {
    return MyContainer(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                MyContainer(
                  width: 10,
                  height: 20,
                  color: theme.colorScheme.primaryContainer,
                  borderRadiusAll: 2,
                ),
                MySpacing.width(8),
                MyText.titleSmall(
                  "Sales Status",
                  fontWeight: 600,
                ),
              ],
            ),
            timeFilter()
          ],
        ),
        MySpacing.height(20),
        salesStatusChart()
      ],
    ));
  }

  SfCartesianChart salesStatusChart() {
    return SfCartesianChart(
      margin: EdgeInsets.zero,
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(
          width: 0,
          color: Colors.transparent,
        ),
      ),
      primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(width: 0, color: Colors.transparent),
          labelFormat: '{value}k',
          majorTickLines: MajorTickLines(size: 4, color: Colors.transparent)),
      series: _getDefaultColumnSeries(),
      tooltipBehavior: controller.tooltipBehavior,
    );
  }

  List<ColumnSeries<ChartSampleData, String>> _getDefaultColumnSeries() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: controller.chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
        width: 0.5,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(Constant.containerRadius.xs)),
        dataLabelSettings: DataLabelSettings(
            isVisible: false, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }
}
