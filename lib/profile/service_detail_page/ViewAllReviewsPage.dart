import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';

class ViewAllReviewsPage extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;

  const ViewAllReviewsPage({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 36.0,
                      fillColor: Colors.white,
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF252525),
                        size: 18.0,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Text(
                      'All Reviews',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'primaryFont',
                            color: Color(0xFF252525),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(width: 36), // Placeholder for alignment
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: reviews.isEmpty
                      ? Center(
                          child: Text(
                            'No reviews found',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        )
                      : ListView.separated(
                          itemCount: reviews.length,
                          separatorBuilder: (_, __) => SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final review = reviews[index];
                            final userImageUrl =
                                review['user_image']?['url']?.toString();
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipOval(
                                  child: userImageUrl != null &&
                                          userImageUrl.isNotEmpty
                                      ? Image.network(
                                          userImageUrl,
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Icon(
                                            Icons.account_circle,
                                            size: 40,
                                            color: Color(0xFF898989),
                                          ),
                                        )
                                      : Icon(
                                          Icons.account_circle,
                                          size: 40,
                                          color: Color(0xFF898989),
                                        ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        review['user']?.toString() ?? '',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'primaryFont',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                            ),
                                      ),
                                      SizedBox(height: 4),
                                      RatingBarIndicator(
                                        rating: double.tryParse(
                                                review['rate']?.toString() ??
                                                    '0') ??
                                            0,
                                        itemBuilder: (context, _) => Icon(
                                            Icons.star_rounded,
                                            color: Color(0xFF181725)),
                                        itemCount: 5,
                                        itemSize: 22.0,
                                        unratedColor:
                                            FlutterFlowTheme.of(context)
                                                .accent1,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        review['comment']?.toString() ?? '',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'primaryFont',
                                              fontSize: 14.0,
                                              color: Color(0xFF252525),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
