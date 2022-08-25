import 'package:expertis/components/analytics_info_card.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/responsive.dart';
import 'package:expertis/view_model/admin_analytics_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnalyticCards extends StatelessWidget {
  const AnalyticCards({Key? key}) : super(key: key);

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
  AnalyticInfoCardGridView({
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
  final AdminAnalyticsViewModel adminAnalyticsViewModel =
      AdminAnalyticsViewModel();

  @override
  void initState() {
    adminAnalyticsViewModel.fetchAdminAnalyticsDataApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminAnalyticsViewModel>.value(
      value: adminAnalyticsViewModel,
      child: Consumer<AdminAnalyticsViewModel>(builder: (context, value, _) {
        switch (value.analyticsData.status) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            return Center(child: Text(value.analyticsData.message.toString()));
          case Status.COMPLETED:
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: adminAnalyticsViewModel.adminAnalyticsData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: widget.childAspectRatio,
              ),
              itemBuilder: (context, index) => AnalyticInfoCard(
                info: adminAnalyticsViewModel.adminAnalyticsData.values
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
