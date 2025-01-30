import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lawadvisor/UI_helper/chat_message.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  dynamic _selectedImage;  // Can be File or html.File
  String? _selectedImagePreview;
//for app
  final String apiUrl = "http://192.168.200.92:8000/api/process_query/";
//for web
// final String apiUrl = "http://localhost:8000/api/process_query/";

  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty || _selectedImage != null) {
      setState(() {
        if (_selectedImage != null) {
          _messages.add(ChatMessage(
            text: 'Uploaded image',
            isUser: true,
            isImage: true,
            imageUrl: _selectedImagePreview,
          ));
        }
        if (_messageController.text.isNotEmpty) {
          _messages.add(ChatMessage(
            text: _messageController.text,
            isUser: true,
          ));
        }
      });

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.fields['query'] = _messageController.text;

      if (_selectedImage != null) {
        if (kIsWeb) {
          var reader = html.FileReader();
          reader.readAsArrayBuffer(_selectedImage as html.File);
          await reader.onLoad.first;
          request.files.add(http.MultipartFile.fromBytes(
            'file',
            reader.result as List<int>,
            filename: (_selectedImage as html.File).name,
          ));
        } else {
          var file = _selectedImage as File;
          request.files.add(await http.MultipartFile.fromPath('file', file.path));
        }
      }

      try {
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          setState(() {
            _messages.add(ChatMessage(
              text: jsonResponse['response'],
              isUser: false,
            ));
          });
        } else {
          throw Exception('Failed to get response from server');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }

      _messageController.clear();
      setState(() {
        _selectedImage = null;
        _selectedImagePreview = null;
      });
      _scrollToBottom();
    }
  }

  Future<void> _pickImage() async {
    if (kIsWeb) {
      final input = html.FileUploadInputElement()..accept = 'image/*';
      input.click();

      await input.onChange.first;
      if (input.files!.isNotEmpty) {
        final file = input.files![0];
        final reader = html.FileReader();
        reader.readAsDataUrl(file);
        await reader.onLoad.first;
        setState(() {
          _selectedImage = file;
          _selectedImagePreview = reader.result as String;
        });
      }
    } else {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _selectedImagePreview = image.path;
        });
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/appbarlawadv.png',
          height: 180,
          width: 200,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          if (_selectedImagePreview != null)
            Container(
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Center(
                    child: kIsWeb
                        ? Image.network(_selectedImagePreview!, height: 80)
                        : Image.file(File(_selectedImagePreview!), height: 80),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _selectedImage = null;
                          _selectedImagePreview = null;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(31, 44, 52, 1),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file, color: Colors.white),
                  onPressed: _pickImage,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: (){
                      _sendMessage();
                      setState(() {
                        _messageController.text = "";
                      });
                    }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

