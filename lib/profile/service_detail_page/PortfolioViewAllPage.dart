import 'package:flutter/material.dart';
import '../../freelancer/portfolio_page/PortfolioGalleryDetailPageWidget.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';

class PortfolioViewAllPage extends StatelessWidget {
  final List<Map<String, dynamic>> portfolioList;

  const PortfolioViewAllPage({super.key, required this.portfolioList});

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
                  Text(
                    'Portfolio',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'primaryFont',
                      color: Color(0xFF252525),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 36.0),
                ],
              ),
            ),
            Expanded(
              child: portfolioList.isEmpty
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
                  : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: portfolioList.length,
                itemBuilder: (context, index) {
                  final item = portfolioList[index];
                  final gallery = item['gallery'] as List<dynamic>;
                  final firstImageUrl = gallery.isNotEmpty ? gallery[0]['url'] as String : '';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PortfolioGalleryDetailPageWidget(
                            title: item['title'] ?? '',
                            galleryUrls: gallery.map((g) => g['url'] as String).toList(),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              child: firstImageUrl.isNotEmpty
                                  ? Image.network(firstImageUrl, fit: BoxFit.cover, width: double.infinity)
                                  : Container(color: Colors.grey[300]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item['title'] ?? '',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}