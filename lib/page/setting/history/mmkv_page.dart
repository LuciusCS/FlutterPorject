import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:mmkv/mmkv.dart';

import '../../../common/base/app_dimens.dart';
import '../../../common/services/setting_service.dart';


// import '../../../common/app_dimens.dart';
// import '../../../generated/l10n.dart';
// import '../../../services/setting_service.dart';
// import '../../widgets/appbar/app_bar_widget.dart';

class MMKVPage extends StatefulWidget {
  const MMKVPage({Key? key}) : super(key: key);

  @override
  _MMKVPageState createState() => _MMKVPageState();
}

class _MMKVPageState extends State<MMKVPage> {
  final settingService = Get.find<SettingService>();

  var mmkv = MMKV.defaultMMKV();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MMKV历史记录"),
      ),
      body: Container(
        padding: EdgeInsets.all(AppDimens.paddingNormal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: (){
                String str = 'Hello Flutter from MMKV';
                mmkv.encodeString('string', str);
              },
              child: Container(
                padding: EdgeInsets.only(top: 20,left: 10,bottom: 10,right: 10),
                child: Text("插入 String 数据"),
              ),
            ),

            InkWell(
              onTap: (){
                print('string = ${mmkv.decodeString('string')}');
              },
              child: Container(
                padding: EdgeInsets.only(top: 20,left: 10,bottom: 10,right: 10),
                child: Text("读取 String 数据"),
              ),
            ),

            InkWell(
              onTap: (){
               var str = 'Hello Flutter from MMKV with bytes';
                var bytes = MMBuffer.fromList(Utf8Encoder().convert(str))!;
                mmkv.encodeBytes('bytes', bytes);
                bytes.destroy();
              },
              child: Container(
                padding: EdgeInsets.only(top: 20,left: 10,bottom: 10,right: 10),
                child: Text("插入 MMBuffer 数据"),
              ),
            ),

            InkWell(
              onTap: (){
                var bytes = mmkv.decodeBytes('bytes')!;
                print('bytes = ${Utf8Decoder().convert(bytes.asList()!)}');
                bytes.destroy();
              },
              child: Container(
                padding: EdgeInsets.only(top: 20,left: 10,bottom: 10,right: 10),
                child: Text("读取 MMBuffer 数据"),
              ),
            )
          ],
        ),
      ),
    );
  }





}


/**
 * 1. String 类型
    用途：String 类型常用于存储简单的文本信息，适合保存小的配置数据、简单的文本信息等。例如用户名、标记状态、设置选项等。
    存储方式：当使用 String 存储数据时，MMKV 会直接将文本以键值对的方式存储。String 在读取时不需要解码，因此读取速度相对较快，适合存储短文本。
    优点：简单、方便、存储结构直观，MMKV 读取 String 的性能较高。
    适用场景：适用于保存简单的字符串配置、标记状态等，例如 token、用户名、设置选项等。
    2. MMBuffer 类型
    用途：MMBuffer 是一个用于存储二进制数据的缓冲区，适合用于存储二进制格式的数据，比如图片、文件内容、复杂对象的序列化内容。
    存储方式：MMKV 会将二进制数据直接存储在一个连续的内存区域中，读取时可以直接从内存加载，不需要额外解码。这种方式适合大数据量存储，尤其是对数据读取性能要求较高的场景。
    优点：适合存储大数据量，支持二进制数据，读取效率高，尤其在存储复杂对象或结构体数据时更有优势。
    适用场景：适合存储图片、音视频等大体积文件，或序列化的复杂对象（例如 JSON、Protobuf 等），可以提高读取性能。
 *
 *
 */