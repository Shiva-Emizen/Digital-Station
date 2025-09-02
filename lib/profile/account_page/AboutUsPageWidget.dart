import 'package:flutter/material.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AboutUsPageWidget extends StatefulWidget {
  const AboutUsPageWidget({Key? key}) : super(key: key);

  @override
  State<AboutUsPageWidget> createState() => _AboutUsPageWidgetState();
}

class _AboutUsPageWidgetState extends State<AboutUsPageWidget> {
  bool _isLoading = true;
  String aboutUsText = '';

  @override
  void initState() {
    super.initState();
    _fetchAboutUsData();
  }

  Future<void> _fetchAboutUsData() async {
    final response = await ClientHomePageGroup.aboutUsDetail.call(
      authToken: FFAppState().apitoken,
    );
    final aboutUs =
        getJsonField(response.jsonBody, r'''$.about_us''').toString();
    setState(() {
      aboutUsText = aboutUs;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      body: SafeArea(
        top: true,
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
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
                          'About Us',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'primaryFont',
                                    color: Color(0xFF252525),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(width: 36),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          aboutUsText,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'primaryFont',
                                    fontSize: 15.0,
                                    color: Color(0xFF252525),
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
