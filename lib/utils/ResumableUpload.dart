import 'package:dio/dio.dart';
import 'dart:io';

class ResumableUpload {
  // final Dio dio;
  final File file;
  // final String uploadUrl;
  ///用于表示传输文件

  final int chunkSize; // in bytes

  ResumableUpload({
    // required this.dio,
    required this.file,
    // required this.uploadUrl,
    this.chunkSize = 1024 * 1024, // 1 MB by default
  });

  Future<void> upload() async {
    int totalChunks = (file.lengthSync() / chunkSize).ceil();
    int uploadedChunks = await getUploadedChunks();

    for (int i = uploadedChunks; i < totalChunks; i++) {
      int start = i * chunkSize;
      int end = start + chunkSize;
      if (end > file.lengthSync()) end = file.lengthSync();
      var chunk = file.openRead(start, end);
      List<int> chunkBytes = await convertStreamToList(chunk);
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromBytes(chunkBytes, filename: 'chunk_$i'),
        'filename': "file.apk",
        'chunkNumber': i,
      });

      try {
        var response = await Dio().post(
          'http://192.168.19.123:8002/upload/chunk',
          data: formData,
        );

        if (response.statusCode == 200) {
          print('Chunk $i uploaded successfully');
          await saveUploadedChunks(i + 1);
        } else {
          print('Failed to upload chunk $i');
          break;
        }
      } catch (e) {
        print('Error uploading chunk $i: $e');
        break;
      }
    }

    // if (await getUploadedChunks() == totalChunks) {
      await Dio().post(
        'http://192.168.19.123:8002/upload/merge',
        data: {'filename': "file", 'totalChunks': totalChunks},
      );
      print('File uploaded successfully');
    // } else {
    //   print('File upload incomplete');
    // }
  }

  Future<int> getUploadedChunks() async {
    // Implement a way to get the number of already uploaded chunks.
    // This could be from local storage or a server query.
    // For simplicity, assuming it's stored locally.
    return 0; // Return the actual number of uploaded chunks.
  }

  Future<void> saveUploadedChunks(int uploadedChunks) async {
    // Implement a way to save the number of uploaded chunks.
    // This could be to local storage or notify the server.
  }

  Future<List<int>> convertStreamToList(Stream<List<int>> stream) async {
    List<int> result = [];
    await for (var chunk in stream) {
      result.addAll(chunk);
    }
    return result;
  }
}