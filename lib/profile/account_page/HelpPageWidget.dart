import 'package:flutter/material.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HelpPageWidget extends StatefulWidget {
  const HelpPageWidget({Key? key}) : super(key: key);

  @override
  State<HelpPageWidget> createState() => _HelpPageWidgetState();
}

class _HelpPageWidgetState extends State<HelpPageWidget> {
  bool _isLoading = true;
  String helpText = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _fetchHelpData();
  }

  Future<void> _fetchHelpData() async {
    final response = await ClientHomePageGroup.helpDetail.call(
      authToken: FFAppState().apitoken,
    );
    final data = getJsonField(response.jsonBody, r'''$.data''').toString();
    // Extract email from the data string (simple parsing)
    final emailMatch = RegExp(r'Email id :- ([\w\.\-@]+)').firstMatch(data);
    setState(() {
      helpText = data.replaceAll(RegExp(r'Email id :- [\w\.\-@]+'), '').trim();
      email = emailMatch?.group(1) ?? '';
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
                    'Help',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        helpText,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'primaryFont',
                          fontSize: 15.0,
                          color: Color(0xFF252525),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.email, color: Color(0xFF6E2A87)),
                          SizedBox(width: 8),
                          Text(
                            email,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'primaryFont',
                              fontSize: 15.0,
                              color: Color(0xFF6E2A87),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
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