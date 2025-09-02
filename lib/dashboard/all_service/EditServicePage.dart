import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/form_field_controller.dart';
import '../../freelancer/add_faq_page/EditFaqPage.dart';
import '../../freelancer/add_pakage_page/EditPackage.dart';
import '../../freelancer/add_pakage_page/add_pakage_page_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:mime/mime.dart';

class EditServicePageWidget extends StatefulWidget {
  final String serviceId;
  final String title;
  final String description;
  final int categoryId;
  final int subCategoryId;
  final List<dynamic> gallery;
  final List<dynamic> faqs;
  final List<dynamic> packages;

  const EditServicePageWidget({
    super.key,
    required this.serviceId,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.subCategoryId,
    required this.gallery,
    required this.faqs,
    required this.packages,
  });

  static String routeName = 'EditServicePage';
  static String routePath = '/editServicePage';

  @override
  State<EditServicePageWidget> createState() => _EditServicePageWidgetState();
}

class _EditServicePageWidgetState extends State<EditServicePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  String? selectedCategoryId;
  String? selectedSubCategoryId;

  ApiCallResponse? categoryResponse;
  ApiCallResponse? subCategoryResponse;
  bool isLoading = true;

  List<FFUploadedFile> galleryFiles = [];
  List<String> videoFilePaths = [];
  List<double> videoProgress = [];
  List<bool> videoLoading = [];

  List<int> packageIds = [];
  List<int> faqIds = [];
  List<dynamic> _planList = [];
  List<dynamic> _faqList = [];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.description);
    selectedCategoryId = widget.categoryId.toString();
    selectedSubCategoryId = widget.subCategoryId.toString();
    _initGallery();
    _fetchDropdowns();
    _fetchPackages();
    _fetchFaqs();
  }

  void _initGallery() {
    galleryFiles = widget.gallery.map<FFUploadedFile>((file) {
      if (file is FFUploadedFile) return file;
      return FFUploadedFile(
        name: file['name']?.toString() ?? '',
        bytes: null,
      );
    }).toList();
  }

  Future<void> _fetchPackages() async {
    final response = await FreelancerHomePageGroup.getPlanCall.call(
      authToken: FFAppState().apitoken,
      serviceId: widget.serviceId,
    );
    final planList = FreelancerHomePageGroup.getPlanCall
            .planList(response.jsonBody)
            ?.toList() ??
        [];
    setState(() {
      packageIds = planList
          .map<int>((pkg) {
            final id = getJsonField(pkg, r'$.id');
            return int.tryParse(id.toString()) ?? 0;
          })
          .where((id) => id != 0)
          .toList();
      _planList = planList;
    });
  }

  Future<void> _fetchFaqs() async {
    final response = await FreelancerHomePageGroup.getFAQCall.call(
      serviceId: widget.serviceId,
      authToken: FFAppState().apitoken,
    );
    final faqList = FreelancerHomePageGroup.getFAQCall
            .faqList(response.jsonBody)
            ?.toList() ??
        [];
    setState(() {
      faqIds = faqList
          .map<int>((faq) {
            final id = getJsonField(faq, r'$.id');
            return int.tryParse(id.toString()) ?? 0;
          })
          .where((id) => id != 0)
          .toList();
      _faqList = faqList;
    });
  }

  Future<void> _fetchDropdowns() async {
    categoryResponse = await ClientHomePageGroup.categoryCall.call(
      authToken: FFAppState().apitoken,
    );
    subCategoryResponse = await ClientHomePageGroup.subCategoryCall.call(
      categoryId: selectedCategoryId,
      authToken: FFAppState().apitoken,
    );
    setState(() {
      isLoading = false;
    });
  }

  String getFileType(String? path) {
    final mimeType = lookupMimeType(path ?? '');
    if (mimeType == null) return 'unknown';
    if (mimeType.startsWith('image/')) return 'image';
    if (mimeType.startsWith('video/')) return 'video';
    if (mimeType == 'application/pdf') return 'pdf';
    if (mimeType.contains('word') ||
        mimeType == 'application/msword' ||
        mimeType ==
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document')
      return 'word';
    return 'other';
  }

  Future<Uint8List?> getVideoThumbnail(String path) async {
    return await VideoThumbnail.thumbnailData(
      video: path,
      imageFormat: ImageFormat.PNG,
      maxWidth: 128,
      quality: 25,
    );
  }

  Future<void> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false, // <-- Only one file can be selected
      type: FileType.custom,
      allowedExtensions: [
        'jpg', 'jpeg', 'png', 'mp4', 'mov', 'pdf', 'doc', 'docx'
      ],
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) {
      var selectedUploadedFiles = <FFUploadedFile>[];
      var videoPaths = <String>[];
      var videoLoadingList = <bool>[];
      var videoProgressList = <double>[];

      final file = result.files.first;
      final fileType = getFileType(file.name);
      selectedUploadedFiles.add(FFUploadedFile(
        name: file.name,
        bytes: file.bytes,
        height: null,
        width: null,
        blurHash: null,
      ));
      if (fileType == 'video' && file.path != null) {
        videoPaths.add(file.path!);
        videoLoadingList.add(true);
        videoProgressList.add(0.0);
      }

      setState(() {
        galleryFiles.addAll(selectedUploadedFiles);
        videoFilePaths.addAll(videoPaths);
        videoLoading.addAll(videoLoadingList);
        videoProgress.addAll(videoProgressList);
      });

      for (int i = 0; i < videoPaths.length; i++) {
        for (int p = 1; p <= 100; p++) {
          await Future.delayed(Duration(milliseconds: 20));
          setState(() {
            videoProgress[i] = p / 100;
          });
        }
        setState(() {
          videoLoading[i] = false;
        });
      }
    }
  }

  Future<void> _updateService() async {
    if (!formKey.currentState!.validate()) return;

    // Print API request parameters
    print('API Request:');
    print('title: ${titleController.text}');
    print('description: ${descriptionController.text}');
    print('authToken: ${FFAppState().apitoken}');
    print('subCategoryId: $selectedSubCategoryId');
    print('categoryId: $selectedCategoryId');
    print('faqs: $faqIds');
    print('galleryList: $galleryFiles');
    print('serviceId: ${widget.serviceId}');
    print('packages: $packageIds');

    final response = await FreelancerHomePageGroup.editServicesCall.call(
      title: titleController.text,
      description: descriptionController.text,
      authToken: FFAppState().apitoken,
      subCategoryId: selectedSubCategoryId,
      categoryId: selectedCategoryId,
      faqs: faqIds,
      galleryList: galleryFiles,
      serviceId: widget.serviceId,
      packages: packageIds,
    );

    // Print API response
    print('API Response: ${response.jsonBody}');

    if (response.succeeded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Service updated successfully'),
          backgroundColor: Color(0xFF6E2A87),
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update service'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget buildGalleryImages() {
    final images = galleryFiles.where((g) {
      final name = g.name?.toLowerCase() ?? '';
      return name.endsWith('.jpg') ||
          name.endsWith('.jpeg') ||
          name.endsWith('.png');
    }).toList();
    if (images.isEmpty) return SizedBox();
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: images.map((img) {
        if (img.bytes == null) {
          return Container(
            width: 80,
            height: 80,
            color: Colors.grey[200],
            child: Icon(Icons.image, size: 32),
          );
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.memory(
            img.bytes!,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final categoryList = ClientHomePageGroup.categoryCall
            .categoryList(
              categoryResponse?.jsonBody,
            )
            ?.toList() ??
        [];
    final subCategoryList = ClientHomePageGroup.subCategoryCall
            .subCategoryList(
              subCategoryResponse?.jsonBody,
            )
            ?.toList() ??
        [];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        final horizontalPadding = isWide ? constraints.maxWidth * 0.15 : 20.0;

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 24,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Service',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Service Title',
                        style: FlutterFlowTheme.of(context)
                            .titleSmall
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: 'Enter service title',
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        validator: (val) =>
                            val == null || val.isEmpty ? 'Required' : null,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Service Description',
                        style: FlutterFlowTheme.of(context)
                            .titleSmall
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: descriptionController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Describe your service',
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        validator: (val) =>
                            val == null || val.isEmpty ? 'Required' : null,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Category',
                        style: FlutterFlowTheme.of(context)
                            .titleSmall
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      FlutterFlowDropDown<String>(
                        controller:
                            FormFieldController<String>(selectedCategoryId),
                        options: categoryList
                            .map((e) => getJsonField(e, r'$.id').toString())
                            .toList(),
                        optionLabels: categoryList
                            .map((e) => getJsonField(e, r'$.name').toString())
                            .toList(),
                        onChanged: (val) async {
                          setState(() {
                            selectedCategoryId = val;
                            isLoading = true;
                          });
                          subCategoryResponse =
                              await ClientHomePageGroup.subCategoryCall.call(
                            categoryId: selectedCategoryId,
                            authToken: FFAppState().apitoken,
                          );
                          setState(() {
                            isLoading = false;
                          });
                        },
                        width: double.infinity,
                        height: 56.0,
                        textStyle: FlutterFlowTheme.of(context).bodyMedium,
                        hintText: 'Select Category',
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: 8.0,
                        borderColor: Colors.grey.shade300,
                        borderWidth: 1.0,
                        elevation: 2.0,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Subcategory',
                        style: FlutterFlowTheme.of(context)
                            .titleSmall
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      FlutterFlowDropDown<String>(
                        controller:
                            FormFieldController<String>(selectedSubCategoryId),
                        options: subCategoryList
                            .map((e) => getJsonField(e, r'$.id').toString())
                            .toList(),
                        optionLabels: subCategoryList
                            .map((e) => getJsonField(e, r'$.name').toString())
                            .toList(),
                        onChanged: (val) =>
                            setState(() => selectedSubCategoryId = val),
                        width: double.infinity,
                        height: 56.0,
                        textStyle: FlutterFlowTheme.of(context).bodyMedium,
                        hintText: 'Select Subcategory',
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: 8.0,
                        borderColor: Colors.grey.shade300,
                        borderWidth: 1.0,
                        elevation: 2.0,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Gallery',
                        style: FlutterFlowTheme.of(context)
                            .titleSmall
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 12),
                     // buildGalleryImages(),
                      SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        ...List.generate(galleryFiles.length, (index) {
                          final file = galleryFiles[index];
                          if (file == null) return SizedBox.shrink();
                          final fileType = getFileType(file.name);
                          Widget preview;
                          if (fileType == 'image' && file.bytes != null) {
                            preview = Image.memory(
                              file.bytes!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            );
                          } else if (fileType == 'video') {
                            final videoPath = (videoFilePaths.length > index)
                                ? videoFilePaths[index]
                                : null;
                            final isLoading = (videoLoading.length > index)
                                ? videoLoading[index]
                                : false;
                            final progress = (videoProgress.length > index)
                                ? videoProgress[index]
                                : 0.0;
                            preview = videoPath != null
                                ? isLoading
                                ? Container(
                              width: 80,
                              height: 80,
                              color: Colors.black26,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(value: progress),
                                    SizedBox(height: 8),
                                    Text('${(progress * 100).toInt()}%',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                  ],
                                ),
                              ),
                            )
                                : FutureBuilder<Uint8List?>(
                              future: getVideoThumbnail(videoPath),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  return Stack(
                                    children: [
                                      Image.memory(snapshot.data!,
                                          width: 80, height: 80, fit: BoxFit.cover),
                                      Positioned(
                                        bottom: 4,
                                        right: 4,
                                        child: Icon(Icons.videocam,
                                            color: Colors.white, size: 20),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.black12,
                                    child: Icon(Icons.videocam, size: 32),
                                  );
                                }
                              },
                            )
                                : Container(
                              width: 80,
                              height: 80,
                              color: Colors.black12,
                              child: Icon(Icons.videocam, size: 32),
                            );
                          } else if (fileType == 'pdf') {
                            preview = Container(
                              width: 80,
                              height: 80,
                              color: Colors.red[50],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.picture_as_pdf, color: Colors.red, size: 32),
                                  Text(file.name ?? '',
                                      style: TextStyle(fontSize: 10),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            );
                          } else if (fileType == 'word') {
                            preview = Container(
                              width: 80,
                              height: 80,
                              color: Colors.blue[50],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.description, color: Colors.blue, size: 32),
                                  Text(file.name ?? '',
                                      style: TextStyle(fontSize: 10),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            );
                          } else {
                            preview = Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[200],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.insert_drive_file, color: Colors.grey, size: 32),
                                  Text(file.name ?? '',
                                      style: TextStyle(fontSize: 10),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            );
                          }
                          return Stack(
                            children: [
                              preview,
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      galleryFiles.removeAt(index);
                                      if (videoFilePaths.length > index) {
                                        videoFilePaths.removeAt(index);
                                        videoLoading.removeAt(index);
                                        videoProgress.removeAt(index);
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.close, color: Colors.white, size: 20),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        GestureDetector(
                          onTap: pickFiles,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300, width: 1),
                            ),
                            child: Icon(Icons.add, size: 32),
                          ),
                        ),
                      ],
                    ),
                      SizedBox(height: 24),
                      Text(
                        'Packages',
                        style: FlutterFlowTheme.of(context)
                            .titleSmall
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 12),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _planList.length,
                        separatorBuilder: (_, __) => SizedBox(height: 10.0),
                        itemBuilder: (context, idx) {
                          final pkg = _planList[idx];
                          return Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Image.asset(
                                'assets/images/package.png',
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                pkg['name']?.toString() ??
                                    pkg['title']?.toString() ??
                                    '',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '₹${pkg['price'] ?? ''}',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .copyWith(color: Colors.green),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () async {
                                      final pkg = widget.packages[idx];
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditPackagePageWidget(
                                            packageId: pkg['id'].toString(),
                                            initialTitle:
                                                pkg['title']?.toString() ??
                                                    pkg['name']?.toString() ??
                                                    '',
                                            initialDescription:
                                                pkg['description']
                                                        ?.toString() ??
                                                    '',
                                            initialPrice:
                                                pkg['price']?.toString() ?? '',
                                            initialDeliveryTime:
                                                pkg['delivery_time']
                                                        ?.toString() ??
                                                    '',
                                            initialExpressEnable:
                                                pkg['express_deliver_enable'] ??
                                                    0,
                                            initialExpressAmount:
                                                pkg['express_delivery_amount']
                                                        ?.toString() ??
                                                    '',
                                            initialRevisions:
                                                pkg['number_of_revisions']
                                                        ?.toString() ??
                                                    '',
                                            initialFeatures:
                                                pkg['features'] ?? [],
                                          ),
                                        ),
                                      );
                                      if (result == true) {
                                        setState(() {
                                          // Refresh package list if needed
                                        });
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        _planList.removeAt(idx);
                                        packageIds = _planList
                                            .map<int>((pkg) {
                                              final id =
                                                  getJsonField(pkg, r'$.id');
                                              return int.tryParse(
                                                      id.toString()) ??
                                                  0;
                                            })
                                            .where((id) => id != 0)
                                            .toList();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 24),
                      Text(
                        'FAQ',
                        style: FlutterFlowTheme.of(context)
                            .titleSmall
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 12),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _faqList.length,
                        separatorBuilder: (_, __) => SizedBox(height: 10.0),
                        itemBuilder: (context, idx) {
                          final faq = _faqList[idx];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 2,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        faq['question']?.toString() ?? '',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit,
                                                color: Colors.blue),
                                            onPressed: () async {
                                              final faq = widget.faqs[idx];
                                              final result =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditFaqPageWidget(
                                                    faqId: faq['id'].toString(),
                                                    initialQuestion:
                                                        faq['question']
                                                                ?.toString() ??
                                                            '',
                                                    initialAnswer: faq['answer']
                                                            ?.toString() ??
                                                        '',
                                                  ),
                                                ),
                                              );
                                              if (result == true) {
                                                setState(() {
                                                  // Refresh FAQ list if needed
                                                });
                                              }
                                              // TODO: Navigate to EditFaqPageWidget
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                _faqList.removeAt(idx);
                                                faqIds = _faqList
                                                    .map<int>((faq) {
                                                      final id = getJsonField(
                                                          faq, r'$.id');
                                                      return int.tryParse(
                                                              id.toString()) ??
                                                          0;
                                                    })
                                                    .where((id) => id != 0)
                                                    .toList();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    faq['answer']?.toString() ?? '',
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 32),
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 20.0, 20.0, 0.0),
                          child: Container(
                            width: double.infinity,
                            height: 56.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF6E2A87),
                                  Color(0xFF16AFE6),
                                ],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(1.0, 0.0),
                                end: AlignmentDirectional(-1.0, 0),
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                              shape: BoxShape.rectangle,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 2.0),
                              child: FFButtonWidget(
                                onPressed: _updateService,
                                text: 'Update Service',
                                options: FFButtonOptions(
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: Color(0x004B39EF),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.interTight(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
