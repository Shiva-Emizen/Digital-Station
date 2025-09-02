import 'package:flutter/material.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as p;

class PortfolioGalleryDetailPageWidget extends StatelessWidget {
  final String title;
  final List<String> galleryUrls;

  const PortfolioGalleryDetailPageWidget({
    super.key,
    required this.title,
    required this.galleryUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: FlutterFlowTheme.of(context).titleLarge,
        ),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        iconTheme: const IconThemeData(color: Color(0xFF252525)),
        centerTitle: true,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: galleryUrls.isEmpty
            ? Center(child: Text('No files found'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'primaryFont',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: galleryUrls.length,
                      itemBuilder: (context, index) {
                        final url = galleryUrls[index];
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
                                    child: _ShimmerImage(url: url),
                                  );
                                } else if (['mp4', 'mov', 'avi', 'webm']
                                    .contains(ext)) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: _VideoPlayerWidget(videoUrl: url),
                                  );
                                } else if (ext == 'pdf') {
                                  return _FileIconTile(
                                    icon: Icons.picture_as_pdf,
                                    color: Colors.red,
                                    url: url,
                                    label: 'PDF File',
                                  );
                                } else if (ext == 'csv') {
                                  return _FileIconTile(
                                    icon: Icons.table_chart,
                                    color: Colors.green,
                                    url: url,
                                    label: 'CSV File',
                                  );
                                } else if (ext == 'doc' || ext == 'docx') {
                                  return _FileIconTile(
                                    icon: Icons.description,
                                    color: Colors.blue,
                                    url: url,
                                    label: 'Word Document',
                                  );
                                } else if (ext == 'zip') {
                                  return _FileIconTile(
                                    icon: Icons.archive,
                                    color: Colors.orange,
                                    url: url,
                                    label: 'ZIP File',
                                  );
                                } else {
                                  return _FileIconTile(
                                    icon: Icons.insert_drive_file,
                                    color: Colors.grey,
                                    url: url,
                                    label: 'File',
                                  );
                                }
                              },
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

class _ShimmerImage extends StatelessWidget {
  final String url;

  const _ShimmerImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
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
          const Icon(Icons.broken_image, size: 100),
    );
  }
}

class _VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const _VideoPlayerWidget({required this.videoUrl});

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
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.black12,
      child: _initialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: IconButton(
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 32,
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
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class _FileIconTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String url;
  final String label;

  const _FileIconTile({
    required this.icon,
    required this.color,
    required this.url,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final fileName = url.split('/').last;
    return ListTile(
      leading: Icon(icon, size: 40, color: color),
      title: Text(fileName, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(label),
      trailing: IconButton(
        icon: Icon(Icons.open_in_new, color: Colors.black54),
        onPressed: () async {
          await launchUrl(Uri.parse(url));
        },
      ),
    );
  }
}
