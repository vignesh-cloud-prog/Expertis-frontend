import 'package:expertis/components/analytics_info_card.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/responsive.dart';
import 'package:expertis/view_model/shop_analytics_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopAnalyticCards extends StatelessWidget {
  final String? shopId;

  const ShopAnalyticCards({super.key, this.shopId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Responsive(
        mobile: AnalyticInfoCardGridView(
          shopId: shopId,
          crossAxisCount: size.width < 650 ? 2 : 4,
          childAspectRatio: size.width < 650 ? 2 : 1.5,
        ),
        tablet: AnalyticInfoCardGridView(
          shopId: shopId,
        ),
        desktop: AnalyticInfoCardGridView(
          shopId: shopId,
          childAspectRatio: size.width < 1400 ? 1.5 : 2.1,
        ),
      ),
    );
  }
}

class AnalyticInfoCardGridView extends StatefulWidget {
  const AnalyticInfoCardGridView({
    super.key,
    this.shopId,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1.4,
  });

  final int crossAxisCount;
  final double childAspectRatio;
  final String? shopId;

  @override
  State<AnalyticInfoCardGridView> createState() =>
      _AnalyticInfoCardGridViewState();
}

class _AnalyticInfoCardGridViewState extends State<AnalyticInfoCardGridView> {
  final ShopAnalyticsViewModel shopAnalyticsViewModel =
      ShopAnalyticsViewModel();

  @override
  void initState() {
    shopAnalyticsViewModel.fetchShopAnalyticsDataApi(widget.shopId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShopAnalyticsViewModel>.value(
      value: shopAnalyticsViewModel,
      child: Consumer<ShopAnalyticsViewModel>(builder: (context, value, _) {
        switch (value.analyticsData.status) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            return Center(child: Text(value.analyticsData.message.toString()));
          case Status.COMPLETED:
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: shopAnalyticsViewModel.ShopAnalyticsData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: widget.childAspectRatio,
              ),
              itemBuilder: (context, index) => AnalyticInfoCard(
                info: shopAnalyticsViewModel.ShopAnalyticsData.values
                    .elementAt(index),
              ),
            );
          default:
            return Container();
        }
      }),
    );
  }
}
