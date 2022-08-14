import 'package:expertis/components/analytics_info_card.dart';
import 'package:expertis/responsive.dart';
import 'package:expertis/view_model/admin_analytics_view_model.dart';
import 'package:expertis/view_model/shop_analytics_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopAnalyticCards extends StatelessWidget {
  const ShopAnalyticCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Responsive(
        mobile: AnalyticInfoCardGridView(
          crossAxisCount: size.width < 650 ? 2 : 4,
          childAspectRatio: size.width < 650 ? 2 : 1.5,
        ),
        tablet: AnalyticInfoCardGridView(),
        desktop: AnalyticInfoCardGridView(
          childAspectRatio: size.width < 1400 ? 1.5 : 2.1,
        ),
      ),
    );
  }
}

class AnalyticInfoCardGridView extends StatefulWidget {
  const AnalyticInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1.4,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<AnalyticInfoCardGridView> createState() =>
      _AnalyticInfoCardGridViewState();
}

class _AnalyticInfoCardGridViewState extends State<AnalyticInfoCardGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: ShopAnalyticsViewModel.ShopAnalyticsData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (context, index) => AnalyticInfoCard(
        info: ShopAnalyticsViewModel.ShopAnalyticsData.values.elementAt(index),
      ),
    );
  }
}
