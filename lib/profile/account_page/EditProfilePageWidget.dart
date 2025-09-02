import 'dart:typed_data';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../app_state.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/upload_data.dart';
import '../../components/add_skill_widget.dart';
import '../../components/add_occupation_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Map<String, dynamic>? _profileData;

  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _aboutController = TextEditingController();
  final _jobTitleController = TextEditingController();

  File? _pickedImage;
  Uint8List? _pickedImageBytes;
  bool _isUploadingAvatar = false;

  List<Map<String, dynamic>> _skills = [];
  List<Map<String, dynamic>> _occupations = [];

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    _aboutController.dispose();
    _jobTitleController.dispose();
    super.dispose();
  }

  Future<void> _fetchProfileData() async {
    setState(() => _isLoading = true);
    final result = await ClientHomePageGroup.clientProfileCall.call(
      authToken: FFAppState().apitoken,
    );
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _profileData = result.jsonBody?['data'];
      if (_profileData != null) {
        _nameController.text = _profileData!['name'] ?? '';
        _nicknameController.text = _profileData!['nickname'] ?? '';
        _emailController.text = _profileData!['email'] ?? '';
        _aboutController.text = _profileData!['about'] ?? '';
        _jobTitleController.text = _profileData!['job_title'] ?? '';
        _skills =
        List<Map<String, dynamic>>.from(_profileData!['skills'] ?? []);
        _occupations =
        List<Map<String, dynamic>>.from(_profileData!['occupations'] ?? []);
      }
    });
  }

  Future<File> _saveImageToAppDir(String originalPath, Uint8List? bytes) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedFile = File('${appDir.path}/$fileName');
    if (bytes != null) {
      await savedFile.writeAsBytes(bytes);
    } else {
      final originalFile = File(originalPath);
      if (await originalFile.exists()) {
        await originalFile.copy(savedFile.path);
      } else {
        throw Exception('Original file not found');
      }
    }
    return savedFile;
  }

  Future<void> _pickAndUploadAvatar() async {
    try {
      final selectedMedia = await selectMediaWithSourceBottomSheet(
        context: context,
        allowPhoto: true,
      );
      if (selectedMedia == null || selectedMedia.isEmpty) return;
      if (!selectedMedia
          .every((m) => validateFileFormat(m.storagePath, context))) {
        return;
      }
      setState(() => _isUploadingAvatar = true);
      final media = selectedMedia.first;
      try {
        final savedFile =
        await _saveImageToAppDir(media.storagePath, media.bytes);
        setState(() {
          _pickedImage = savedFile;
          _pickedImageBytes = media.bytes;
        });
        await FreelancerAuthorizationGroup.avatarCall.call(
          avatar: FFUploadedFile(
            bytes: media.bytes,
            name: media.storagePath.split('/').last,
          ),
          authToken: FFAppState().apitoken,
        );
        setState(() => _isUploadingAvatar = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Avatar updated!'),
            backgroundColor: Color(0xFF6E2A87),
          ),
        );
        await _fetchProfileData();
      } catch (e) {
        setState(() => _isUploadingAvatar = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading avatar: $e'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _pickedImage = null;
          _pickedImageBytes = null;
        });
      }
    } catch (e) {
      setState(() => _isUploadingAvatar = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error selecting image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildAvatarSection() {
    final avatarUrl = _profileData?['avatar']?['url'];
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: _pickedImageBytes != null
                ? MemoryImage(_pickedImageBytes!)
                : NetworkImage(
              avatarUrl ??
                  'https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250',
            ) as ImageProvider,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: _isUploadingAvatar ? null : _pickAndUploadAvatar,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3.0,
                      color: Colors.black26,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.edit, color: Color(0xFF6E2A87)),
              ),
            ),
          ),
          if (_isUploadingAvatar)
            const Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(color: Color(0xFF6E2A87)),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _addSkill() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddSkillWidget(),
    );
    if (result != null) {
      setState(() => _skills.add(result));
      await _saveProfileChanges();
    }
  }

  Future<void> _editSkill(int index) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddSkillWidget(
        initialSkill: _skills[index],
      ),
    );
    if (result != null) {
      setState(() => _skills[index] = result);
      await _saveProfileChanges();
    }
  }

  Future<void> _deleteSkill(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Skill'),
        content: const Text('Are you sure you want to delete this skill?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete')),
        ],
      ),
    );

    if (confirm == true) {
      final skillId = _skills[index]['id'].toString();
      final response = await FreelancerHomePageGroup.deleteSkillCall.call(
        id: skillId,
        authToken: FFAppState().apitoken,
      );
      if (response.succeeded) {
        setState(() {
          _skills.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Skill deleted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete skill')),
        );
      }
    }
  }

  Future<void> _addOccupation() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddOccupationWidget(),
    );
    if (result != null) {
      setState(() => _occupations.add(result));
      await _saveProfileChanges();
    }
  }

  Future<void> _editOccupation(int index) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          AddOccupationWidget(initialOccupation: _occupations[index]),
    );
    if (result != null) {
      setState(() => _occupations[index] = result);
      await _saveProfileChanges();
    }
  }

  Future<void> _deleteOccupation(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Occupation'),
        content: const Text('Are you sure you want to delete this occupation?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete')),
        ],
      ),
    );
    if (confirm == true) {
      final occupationId = _occupations[index]['id'].toString();
      final response = await FreelancerHomePageGroup.deleteOccupationCall.call(
        id: occupationId,
        authToken: FFAppState().apitoken,
      );
      if (response.succeeded) {
        setState(() {
          _occupations.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Occupation deleted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete occupation')),
        );
      }
    }
  }

  Future<void> _saveProfileChanges() async {
    setState(() => _isLoading = true);
    final response = await FreelancerHomePageGroup.updateProfileCall.call(
      authToken: FFAppState().apitoken,
      name: _nameController.text.trim(),
      nickname: _nicknameController.text.trim(),
      countryId: _profileData?['country_id'],
      jobTitle: _jobTitleController.text.trim(),
      about: _aboutController.text.trim(),
      language: _profileData?['language'] ?? 'en',
      skills: _skills,
      occupations: _occupations,
    );
    setState(() => _isLoading = false);
    if (response.succeeded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated!'),
          backgroundColor: Color(0xFF6E2A87),
        ),
      );
      await _fetchProfileData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _profileData == null
          ? const Center(child: Text('No profile data found'))
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 40),
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
                    Navigator.of(context).pop();
                  },
                ),
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontFamily: 'primaryFont',
                    color: Color(0xFF252525),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 36), // For spacing/alignment
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  vertical: 0, horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildAvatarSection(),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _nicknameController,
                      decoration: const InputDecoration(
                        labelText: 'Display Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _aboutController,
                      decoration: const InputDecoration(
                        labelText: 'About',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: _profileData!['country'] ?? '',
                      decoration: const InputDecoration(
                        labelText: 'Country',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                    ),

                    // Only show Job Title field if userType is not "0"
                    if (FFAppState().userType != "0") ...[
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _jobTitleController,
                        decoration: const InputDecoration(
                          labelText: 'Job Title',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],

                    // Only show Occupations section if userType is not "0"
                    if (FFAppState().userType != "0") ...[
                      const SizedBox(height: 20),
                      // Occupations Section
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/briefcase-01.png',
                                    width: 20.0,
                                    height: 20.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text('Your Occupation',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color(0xFF6E2A87),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                elevation: 0,
                              ),
                              onPressed: _addOccupation,
                              child: const Text('Add',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _occupations.length,
                        itemBuilder: (context, index) {
                          final occ = _occupations[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                ),
                                child: ListTile(
                                  title: Text(
                                    occ['category_name'] ??
                                        occ['name'] ??
                                        '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Color(0xFF6E2A87)),
                                        onPressed: () =>
                                            _editOccupation(index),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () =>
                                            _deleteOccupation(index),
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        },
                      ),
                    ],

                    // Only show Skills section if userType is not "0"
                    if (FFAppState().userType != "0") ...[
                      const SizedBox(height: 20),
                      // Skills Section
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/bar-chart-04.png',
                                    width: 20.0,
                                    height: 20.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text('Skills',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color(0xFF6E2A87),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                elevation: 0,
                              ),
                              onPressed: _addSkill,
                              child: const Text('Add',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _skills.length,
                        itemBuilder: (context, index) {
                          final skill = _skills[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(10.0),
                              ),
                              child: ListTile(
                                title: Text(skill['title'] ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                                subtitle: Text(
                                    skill['experience_name'] ??
                                        skill['experience'] ??
                                        '',
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF898989))),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Color(0xFF6E2A87)),
                                      onPressed: () =>
                                          _editSkill(index),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () =>
                                          _deleteSkill(index),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],

                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6E2A87),
                        padding:
                        const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed:
                      _isLoading ? null : _saveProfileChanges,
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}