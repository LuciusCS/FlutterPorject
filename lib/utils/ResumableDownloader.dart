import 'dart:io';
import 'package:dio/dio.dart';

class ResumableDownloader {
  final Dio _dio = Dio();
  final String fileUrl;
  final String savePath;

  ResumableDownloader({required this.fileUrl, required this.savePath});

  Future<void> download() async {
    File file = File(savePath);
    int start = 0;

    if (await file.exists()) {
      start = await file.length();
    }

    try {
      Response response = await _dio.get(
        fileUrl,
        options: Options(
          headers: {'Range': 'bytes=$start-'},
          responseType: ResponseType.stream,
        ),
      );

      RandomAccessFile raf = file.openSync(mode: FileMode.append);
      await response.data.stream.pipe(raf);
      await raf.close();

      print('Download completed');
    } catch (e) {
      print('Download failed: $e');
    }
  }
}
