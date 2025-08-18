import 'package:flutter/material.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';

class EditPortfolioPageWidget extends StatefulWidget {
  final String initialTitle;
  final List<String> galleryUrls;
  final String portfolioId; // If needed for update API

  const EditPortfolioPageWidget({
    super.key,
    required this.initialTitle,
    required this.galleryUrls,
    required this.portfolioId,
  });

  @override
  State<EditPortfolioPageWidget> createState() => _EditPortfolioPageWidgetState();
}

class _EditPortfolioPageWidgetState extends State<EditPortfolioPageWidget> {
  late TextEditingController _titleController;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _updatePortfolio() async {
    setState(() => _isUpdating = true);
    // TODO: Call your update API here using widget.portfolioId and _titleController.text
    // On success:
    Navigator.pop(context, true); // Optionally return a result
    setState(() => _isUpdating = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Portfolio', style: FlutterFlowTheme.of(context).titleLarge),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        iconTheme: const IconThemeData(color: Color(0xFF252525)),
        centerTitle: true,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: widget.galleryUrls.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.4,
                ),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.galleryUrls[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isUpdating ? null : _updatePortfolio,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6E2A87),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: _isUpdating
                    ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
                    : Text('Update', style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'primaryFont',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}