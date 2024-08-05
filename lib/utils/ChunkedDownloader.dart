import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ChunkedDownloader {
  final String url;
  final String filePath;
  final int chunkSize;

  ChunkedDownloader({
    required this.url,
    required this.filePath,
    this.chunkSize = 1024 * 1024, // 1MB
  });

  Future<void> download() async {
    // final file = File(filePath);

    // final directory = await getApplicationDocumentsDirectory();
    // final filePath = '${directory.path}/file.apk';
    final file = File(filePath);
    final dio = Dio();
    ///先通过请求头获取文件大小
    // final response = await dio.head(url);
    // final totalLength = int.parse(response.headers.value('content-length') ?? '0');

    // 添加 `X-Http-Method-Override: HEAD` 头信息

      final response = await dio.head(url);
    final totalLength = int.parse(response.headers.value('content-length') ?? '0');

    print("输出总块数："+totalLength.toString());

    if (totalLength == 0) {
      throw Exception('Failed to get content length.');
    }

    int downloadedLength = 0;

    // final sink =Stream<List<int>>;// file.openWrite();
    while (downloadedLength < totalLength) {
      final end = (downloadedLength + chunkSize - 1).clamp(0, totalLength - 1);
      final options = Options(
        headers: {
          'Range': 'bytes=$downloadedLength-$end',
        },
        responseType: ResponseType.stream,

      );

      final chunkResponse = await dio.get(
        url,
        options: options,
      );

      if (chunkResponse.statusCode != 206 && chunkResponse.statusCode != 200) {
        throw Exception('Failed to download chunk.');
      }

      // await sink.addStream(chunkResponse.data.stream);
      downloadedLength += end - downloadedLength + 1;
      print("已经下载数:"+downloadedLength.toString());
    }

    // await sink.close();


  }
}