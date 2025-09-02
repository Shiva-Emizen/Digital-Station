import 'package:flutter/material.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';

class RecommendedViewAllPage extends StatelessWidget {
  final List<Map<String, dynamic>> recommendedList;

  const RecommendedViewAllPage({super.key, required this.recommendedList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Custom back button
                  InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF252525),
                        size: 18.0,
                      ),
                    ),
                  ),
                  // Title
                  Text(
                    'Recommended Services',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'primaryFont',
                      color: Color(0xFF252525),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Placeholder for alignment
                  SizedBox(width: 36.0),
                ],
              ),
            ),
            Expanded(
              child: recommendedList.isEmpty
                  ? Center(
                child: Text(
                  'No data found',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'primaryFont',
                    color: Color(0xFF898989),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: recommendedList.length,
                  itemBuilder: (context, index) {
                    final item = recommendedList[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFE9E9E9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/Rectangle_202.png',
                              image: (item['gallery'] as List).isNotEmpty
                                  ? item['gallery'][0]['url'] ?? ''
                                  : 'assets/images/Rectangle_202.png',
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (_, __, ___) => Icon(Icons.broken_image, size: 100),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item['title'] ?? '',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'primaryFont',
                                color: Color(0xFF252525),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              item['description'] ?? '',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'primaryFont',
                                color: Color(0xFF252525),
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Start From ${item['start_from'] ?? 'N/A'}',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'primaryFont',
                                    color: Color(0xFF898989),
                                    fontSize: 10,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Color(0xFFFFCF26), size: 14),
                                    SizedBox(width: 2),
                                    Text(
                                      item['average_reviews'].toString(),
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'primaryFont',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}