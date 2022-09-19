import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tmdb_app/shared/toast.dart';

class PopularPersonImageViewScreen extends StatefulWidget {
  final String? imageUrl;
  const PopularPersonImageViewScreen({Key? key, this.imageUrl}) : super(key: key);

  @override
  State<PopularPersonImageViewScreen> createState() => _PopularPersonImageViewScreenState();
}

class _PopularPersonImageViewScreenState extends State<PopularPersonImageViewScreen> {
  late bool _permissionReady;
  late String _localPath;
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback, step: 1);
    _permissionReady = false;

    _prepare();
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  _prepare() async {
    _permissionReady = await _checkPermission();

    if (_permissionReady) {
      await _prepareSaveDir();
    }
  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _requestDownload(String url) async {
    await FlutterDownloader.enqueue(
      url: url,
      headers: {'auth': 'test_for_sql_encoding'},
      savedDir: _localPath,
      saveInPublicStorage: true,
    );
  }

  void _bindBackgroundIsolate() {
    bool showDownloadSuccess = false;
    final isSuccess = IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      final taskId = (data as List<dynamic>)[0] as String;
      final status = data[1] as DownloadTaskStatus;
      final progress = data[2] as int;

      debugPrint(
        'Callback on UI isolate: '
        'task ($taskId) is in status ($status) and process ($progress)',
      );

      if (progress == 0) {
        showToastMessage('Photo Downloading...',Colors.black);
      } else if (progress == 100 && !showDownloadSuccess) {
        showToastMessage('Photo Downloaded Successfully !',Colors.green);
        showDownloadSuccess = true;
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id, DownloadTaskStatus status, int progress) {
    debugPrint(
      'Callback on background isolate: '
      'task ($id) is in status ($status) and process ($progress)',
    );

    IsolateNameServer.lookupPortByName('downloader_send_port')
        ?.send([id, status, progress]);
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    final hasExisted = savedDir.existsSync();
    if (!hasExisted) {
      await savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      externalStorageDirPath = directory?.path;
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _requestDownload("${widget.imageUrl}"),
            icon: const Icon(Icons.download),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: CachedNetworkImage(
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          imageUrl: "${widget.imageUrl}",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
