import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'profile_page_model.dart';
export 'profile_page_model.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key});

  static String routeName = 'ProfilePage';
  static String routePath = '/profilePage';

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  late ProfilePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _apiCalled = false; // 👈 Flag to avoid repeat calls

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePageModel());
  }

  Future<void> _fetchProfileData() async {
    final result = await ClientHomePageGroup.clientProfileCall.call(
      authToken: FFAppState().apitoken,
    );
    if (!mounted) return;
    setState(() {
      _model.apiResultoen = result;
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    // ✅ Trigger API only once per rebuild (after navigating back)
    if (!_apiCalled) {
      _apiCalled = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _fetchProfileData();
      });
    }

    final profileData = _model.apiResultoen?.jsonBody;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlutterFlowIconButton(
                      borderRadius: 8,
                      buttonSize: 36,
                      fillColor: Colors.white,
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF252525),
                        size: 18,
                      ),
                      onPressed: () {
                        _apiCalled = false; // 👈 Reset flag when going back
                        context.safePop();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              getJsonField(
                                profileData ?? '',
                                r'''$.data.avatar.url''',
                              ).toString(),
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Text(
                              valueOrDefault<String>(
                                getJsonField(
                                  profileData ?? '',
                                  r'''$.data.name''',
                                )?.toString(),
                                'N/A',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'primaryFont',
                                color: const Color(0xFF252525),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 36), // Placeholder
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _InfoRow(
                      iconPath: 'assets/images/marker-pin-04.png',
                      label: 'From',
                      value: getJsonField(
                        profileData ?? '',
                        r'''$.data.country''',
                      )?.toString(),
                    ),
                    Divider(
                      thickness: 2,
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                    _InfoRow(
                      iconPath: 'assets/images/user-02.png',
                      label: 'Member Since',
                      value: getJsonField(
                        profileData ?? '',
                        r'''$.data.created_at''',
                      )?.toString(),
                    ),
                    Divider(
                      thickness: 2,
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                    _InfoRow(
                      iconPath: 'assets/images/sticker-square.png',
                      label: 'Completed Orders',
                      value: getJsonField(
                        profileData ?? '',
                        r'''$.data.completed_jobs''',
                      )?.toString(),
                    ),
                  ].divide(const SizedBox(height: 10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 👇 Reusable info row widget
class _InfoRow extends StatelessWidget {
  final String iconPath;
  final String label;
  final String? value;

  const _InfoRow({
    required this.iconPath,
    required this.label,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            iconPath,
            width: 24,
            height: 24,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'primaryFont',
                color: const Color(0xFF898989),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              valueOrDefault<String>(value, 'N/A'),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'primaryFont',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
