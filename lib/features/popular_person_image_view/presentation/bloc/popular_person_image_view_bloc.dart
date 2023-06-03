import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tmdb_app/core/utils/enums.dart';
import 'package:tmdb_app/shared/toast.dart';

part 'popular_person_image_view_event.dart';

part 'popular_person_image_view_state.dart';

class PopularPersonImageViewBloc
    extends Bloc<PopularPersonImageViewEvent, PopularPersonImageViewState> {
  PopularPersonImageViewBloc() : super(PopularPersonImageViewState()) {
    on<Prepare>(_prepare);
    on<RequestDownload>(_requestDownload);
  }

  @override
  Future<void> close() {
    _unbindBackgroundIsolate();
    return super.close();
  }

  //dispose
  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  FutureOr<void> _prepare(
      Prepare event, Emitter<PopularPersonImageViewState> emit) async {
    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback, step: 1);

    final permissionReady = await _checkPermission();

    emit(state.copyWith(
      permissionReady: permissionReady,
    ));

    if (state.permissionReady) {
      await _prepareSaveDir();
    }
  }

  void _bindBackgroundIsolate() {
    bool showDownloadSuccess = false;
    final isSuccess = IsolateNameServer.registerPortWithName(
      state.port.sendPort,
      'downloader_send_port',
    );
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    state.port.listen((dynamic data) async {
      final String taskId = (data as List<dynamic>)[0] as String;
      final DownloadTaskStatus status = data[1] as DownloadTaskStatus;
      final int progress = data[2] as int;

      debugPrint(
        'Callback on UI isolate: '
        'task ($taskId) is in status ($status) and process ($progress)',
      );
      if (progress == 0) {
        showToastMessage('Photo Downloading...', Colors.black);
      } else if (progress == 100 && !showDownloadSuccess) {
        showToastMessage('Photo Downloaded Successfully !', Colors.green);
        showDownloadSuccess = true;
      }
    });
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    debugPrint(
      'Callback on background isolate: '
      'task ($id) is in status ($status) and process ($progress)',
    );

    IsolateNameServer.lookupPortByName('downloader_send_port')
        ?.send([id, status, progress]);
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

  Future<void> _prepareSaveDir() async {
    final localPath = (await _findLocalPath())!;
    emit(state.copyWith(localPath: localPath));
    final savedDir = Directory(state.localPath);
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

  FutureOr<void> _requestDownload(
      RequestDownload event, Emitter<PopularPersonImageViewState> emit) async {
    await FlutterDownloader.enqueue(
      url: event.imageUrl,
      headers: {'auth': 'test_for_sql_encoding'},
      savedDir: state.localPath,
      saveInPublicStorage: true,
    );
  }
}
