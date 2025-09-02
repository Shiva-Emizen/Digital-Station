import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as p;
import 'view_file_page_model.dart';
export 'view_file_page_model.dart';

class ViewFilePageWidget extends StatefulWidget {
  const ViewFilePageWidget({
    super.key,
    required this.galleryList,
  });

  final List<dynamic>? galleryList;

  static String routeName = 'ViewFilePage';
  static String routePath = '/viewFilePage';

  @override
  State<ViewFilePageWidget> createState() => _ViewFilePageWidgetState();
}

class _ViewFilePageWidgetState extends State<ViewFilePageWidget> {
  late ViewFilePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewFilePageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          title: Text(
            FFLocalizations.of(context).getText(
              's338evod' /* Gallery */,
            ),
            style: FlutterFlowTheme.of(context).titleLarge.override(
              fontFamily: 'primaryFont',
              color: Color(0xFF252525),
              fontSize: 18.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          iconTheme: const IconThemeData(color: Color(0xFF252525)),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: widget.galleryList?.isEmpty ?? true
                ? Center(
              child: Text(
                FFLocalizations.of(context).getText(
                  'no_files' /* No files found */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'primaryFont',
                  color: Color(0xFF898989),
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                ),
              ),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FFLocalizations.of(context).getText(
                    's338evod' /* Gallery */,
                  ),
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: 'primaryFont',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF252525),
                    letterSpacing: 0.0,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final galleryLst = widget.galleryList!.toList();

                      return ListView.builder(
                        itemCount: galleryLst.length,
                        itemBuilder: (context, index) {
                          final galleryLstItem = galleryLst[index];
                          final url = getJsonField(
                            galleryLstItem,
                            r'''$.url''',
                          ).toString();
                          final name = getJsonField(
                            galleryLstItem,
                            r'''$.name''',
                          ).toString();

                          final ext = p
                              .extension(url)
                              .replaceFirst('.', '')
                              .toLowerCase();

                          return Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            color: Colors.white,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Builder(
                                builder: (context) {
                                  if (['jpg', 'jpeg', 'png', 'gif']
                                      .contains(ext)) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: _ShimmerImage(url: url, name: name),
                                    );
                                  } else if (['mp4', 'mov', 'avi', 'webm']
                                      .contains(ext)) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: _VideoPlayerWidget(videoUrl: url, name: name),
                                    );
                                  } else if (ext == 'pdf') {
                                    return _FileIconTile(
                                      icon: Icons.picture_as_pdf,
                                      color: Colors.red,
                                      url: url,
                                      name: name,
                                      label: 'PDF File',
                                    );
                                  } else if (ext == 'csv') {
                                    return _FileIconTile(
                                      icon: Icons.table_chart,
                                      color: Colors.green,
                                      url: url,
                                      name: name,
                                      label: 'CSV File',
                                    );
                                  } else if (ext == 'doc' || ext == 'docx') {
                                    return _FileIconTile(
                                      icon: Icons.description,
                                      color: Colors.blue,
                                      url: url,
                                      name: name,
                                      label: 'Word Document',
                                    );
                                  } else if (ext == 'zip') {
                                    return _FileIconTile(
                                      icon: Icons.archive,
                                      color: Colors.orange,
                                      url: url,
                                      name: name,
                                      label: 'ZIP File',
                                    );
                                  } else {
                                    return _FileIconTile(
                                      icon: Icons.insert_drive_file,
                                      color: Colors.grey,
                                      url: url,
                                      name: name,
                                      label: 'File',
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShimmerImage extends StatelessWidget {
  final String url;
  final String name;

  const _ShimmerImage({required this.url, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          url,
          fit: BoxFit.cover,
          height: 200,
          width: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 200,
                width: double.infinity,
                color: Colors.white,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) =>
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                ),
              ),
        ),
        if (name.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'primaryFont',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF252525),
              ),
            ),
          ),
      ],
    );
  }
}

class _VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String name;

  const _VideoPlayerWidget({required this.videoUrl, required this.name});

  @override
  State<_VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _initialized = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(12),
          ),
          child: _initialized
              ? Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                  ),
                ),
              ),
            ],
          )
              : Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6E2A87)),
            ),
          ),
        ),
        if (widget.name.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.name,
              style: TextStyle(
                fontFamily: 'primaryFont',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF252525),
              ),
            ),
          ),
      ],
    );
  }
}

class _FileIconTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String url;
  final String name;
  final String label;

  const _FileIconTile({
    required this.icon,
    required this.color,
    required this.url,
    required this.name,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        leading: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 32, color: color),
        ),
        title: Text(
          name.isNotEmpty ? name : url.split('/').last,
          style: TextStyle(
            fontFamily: 'primaryFont',
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xFF252525),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          label,
          style: TextStyle(
            fontFamily: 'primaryFont',
            fontSize: 12,
            color: Color(0xFF898989),
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: Color(0xFF6E2A87).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: Icon(Icons.open_in_new, color: Color(0xFF6E2A87), size: 20),
            onPressed: () async {
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Could not open file'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}