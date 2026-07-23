// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MediaAssetsTable extends MediaAssets
    with TableInfo<$MediaAssetsTable, MediaAsset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaAssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _platformIdMeta =
      const VerificationMeta('platformId');
  @override
  late final GeneratedColumn<String> platformId = GeneratedColumn<String>(
      'platform_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _fileNameMeta =
      const VerificationMeta('fileName');
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
      'file_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mediaKindMeta =
      const VerificationMeta('mediaKind');
  @override
  late final GeneratedColumn<String> mediaKind = GeneratedColumn<String>(
      'media_kind', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _addedAtMeta =
      const VerificationMeta('addedAt');
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
      'added_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
      'width', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
      'height', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sizeBytesMeta =
      const VerificationMeta('sizeBytes');
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
      'size_bytes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _folderNameMeta =
      const VerificationMeta('folderName');
  @override
  late final GeneratedColumn<String> folderName = GeneratedColumn<String>(
      'folder_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cameraMakeMeta =
      const VerificationMeta('cameraMake');
  @override
  late final GeneratedColumn<String> cameraMake = GeneratedColumn<String>(
      'camera_make', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cameraModelMeta =
      const VerificationMeta('cameraModel');
  @override
  late final GeneratedColumn<String> cameraModel = GeneratedColumn<String>(
      'camera_model', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _placeNameMeta =
      const VerificationMeta('placeName');
  @override
  late final GeneratedColumn<String> placeName = GeneratedColumn<String>(
      'place_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isHiddenMeta =
      const VerificationMeta('isHidden');
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
      'is_hidden', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_hidden" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _statusesCsvMeta =
      const VerificationMeta('statusesCsv');
  @override
  late final GeneratedColumn<String> statusesCsv = GeneratedColumn<String>(
      'statuses_csv', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('local'));
  static const VerificationMeta _contentHashMeta =
      const VerificationMeta('contentHash');
  @override
  late final GeneratedColumn<String> contentHash = GeneratedColumn<String>(
      'content_hash', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        platformId,
        fileName,
        mediaKind,
        createdAt,
        addedAt,
        width,
        height,
        sizeBytes,
        folderName,
        cameraMake,
        cameraModel,
        latitude,
        longitude,
        placeName,
        isFavorite,
        isHidden,
        isDeleted,
        statusesCsv,
        contentHash,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_assets';
  @override
  VerificationContext validateIntegrity(Insertable<MediaAsset> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('platform_id')) {
      context.handle(
          _platformIdMeta,
          platformId.isAcceptableOrUnknown(
              data['platform_id']!, _platformIdMeta));
    } else if (isInserting) {
      context.missing(_platformIdMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta));
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('media_kind')) {
      context.handle(_mediaKindMeta,
          mediaKind.isAcceptableOrUnknown(data['media_kind']!, _mediaKindMeta));
    } else if (isInserting) {
      context.missing(_mediaKindMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(_addedAtMeta,
          addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta));
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    } else if (isInserting) {
      context.missing(_widthMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(_sizeBytesMeta,
          sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta));
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('folder_name')) {
      context.handle(
          _folderNameMeta,
          folderName.isAcceptableOrUnknown(
              data['folder_name']!, _folderNameMeta));
    }
    if (data.containsKey('camera_make')) {
      context.handle(
          _cameraMakeMeta,
          cameraMake.isAcceptableOrUnknown(
              data['camera_make']!, _cameraMakeMeta));
    }
    if (data.containsKey('camera_model')) {
      context.handle(
          _cameraModelMeta,
          cameraModel.isAcceptableOrUnknown(
              data['camera_model']!, _cameraModelMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('place_name')) {
      context.handle(_placeNameMeta,
          placeName.isAcceptableOrUnknown(data['place_name']!, _placeNameMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('is_hidden')) {
      context.handle(_isHiddenMeta,
          isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('statuses_csv')) {
      context.handle(
          _statusesCsvMeta,
          statusesCsv.isAcceptableOrUnknown(
              data['statuses_csv']!, _statusesCsvMeta));
    }
    if (data.containsKey('content_hash')) {
      context.handle(
          _contentHashMeta,
          contentHash.isAcceptableOrUnknown(
              data['content_hash']!, _contentHashMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaAsset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaAsset(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      platformId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}platform_id'])!,
      fileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_name'])!,
      mediaKind: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_kind'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      addedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_at'])!,
      width: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}width'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}height'])!,
      sizeBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size_bytes'])!,
      folderName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}folder_name']),
      cameraMake: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}camera_make']),
      cameraModel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}camera_model']),
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude']),
      placeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}place_name']),
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      isHidden: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_hidden'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      statusesCsv: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}statuses_csv'])!,
      contentHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_hash']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $MediaAssetsTable createAlias(String alias) {
    return $MediaAssetsTable(attachedDatabase, alias);
  }
}

class MediaAsset extends DataClass implements Insertable<MediaAsset> {
  final String id;
  final String platformId;
  final String fileName;
  final String mediaKind;
  final DateTime createdAt;
  final DateTime addedAt;
  final int width;
  final int height;
  final int sizeBytes;
  final String? folderName;
  final String? cameraMake;
  final String? cameraModel;
  final double? latitude;
  final double? longitude;
  final String? placeName;
  final bool isFavorite;
  final bool isHidden;
  final bool isDeleted;
  final String statusesCsv;
  final String? contentHash;
  final DateTime updatedAt;
  const MediaAsset(
      {required this.id,
      required this.platformId,
      required this.fileName,
      required this.mediaKind,
      required this.createdAt,
      required this.addedAt,
      required this.width,
      required this.height,
      required this.sizeBytes,
      this.folderName,
      this.cameraMake,
      this.cameraModel,
      this.latitude,
      this.longitude,
      this.placeName,
      required this.isFavorite,
      required this.isHidden,
      required this.isDeleted,
      required this.statusesCsv,
      this.contentHash,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['platform_id'] = Variable<String>(platformId);
    map['file_name'] = Variable<String>(fileName);
    map['media_kind'] = Variable<String>(mediaKind);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['added_at'] = Variable<DateTime>(addedAt);
    map['width'] = Variable<int>(width);
    map['height'] = Variable<int>(height);
    map['size_bytes'] = Variable<int>(sizeBytes);
    if (!nullToAbsent || folderName != null) {
      map['folder_name'] = Variable<String>(folderName);
    }
    if (!nullToAbsent || cameraMake != null) {
      map['camera_make'] = Variable<String>(cameraMake);
    }
    if (!nullToAbsent || cameraModel != null) {
      map['camera_model'] = Variable<String>(cameraModel);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || placeName != null) {
      map['place_name'] = Variable<String>(placeName);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_hidden'] = Variable<bool>(isHidden);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['statuses_csv'] = Variable<String>(statusesCsv);
    if (!nullToAbsent || contentHash != null) {
      map['content_hash'] = Variable<String>(contentHash);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MediaAssetsCompanion toCompanion(bool nullToAbsent) {
    return MediaAssetsCompanion(
      id: Value(id),
      platformId: Value(platformId),
      fileName: Value(fileName),
      mediaKind: Value(mediaKind),
      createdAt: Value(createdAt),
      addedAt: Value(addedAt),
      width: Value(width),
      height: Value(height),
      sizeBytes: Value(sizeBytes),
      folderName: folderName == null && nullToAbsent
          ? const Value.absent()
          : Value(folderName),
      cameraMake: cameraMake == null && nullToAbsent
          ? const Value.absent()
          : Value(cameraMake),
      cameraModel: cameraModel == null && nullToAbsent
          ? const Value.absent()
          : Value(cameraModel),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      placeName: placeName == null && nullToAbsent
          ? const Value.absent()
          : Value(placeName),
      isFavorite: Value(isFavorite),
      isHidden: Value(isHidden),
      isDeleted: Value(isDeleted),
      statusesCsv: Value(statusesCsv),
      contentHash: contentHash == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHash),
      updatedAt: Value(updatedAt),
    );
  }

  factory MediaAsset.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaAsset(
      id: serializer.fromJson<String>(json['id']),
      platformId: serializer.fromJson<String>(json['platformId']),
      fileName: serializer.fromJson<String>(json['fileName']),
      mediaKind: serializer.fromJson<String>(json['mediaKind']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
      width: serializer.fromJson<int>(json['width']),
      height: serializer.fromJson<int>(json['height']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      folderName: serializer.fromJson<String?>(json['folderName']),
      cameraMake: serializer.fromJson<String?>(json['cameraMake']),
      cameraModel: serializer.fromJson<String?>(json['cameraModel']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      placeName: serializer.fromJson<String?>(json['placeName']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      statusesCsv: serializer.fromJson<String>(json['statusesCsv']),
      contentHash: serializer.fromJson<String?>(json['contentHash']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'platformId': serializer.toJson<String>(platformId),
      'fileName': serializer.toJson<String>(fileName),
      'mediaKind': serializer.toJson<String>(mediaKind),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'addedAt': serializer.toJson<DateTime>(addedAt),
      'width': serializer.toJson<int>(width),
      'height': serializer.toJson<int>(height),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'folderName': serializer.toJson<String?>(folderName),
      'cameraMake': serializer.toJson<String?>(cameraMake),
      'cameraModel': serializer.toJson<String?>(cameraModel),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'placeName': serializer.toJson<String?>(placeName),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isHidden': serializer.toJson<bool>(isHidden),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'statusesCsv': serializer.toJson<String>(statusesCsv),
      'contentHash': serializer.toJson<String?>(contentHash),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MediaAsset copyWith(
          {String? id,
          String? platformId,
          String? fileName,
          String? mediaKind,
          DateTime? createdAt,
          DateTime? addedAt,
          int? width,
          int? height,
          int? sizeBytes,
          Value<String?> folderName = const Value.absent(),
          Value<String?> cameraMake = const Value.absent(),
          Value<String?> cameraModel = const Value.absent(),
          Value<double?> latitude = const Value.absent(),
          Value<double?> longitude = const Value.absent(),
          Value<String?> placeName = const Value.absent(),
          bool? isFavorite,
          bool? isHidden,
          bool? isDeleted,
          String? statusesCsv,
          Value<String?> contentHash = const Value.absent(),
          DateTime? updatedAt}) =>
      MediaAsset(
        id: id ?? this.id,
        platformId: platformId ?? this.platformId,
        fileName: fileName ?? this.fileName,
        mediaKind: mediaKind ?? this.mediaKind,
        createdAt: createdAt ?? this.createdAt,
        addedAt: addedAt ?? this.addedAt,
        width: width ?? this.width,
        height: height ?? this.height,
        sizeBytes: sizeBytes ?? this.sizeBytes,
        folderName: folderName.present ? folderName.value : this.folderName,
        cameraMake: cameraMake.present ? cameraMake.value : this.cameraMake,
        cameraModel: cameraModel.present ? cameraModel.value : this.cameraModel,
        latitude: latitude.present ? latitude.value : this.latitude,
        longitude: longitude.present ? longitude.value : this.longitude,
        placeName: placeName.present ? placeName.value : this.placeName,
        isFavorite: isFavorite ?? this.isFavorite,
        isHidden: isHidden ?? this.isHidden,
        isDeleted: isDeleted ?? this.isDeleted,
        statusesCsv: statusesCsv ?? this.statusesCsv,
        contentHash: contentHash.present ? contentHash.value : this.contentHash,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  MediaAsset copyWithCompanion(MediaAssetsCompanion data) {
    return MediaAsset(
      id: data.id.present ? data.id.value : this.id,
      platformId:
          data.platformId.present ? data.platformId.value : this.platformId,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      mediaKind: data.mediaKind.present ? data.mediaKind.value : this.mediaKind,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      folderName:
          data.folderName.present ? data.folderName.value : this.folderName,
      cameraMake:
          data.cameraMake.present ? data.cameraMake.value : this.cameraMake,
      cameraModel:
          data.cameraModel.present ? data.cameraModel.value : this.cameraModel,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      placeName: data.placeName.present ? data.placeName.value : this.placeName,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      statusesCsv:
          data.statusesCsv.present ? data.statusesCsv.value : this.statusesCsv,
      contentHash:
          data.contentHash.present ? data.contentHash.value : this.contentHash,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaAsset(')
          ..write('id: $id, ')
          ..write('platformId: $platformId, ')
          ..write('fileName: $fileName, ')
          ..write('mediaKind: $mediaKind, ')
          ..write('createdAt: $createdAt, ')
          ..write('addedAt: $addedAt, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('folderName: $folderName, ')
          ..write('cameraMake: $cameraMake, ')
          ..write('cameraModel: $cameraModel, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('placeName: $placeName, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isHidden: $isHidden, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('statusesCsv: $statusesCsv, ')
          ..write('contentHash: $contentHash, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        platformId,
        fileName,
        mediaKind,
        createdAt,
        addedAt,
        width,
        height,
        sizeBytes,
        folderName,
        cameraMake,
        cameraModel,
        latitude,
        longitude,
        placeName,
        isFavorite,
        isHidden,
        isDeleted,
        statusesCsv,
        contentHash,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaAsset &&
          other.id == this.id &&
          other.platformId == this.platformId &&
          other.fileName == this.fileName &&
          other.mediaKind == this.mediaKind &&
          other.createdAt == this.createdAt &&
          other.addedAt == this.addedAt &&
          other.width == this.width &&
          other.height == this.height &&
          other.sizeBytes == this.sizeBytes &&
          other.folderName == this.folderName &&
          other.cameraMake == this.cameraMake &&
          other.cameraModel == this.cameraModel &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.placeName == this.placeName &&
          other.isFavorite == this.isFavorite &&
          other.isHidden == this.isHidden &&
          other.isDeleted == this.isDeleted &&
          other.statusesCsv == this.statusesCsv &&
          other.contentHash == this.contentHash &&
          other.updatedAt == this.updatedAt);
}

class MediaAssetsCompanion extends UpdateCompanion<MediaAsset> {
  final Value<String> id;
  final Value<String> platformId;
  final Value<String> fileName;
  final Value<String> mediaKind;
  final Value<DateTime> createdAt;
  final Value<DateTime> addedAt;
  final Value<int> width;
  final Value<int> height;
  final Value<int> sizeBytes;
  final Value<String?> folderName;
  final Value<String?> cameraMake;
  final Value<String?> cameraModel;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> placeName;
  final Value<bool> isFavorite;
  final Value<bool> isHidden;
  final Value<bool> isDeleted;
  final Value<String> statusesCsv;
  final Value<String?> contentHash;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MediaAssetsCompanion({
    this.id = const Value.absent(),
    this.platformId = const Value.absent(),
    this.fileName = const Value.absent(),
    this.mediaKind = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.folderName = const Value.absent(),
    this.cameraMake = const Value.absent(),
    this.cameraModel = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.placeName = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.statusesCsv = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MediaAssetsCompanion.insert({
    required String id,
    required String platformId,
    required String fileName,
    required String mediaKind,
    required DateTime createdAt,
    required DateTime addedAt,
    required int width,
    required int height,
    required int sizeBytes,
    this.folderName = const Value.absent(),
    this.cameraMake = const Value.absent(),
    this.cameraModel = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.placeName = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.statusesCsv = const Value.absent(),
    this.contentHash = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        platformId = Value(platformId),
        fileName = Value(fileName),
        mediaKind = Value(mediaKind),
        createdAt = Value(createdAt),
        addedAt = Value(addedAt),
        width = Value(width),
        height = Value(height),
        sizeBytes = Value(sizeBytes),
        updatedAt = Value(updatedAt);
  static Insertable<MediaAsset> custom({
    Expression<String>? id,
    Expression<String>? platformId,
    Expression<String>? fileName,
    Expression<String>? mediaKind,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? addedAt,
    Expression<int>? width,
    Expression<int>? height,
    Expression<int>? sizeBytes,
    Expression<String>? folderName,
    Expression<String>? cameraMake,
    Expression<String>? cameraModel,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? placeName,
    Expression<bool>? isFavorite,
    Expression<bool>? isHidden,
    Expression<bool>? isDeleted,
    Expression<String>? statusesCsv,
    Expression<String>? contentHash,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (platformId != null) 'platform_id': platformId,
      if (fileName != null) 'file_name': fileName,
      if (mediaKind != null) 'media_kind': mediaKind,
      if (createdAt != null) 'created_at': createdAt,
      if (addedAt != null) 'added_at': addedAt,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (folderName != null) 'folder_name': folderName,
      if (cameraMake != null) 'camera_make': cameraMake,
      if (cameraModel != null) 'camera_model': cameraModel,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (placeName != null) 'place_name': placeName,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isHidden != null) 'is_hidden': isHidden,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (statusesCsv != null) 'statuses_csv': statusesCsv,
      if (contentHash != null) 'content_hash': contentHash,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MediaAssetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? platformId,
      Value<String>? fileName,
      Value<String>? mediaKind,
      Value<DateTime>? createdAt,
      Value<DateTime>? addedAt,
      Value<int>? width,
      Value<int>? height,
      Value<int>? sizeBytes,
      Value<String?>? folderName,
      Value<String?>? cameraMake,
      Value<String?>? cameraModel,
      Value<double?>? latitude,
      Value<double?>? longitude,
      Value<String?>? placeName,
      Value<bool>? isFavorite,
      Value<bool>? isHidden,
      Value<bool>? isDeleted,
      Value<String>? statusesCsv,
      Value<String?>? contentHash,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return MediaAssetsCompanion(
      id: id ?? this.id,
      platformId: platformId ?? this.platformId,
      fileName: fileName ?? this.fileName,
      mediaKind: mediaKind ?? this.mediaKind,
      createdAt: createdAt ?? this.createdAt,
      addedAt: addedAt ?? this.addedAt,
      width: width ?? this.width,
      height: height ?? this.height,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      folderName: folderName ?? this.folderName,
      cameraMake: cameraMake ?? this.cameraMake,
      cameraModel: cameraModel ?? this.cameraModel,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      placeName: placeName ?? this.placeName,
      isFavorite: isFavorite ?? this.isFavorite,
      isHidden: isHidden ?? this.isHidden,
      isDeleted: isDeleted ?? this.isDeleted,
      statusesCsv: statusesCsv ?? this.statusesCsv,
      contentHash: contentHash ?? this.contentHash,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (platformId.present) {
      map['platform_id'] = Variable<String>(platformId.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (mediaKind.present) {
      map['media_kind'] = Variable<String>(mediaKind.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (folderName.present) {
      map['folder_name'] = Variable<String>(folderName.value);
    }
    if (cameraMake.present) {
      map['camera_make'] = Variable<String>(cameraMake.value);
    }
    if (cameraModel.present) {
      map['camera_model'] = Variable<String>(cameraModel.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (placeName.present) {
      map['place_name'] = Variable<String>(placeName.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (statusesCsv.present) {
      map['statuses_csv'] = Variable<String>(statusesCsv.value);
    }
    if (contentHash.present) {
      map['content_hash'] = Variable<String>(contentHash.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaAssetsCompanion(')
          ..write('id: $id, ')
          ..write('platformId: $platformId, ')
          ..write('fileName: $fileName, ')
          ..write('mediaKind: $mediaKind, ')
          ..write('createdAt: $createdAt, ')
          ..write('addedAt: $addedAt, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('folderName: $folderName, ')
          ..write('cameraMake: $cameraMake, ')
          ..write('cameraModel: $cameraModel, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('placeName: $placeName, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isHidden: $isHidden, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('statusesCsv: $statusesCsv, ')
          ..write('contentHash: $contentHash, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlbumsTable extends Albums with TableInfo<$AlbumsTable, Album> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlbumsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceFolderMeta =
      const VerificationMeta('sourceFolder');
  @override
  late final GeneratedColumn<String> sourceFolder = GeneratedColumn<String>(
      'source_folder', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _coverAssetIdMeta =
      const VerificationMeta('coverAssetId');
  @override
  late final GeneratedColumn<String> coverAssetId = GeneratedColumn<String>(
      'cover_asset_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isAutoMeta = const VerificationMeta('isAuto');
  @override
  late final GeneratedColumn<bool> isAuto = GeneratedColumn<bool>(
      'is_auto', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_auto" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, sourceFolder, coverAssetId, isAuto, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'albums';
  @override
  VerificationContext validateIntegrity(Insertable<Album> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('source_folder')) {
      context.handle(
          _sourceFolderMeta,
          sourceFolder.isAcceptableOrUnknown(
              data['source_folder']!, _sourceFolderMeta));
    }
    if (data.containsKey('cover_asset_id')) {
      context.handle(
          _coverAssetIdMeta,
          coverAssetId.isAcceptableOrUnknown(
              data['cover_asset_id']!, _coverAssetIdMeta));
    }
    if (data.containsKey('is_auto')) {
      context.handle(_isAutoMeta,
          isAuto.isAcceptableOrUnknown(data['is_auto']!, _isAutoMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Album map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Album(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      sourceFolder: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_folder']),
      coverAssetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover_asset_id']),
      isAuto: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_auto'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AlbumsTable createAlias(String alias) {
    return $AlbumsTable(attachedDatabase, alias);
  }
}

class Album extends DataClass implements Insertable<Album> {
  final String id;
  final String title;
  final String? sourceFolder;
  final String? coverAssetId;
  final bool isAuto;
  final DateTime updatedAt;
  const Album(
      {required this.id,
      required this.title,
      this.sourceFolder,
      this.coverAssetId,
      required this.isAuto,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || sourceFolder != null) {
      map['source_folder'] = Variable<String>(sourceFolder);
    }
    if (!nullToAbsent || coverAssetId != null) {
      map['cover_asset_id'] = Variable<String>(coverAssetId);
    }
    map['is_auto'] = Variable<bool>(isAuto);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AlbumsCompanion toCompanion(bool nullToAbsent) {
    return AlbumsCompanion(
      id: Value(id),
      title: Value(title),
      sourceFolder: sourceFolder == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceFolder),
      coverAssetId: coverAssetId == null && nullToAbsent
          ? const Value.absent()
          : Value(coverAssetId),
      isAuto: Value(isAuto),
      updatedAt: Value(updatedAt),
    );
  }

  factory Album.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Album(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      sourceFolder: serializer.fromJson<String?>(json['sourceFolder']),
      coverAssetId: serializer.fromJson<String?>(json['coverAssetId']),
      isAuto: serializer.fromJson<bool>(json['isAuto']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'sourceFolder': serializer.toJson<String?>(sourceFolder),
      'coverAssetId': serializer.toJson<String?>(coverAssetId),
      'isAuto': serializer.toJson<bool>(isAuto),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Album copyWith(
          {String? id,
          String? title,
          Value<String?> sourceFolder = const Value.absent(),
          Value<String?> coverAssetId = const Value.absent(),
          bool? isAuto,
          DateTime? updatedAt}) =>
      Album(
        id: id ?? this.id,
        title: title ?? this.title,
        sourceFolder:
            sourceFolder.present ? sourceFolder.value : this.sourceFolder,
        coverAssetId:
            coverAssetId.present ? coverAssetId.value : this.coverAssetId,
        isAuto: isAuto ?? this.isAuto,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Album copyWithCompanion(AlbumsCompanion data) {
    return Album(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      sourceFolder: data.sourceFolder.present
          ? data.sourceFolder.value
          : this.sourceFolder,
      coverAssetId: data.coverAssetId.present
          ? data.coverAssetId.value
          : this.coverAssetId,
      isAuto: data.isAuto.present ? data.isAuto.value : this.isAuto,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Album(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('sourceFolder: $sourceFolder, ')
          ..write('coverAssetId: $coverAssetId, ')
          ..write('isAuto: $isAuto, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, sourceFolder, coverAssetId, isAuto, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Album &&
          other.id == this.id &&
          other.title == this.title &&
          other.sourceFolder == this.sourceFolder &&
          other.coverAssetId == this.coverAssetId &&
          other.isAuto == this.isAuto &&
          other.updatedAt == this.updatedAt);
}

class AlbumsCompanion extends UpdateCompanion<Album> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> sourceFolder;
  final Value<String?> coverAssetId;
  final Value<bool> isAuto;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AlbumsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.sourceFolder = const Value.absent(),
    this.coverAssetId = const Value.absent(),
    this.isAuto = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlbumsCompanion.insert({
    required String id,
    required String title,
    this.sourceFolder = const Value.absent(),
    this.coverAssetId = const Value.absent(),
    this.isAuto = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        updatedAt = Value(updatedAt);
  static Insertable<Album> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? sourceFolder,
    Expression<String>? coverAssetId,
    Expression<bool>? isAuto,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (sourceFolder != null) 'source_folder': sourceFolder,
      if (coverAssetId != null) 'cover_asset_id': coverAssetId,
      if (isAuto != null) 'is_auto': isAuto,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlbumsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? sourceFolder,
      Value<String?>? coverAssetId,
      Value<bool>? isAuto,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return AlbumsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      sourceFolder: sourceFolder ?? this.sourceFolder,
      coverAssetId: coverAssetId ?? this.coverAssetId,
      isAuto: isAuto ?? this.isAuto,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (sourceFolder.present) {
      map['source_folder'] = Variable<String>(sourceFolder.value);
    }
    if (coverAssetId.present) {
      map['cover_asset_id'] = Variable<String>(coverAssetId.value);
    }
    if (isAuto.present) {
      map['is_auto'] = Variable<bool>(isAuto.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('sourceFolder: $sourceFolder, ')
          ..write('coverAssetId: $coverAssetId, ')
          ..write('isAuto: $isAuto, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlbumAssetsTable extends AlbumAssets
    with TableInfo<$AlbumAssetsTable, AlbumAsset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlbumAssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _albumIdMeta =
      const VerificationMeta('albumId');
  @override
  late final GeneratedColumn<String> albumId = GeneratedColumn<String>(
      'album_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assetIdMeta =
      const VerificationMeta('assetId');
  @override
  late final GeneratedColumn<String> assetId = GeneratedColumn<String>(
      'asset_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _addedAtMeta =
      const VerificationMeta('addedAt');
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
      'added_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [albumId, assetId, sortOrder, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'album_assets';
  @override
  VerificationContext validateIntegrity(Insertable<AlbumAsset> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('album_id')) {
      context.handle(_albumIdMeta,
          albumId.isAcceptableOrUnknown(data['album_id']!, _albumIdMeta));
    } else if (isInserting) {
      context.missing(_albumIdMeta);
    }
    if (data.containsKey('asset_id')) {
      context.handle(_assetIdMeta,
          assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta));
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('added_at')) {
      context.handle(_addedAtMeta,
          addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta));
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {albumId, assetId};
  @override
  AlbumAsset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlbumAsset(
      albumId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album_id'])!,
      assetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}asset_id'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      addedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_at'])!,
    );
  }

  @override
  $AlbumAssetsTable createAlias(String alias) {
    return $AlbumAssetsTable(attachedDatabase, alias);
  }
}

class AlbumAsset extends DataClass implements Insertable<AlbumAsset> {
  final String albumId;
  final String assetId;
  final int sortOrder;
  final DateTime addedAt;
  const AlbumAsset(
      {required this.albumId,
      required this.assetId,
      required this.sortOrder,
      required this.addedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['album_id'] = Variable<String>(albumId);
    map['asset_id'] = Variable<String>(assetId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  AlbumAssetsCompanion toCompanion(bool nullToAbsent) {
    return AlbumAssetsCompanion(
      albumId: Value(albumId),
      assetId: Value(assetId),
      sortOrder: Value(sortOrder),
      addedAt: Value(addedAt),
    );
  }

  factory AlbumAsset.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlbumAsset(
      albumId: serializer.fromJson<String>(json['albumId']),
      assetId: serializer.fromJson<String>(json['assetId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'albumId': serializer.toJson<String>(albumId),
      'assetId': serializer.toJson<String>(assetId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  AlbumAsset copyWith(
          {String? albumId,
          String? assetId,
          int? sortOrder,
          DateTime? addedAt}) =>
      AlbumAsset(
        albumId: albumId ?? this.albumId,
        assetId: assetId ?? this.assetId,
        sortOrder: sortOrder ?? this.sortOrder,
        addedAt: addedAt ?? this.addedAt,
      );
  AlbumAsset copyWithCompanion(AlbumAssetsCompanion data) {
    return AlbumAsset(
      albumId: data.albumId.present ? data.albumId.value : this.albumId,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlbumAsset(')
          ..write('albumId: $albumId, ')
          ..write('assetId: $assetId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(albumId, assetId, sortOrder, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlbumAsset &&
          other.albumId == this.albumId &&
          other.assetId == this.assetId &&
          other.sortOrder == this.sortOrder &&
          other.addedAt == this.addedAt);
}

class AlbumAssetsCompanion extends UpdateCompanion<AlbumAsset> {
  final Value<String> albumId;
  final Value<String> assetId;
  final Value<int> sortOrder;
  final Value<DateTime> addedAt;
  final Value<int> rowid;
  const AlbumAssetsCompanion({
    this.albumId = const Value.absent(),
    this.assetId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlbumAssetsCompanion.insert({
    required String albumId,
    required String assetId,
    this.sortOrder = const Value.absent(),
    required DateTime addedAt,
    this.rowid = const Value.absent(),
  })  : albumId = Value(albumId),
        assetId = Value(assetId),
        addedAt = Value(addedAt);
  static Insertable<AlbumAsset> custom({
    Expression<String>? albumId,
    Expression<String>? assetId,
    Expression<int>? sortOrder,
    Expression<DateTime>? addedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (albumId != null) 'album_id': albumId,
      if (assetId != null) 'asset_id': assetId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (addedAt != null) 'added_at': addedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlbumAssetsCompanion copyWith(
      {Value<String>? albumId,
      Value<String>? assetId,
      Value<int>? sortOrder,
      Value<DateTime>? addedAt,
      Value<int>? rowid}) {
    return AlbumAssetsCompanion(
      albumId: albumId ?? this.albumId,
      assetId: assetId ?? this.assetId,
      sortOrder: sortOrder ?? this.sortOrder,
      addedAt: addedAt ?? this.addedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (albumId.present) {
      map['album_id'] = Variable<String>(albumId.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<String>(assetId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumAssetsCompanion(')
          ..write('albumId: $albumId, ')
          ..write('assetId: $assetId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('addedAt: $addedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimelineBucketsTable extends TimelineBuckets
    with TableInfo<$TimelineBucketsTable, TimelineBucket> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimelineBucketsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startAtMeta =
      const VerificationMeta('startAt');
  @override
  late final GeneratedColumn<DateTime> startAt = GeneratedColumn<DateTime>(
      'start_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<DateTime> endAt = GeneratedColumn<DateTime>(
      'end_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _assetCountMeta =
      const VerificationMeta('assetCount');
  @override
  late final GeneratedColumn<int> assetCount = GeneratedColumn<int>(
      'asset_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, title, startAt, endAt, assetCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timeline_buckets';
  @override
  VerificationContext validateIntegrity(Insertable<TimelineBucket> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('start_at')) {
      context.handle(_startAtMeta,
          startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta));
    } else if (isInserting) {
      context.missing(_startAtMeta);
    }
    if (data.containsKey('end_at')) {
      context.handle(
          _endAtMeta, endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta));
    } else if (isInserting) {
      context.missing(_endAtMeta);
    }
    if (data.containsKey('asset_count')) {
      context.handle(
          _assetCountMeta,
          assetCount.isAcceptableOrUnknown(
              data['asset_count']!, _assetCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimelineBucket map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimelineBucket(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      startAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_at'])!,
      endAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_at'])!,
      assetCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}asset_count'])!,
    );
  }

  @override
  $TimelineBucketsTable createAlias(String alias) {
    return $TimelineBucketsTable(attachedDatabase, alias);
  }
}

class TimelineBucket extends DataClass implements Insertable<TimelineBucket> {
  final String id;
  final String title;
  final DateTime startAt;
  final DateTime endAt;
  final int assetCount;
  const TimelineBucket(
      {required this.id,
      required this.title,
      required this.startAt,
      required this.endAt,
      required this.assetCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['start_at'] = Variable<DateTime>(startAt);
    map['end_at'] = Variable<DateTime>(endAt);
    map['asset_count'] = Variable<int>(assetCount);
    return map;
  }

  TimelineBucketsCompanion toCompanion(bool nullToAbsent) {
    return TimelineBucketsCompanion(
      id: Value(id),
      title: Value(title),
      startAt: Value(startAt),
      endAt: Value(endAt),
      assetCount: Value(assetCount),
    );
  }

  factory TimelineBucket.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimelineBucket(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      startAt: serializer.fromJson<DateTime>(json['startAt']),
      endAt: serializer.fromJson<DateTime>(json['endAt']),
      assetCount: serializer.fromJson<int>(json['assetCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'startAt': serializer.toJson<DateTime>(startAt),
      'endAt': serializer.toJson<DateTime>(endAt),
      'assetCount': serializer.toJson<int>(assetCount),
    };
  }

  TimelineBucket copyWith(
          {String? id,
          String? title,
          DateTime? startAt,
          DateTime? endAt,
          int? assetCount}) =>
      TimelineBucket(
        id: id ?? this.id,
        title: title ?? this.title,
        startAt: startAt ?? this.startAt,
        endAt: endAt ?? this.endAt,
        assetCount: assetCount ?? this.assetCount,
      );
  TimelineBucket copyWithCompanion(TimelineBucketsCompanion data) {
    return TimelineBucket(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
      assetCount:
          data.assetCount.present ? data.assetCount.value : this.assetCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimelineBucket(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('assetCount: $assetCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, startAt, endAt, assetCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimelineBucket &&
          other.id == this.id &&
          other.title == this.title &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt &&
          other.assetCount == this.assetCount);
}

class TimelineBucketsCompanion extends UpdateCompanion<TimelineBucket> {
  final Value<String> id;
  final Value<String> title;
  final Value<DateTime> startAt;
  final Value<DateTime> endAt;
  final Value<int> assetCount;
  final Value<int> rowid;
  const TimelineBucketsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    this.assetCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimelineBucketsCompanion.insert({
    required String id,
    required String title,
    required DateTime startAt,
    required DateTime endAt,
    this.assetCount = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        startAt = Value(startAt),
        endAt = Value(endAt);
  static Insertable<TimelineBucket> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<DateTime>? startAt,
    Expression<DateTime>? endAt,
    Expression<int>? assetCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
      if (assetCount != null) 'asset_count': assetCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimelineBucketsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<DateTime>? startAt,
      Value<DateTime>? endAt,
      Value<int>? assetCount,
      Value<int>? rowid}) {
    return TimelineBucketsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      assetCount: assetCount ?? this.assetCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<DateTime>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<DateTime>(endAt.value);
    }
    if (assetCount.present) {
      map['asset_count'] = Variable<int>(assetCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimelineBucketsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('assetCount: $assetCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaceClustersTable extends PlaceClusters
    with TableInfo<$PlaceClustersTable, PlaceCluster> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaceClustersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _assetCountMeta =
      const VerificationMeta('assetCount');
  @override
  late final GeneratedColumn<int> assetCount = GeneratedColumn<int>(
      'asset_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, country, latitude, longitude, assetCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'place_clusters';
  @override
  VerificationContext validateIntegrity(Insertable<PlaceCluster> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('asset_count')) {
      context.handle(
          _assetCountMeta,
          assetCount.isAcceptableOrUnknown(
              data['asset_count']!, _assetCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaceCluster map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaceCluster(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country']),
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      assetCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}asset_count'])!,
    );
  }

  @override
  $PlaceClustersTable createAlias(String alias) {
    return $PlaceClustersTable(attachedDatabase, alias);
  }
}

class PlaceCluster extends DataClass implements Insertable<PlaceCluster> {
  final String id;
  final String name;
  final String? country;
  final double latitude;
  final double longitude;
  final int assetCount;
  const PlaceCluster(
      {required this.id,
      required this.name,
      this.country,
      required this.latitude,
      required this.longitude,
      required this.assetCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['asset_count'] = Variable<int>(assetCount);
    return map;
  }

  PlaceClustersCompanion toCompanion(bool nullToAbsent) {
    return PlaceClustersCompanion(
      id: Value(id),
      name: Value(name),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      latitude: Value(latitude),
      longitude: Value(longitude),
      assetCount: Value(assetCount),
    );
  }

  factory PlaceCluster.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaceCluster(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      country: serializer.fromJson<String?>(json['country']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      assetCount: serializer.fromJson<int>(json['assetCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'country': serializer.toJson<String?>(country),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'assetCount': serializer.toJson<int>(assetCount),
    };
  }

  PlaceCluster copyWith(
          {String? id,
          String? name,
          Value<String?> country = const Value.absent(),
          double? latitude,
          double? longitude,
          int? assetCount}) =>
      PlaceCluster(
        id: id ?? this.id,
        name: name ?? this.name,
        country: country.present ? country.value : this.country,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        assetCount: assetCount ?? this.assetCount,
      );
  PlaceCluster copyWithCompanion(PlaceClustersCompanion data) {
    return PlaceCluster(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      country: data.country.present ? data.country.value : this.country,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      assetCount:
          data.assetCount.present ? data.assetCount.value : this.assetCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaceCluster(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('country: $country, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('assetCount: $assetCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, country, latitude, longitude, assetCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaceCluster &&
          other.id == this.id &&
          other.name == this.name &&
          other.country == this.country &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.assetCount == this.assetCount);
}

class PlaceClustersCompanion extends UpdateCompanion<PlaceCluster> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> country;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<int> assetCount;
  final Value<int> rowid;
  const PlaceClustersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.country = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.assetCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaceClustersCompanion.insert({
    required String id,
    required String name,
    this.country = const Value.absent(),
    required double latitude,
    required double longitude,
    this.assetCount = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        latitude = Value(latitude),
        longitude = Value(longitude);
  static Insertable<PlaceCluster> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? country,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<int>? assetCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (country != null) 'country': country,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (assetCount != null) 'asset_count': assetCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaceClustersCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? country,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<int>? assetCount,
      Value<int>? rowid}) {
    return PlaceClustersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      assetCount: assetCount ?? this.assetCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (assetCount.present) {
      map['asset_count'] = Variable<int>(assetCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaceClustersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('country: $country, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('assetCount: $assetCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PeopleEmbeddingsTable extends PeopleEmbeddings
    with TableInfo<$PeopleEmbeddingsTable, PeopleEmbedding> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PeopleEmbeddingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _embeddingJsonMeta =
      const VerificationMeta('embeddingJson');
  @override
  late final GeneratedColumn<String> embeddingJson = GeneratedColumn<String>(
      'embedding_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _faceCountMeta =
      const VerificationMeta('faceCount');
  @override
  late final GeneratedColumn<int> faceCount = GeneratedColumn<int>(
      'face_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, displayName, embeddingJson, faceCount, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'people_embeddings';
  @override
  VerificationContext validateIntegrity(Insertable<PeopleEmbedding> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('embedding_json')) {
      context.handle(
          _embeddingJsonMeta,
          embeddingJson.isAcceptableOrUnknown(
              data['embedding_json']!, _embeddingJsonMeta));
    } else if (isInserting) {
      context.missing(_embeddingJsonMeta);
    }
    if (data.containsKey('face_count')) {
      context.handle(_faceCountMeta,
          faceCount.isAcceptableOrUnknown(data['face_count']!, _faceCountMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PeopleEmbedding map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PeopleEmbedding(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      embeddingJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}embedding_json'])!,
      faceCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}face_count'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PeopleEmbeddingsTable createAlias(String alias) {
    return $PeopleEmbeddingsTable(attachedDatabase, alias);
  }
}

class PeopleEmbedding extends DataClass implements Insertable<PeopleEmbedding> {
  final String id;
  final String displayName;
  final String embeddingJson;
  final int faceCount;
  final DateTime updatedAt;
  const PeopleEmbedding(
      {required this.id,
      required this.displayName,
      required this.embeddingJson,
      required this.faceCount,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['display_name'] = Variable<String>(displayName);
    map['embedding_json'] = Variable<String>(embeddingJson);
    map['face_count'] = Variable<int>(faceCount);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PeopleEmbeddingsCompanion toCompanion(bool nullToAbsent) {
    return PeopleEmbeddingsCompanion(
      id: Value(id),
      displayName: Value(displayName),
      embeddingJson: Value(embeddingJson),
      faceCount: Value(faceCount),
      updatedAt: Value(updatedAt),
    );
  }

  factory PeopleEmbedding.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeopleEmbedding(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      embeddingJson: serializer.fromJson<String>(json['embeddingJson']),
      faceCount: serializer.fromJson<int>(json['faceCount']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String>(displayName),
      'embeddingJson': serializer.toJson<String>(embeddingJson),
      'faceCount': serializer.toJson<int>(faceCount),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PeopleEmbedding copyWith(
          {String? id,
          String? displayName,
          String? embeddingJson,
          int? faceCount,
          DateTime? updatedAt}) =>
      PeopleEmbedding(
        id: id ?? this.id,
        displayName: displayName ?? this.displayName,
        embeddingJson: embeddingJson ?? this.embeddingJson,
        faceCount: faceCount ?? this.faceCount,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PeopleEmbedding copyWithCompanion(PeopleEmbeddingsCompanion data) {
    return PeopleEmbedding(
      id: data.id.present ? data.id.value : this.id,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      embeddingJson: data.embeddingJson.present
          ? data.embeddingJson.value
          : this.embeddingJson,
      faceCount: data.faceCount.present ? data.faceCount.value : this.faceCount,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PeopleEmbedding(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('embeddingJson: $embeddingJson, ')
          ..write('faceCount: $faceCount, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, displayName, embeddingJson, faceCount, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeopleEmbedding &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.embeddingJson == this.embeddingJson &&
          other.faceCount == this.faceCount &&
          other.updatedAt == this.updatedAt);
}

class PeopleEmbeddingsCompanion extends UpdateCompanion<PeopleEmbedding> {
  final Value<String> id;
  final Value<String> displayName;
  final Value<String> embeddingJson;
  final Value<int> faceCount;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PeopleEmbeddingsCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.embeddingJson = const Value.absent(),
    this.faceCount = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PeopleEmbeddingsCompanion.insert({
    required String id,
    required String displayName,
    required String embeddingJson,
    this.faceCount = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        displayName = Value(displayName),
        embeddingJson = Value(embeddingJson),
        updatedAt = Value(updatedAt);
  static Insertable<PeopleEmbedding> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<String>? embeddingJson,
    Expression<int>? faceCount,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (embeddingJson != null) 'embedding_json': embeddingJson,
      if (faceCount != null) 'face_count': faceCount,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PeopleEmbeddingsCompanion copyWith(
      {Value<String>? id,
      Value<String>? displayName,
      Value<String>? embeddingJson,
      Value<int>? faceCount,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return PeopleEmbeddingsCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      embeddingJson: embeddingJson ?? this.embeddingJson,
      faceCount: faceCount ?? this.faceCount,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (embeddingJson.present) {
      map['embedding_json'] = Variable<String>(embeddingJson.value);
    }
    if (faceCount.present) {
      map['face_count'] = Variable<int>(faceCount.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PeopleEmbeddingsCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('embeddingJson: $embeddingJson, ')
          ..write('faceCount: $faceCount, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SmartAnalysisResultsTable extends SmartAnalysisResults
    with TableInfo<$SmartAnalysisResultsTable, SmartAnalysisResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmartAnalysisResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assetIdMeta =
      const VerificationMeta('assetId');
  @override
  late final GeneratedColumn<String> assetId = GeneratedColumn<String>(
      'asset_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _jobKindMeta =
      const VerificationMeta('jobKind');
  @override
  late final GeneratedColumn<String> jobKind = GeneratedColumn<String>(
      'job_kind', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resultJsonMeta =
      const VerificationMeta('resultJson');
  @override
  late final GeneratedColumn<String> resultJson = GeneratedColumn<String>(
      'result_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, assetId, jobKind, resultJson, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'smart_analysis_results';
  @override
  VerificationContext validateIntegrity(
      Insertable<SmartAnalysisResult> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('asset_id')) {
      context.handle(_assetIdMeta,
          assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta));
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('job_kind')) {
      context.handle(_jobKindMeta,
          jobKind.isAcceptableOrUnknown(data['job_kind']!, _jobKindMeta));
    } else if (isInserting) {
      context.missing(_jobKindMeta);
    }
    if (data.containsKey('result_json')) {
      context.handle(
          _resultJsonMeta,
          resultJson.isAcceptableOrUnknown(
              data['result_json']!, _resultJsonMeta));
    } else if (isInserting) {
      context.missing(_resultJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SmartAnalysisResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmartAnalysisResult(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      assetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}asset_id'])!,
      jobKind: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}job_kind'])!,
      resultJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}result_json'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SmartAnalysisResultsTable createAlias(String alias) {
    return $SmartAnalysisResultsTable(attachedDatabase, alias);
  }
}

class SmartAnalysisResult extends DataClass
    implements Insertable<SmartAnalysisResult> {
  final String id;
  final String assetId;
  final String jobKind;
  final String resultJson;
  final DateTime updatedAt;
  const SmartAnalysisResult(
      {required this.id,
      required this.assetId,
      required this.jobKind,
      required this.resultJson,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['asset_id'] = Variable<String>(assetId);
    map['job_kind'] = Variable<String>(jobKind);
    map['result_json'] = Variable<String>(resultJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SmartAnalysisResultsCompanion toCompanion(bool nullToAbsent) {
    return SmartAnalysisResultsCompanion(
      id: Value(id),
      assetId: Value(assetId),
      jobKind: Value(jobKind),
      resultJson: Value(resultJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory SmartAnalysisResult.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmartAnalysisResult(
      id: serializer.fromJson<String>(json['id']),
      assetId: serializer.fromJson<String>(json['assetId']),
      jobKind: serializer.fromJson<String>(json['jobKind']),
      resultJson: serializer.fromJson<String>(json['resultJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'assetId': serializer.toJson<String>(assetId),
      'jobKind': serializer.toJson<String>(jobKind),
      'resultJson': serializer.toJson<String>(resultJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SmartAnalysisResult copyWith(
          {String? id,
          String? assetId,
          String? jobKind,
          String? resultJson,
          DateTime? updatedAt}) =>
      SmartAnalysisResult(
        id: id ?? this.id,
        assetId: assetId ?? this.assetId,
        jobKind: jobKind ?? this.jobKind,
        resultJson: resultJson ?? this.resultJson,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SmartAnalysisResult copyWithCompanion(SmartAnalysisResultsCompanion data) {
    return SmartAnalysisResult(
      id: data.id.present ? data.id.value : this.id,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      jobKind: data.jobKind.present ? data.jobKind.value : this.jobKind,
      resultJson:
          data.resultJson.present ? data.resultJson.value : this.resultJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmartAnalysisResult(')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('jobKind: $jobKind, ')
          ..write('resultJson: $resultJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, assetId, jobKind, resultJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmartAnalysisResult &&
          other.id == this.id &&
          other.assetId == this.assetId &&
          other.jobKind == this.jobKind &&
          other.resultJson == this.resultJson &&
          other.updatedAt == this.updatedAt);
}

class SmartAnalysisResultsCompanion
    extends UpdateCompanion<SmartAnalysisResult> {
  final Value<String> id;
  final Value<String> assetId;
  final Value<String> jobKind;
  final Value<String> resultJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SmartAnalysisResultsCompanion({
    this.id = const Value.absent(),
    this.assetId = const Value.absent(),
    this.jobKind = const Value.absent(),
    this.resultJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SmartAnalysisResultsCompanion.insert({
    required String id,
    required String assetId,
    required String jobKind,
    required String resultJson,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        assetId = Value(assetId),
        jobKind = Value(jobKind),
        resultJson = Value(resultJson),
        updatedAt = Value(updatedAt);
  static Insertable<SmartAnalysisResult> custom({
    Expression<String>? id,
    Expression<String>? assetId,
    Expression<String>? jobKind,
    Expression<String>? resultJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (assetId != null) 'asset_id': assetId,
      if (jobKind != null) 'job_kind': jobKind,
      if (resultJson != null) 'result_json': resultJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SmartAnalysisResultsCompanion copyWith(
      {Value<String>? id,
      Value<String>? assetId,
      Value<String>? jobKind,
      Value<String>? resultJson,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return SmartAnalysisResultsCompanion(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      jobKind: jobKind ?? this.jobKind,
      resultJson: resultJson ?? this.resultJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<String>(assetId.value);
    }
    if (jobKind.present) {
      map['job_kind'] = Variable<String>(jobKind.value);
    }
    if (resultJson.present) {
      map['result_json'] = Variable<String>(resultJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmartAnalysisResultsCompanion(')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('jobKind: $jobKind, ')
          ..write('resultJson: $resultJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CacheRecordsTable extends CacheRecords
    with TableInfo<$CacheRecordsTable, CacheRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CacheRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assetIdMeta =
      const VerificationMeta('assetId');
  @override
  late final GeneratedColumn<String> assetId = GeneratedColumn<String>(
      'asset_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cacheKindMeta =
      const VerificationMeta('cacheKind');
  @override
  late final GeneratedColumn<String> cacheKind = GeneratedColumn<String>(
      'cache_kind', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathOrValueMeta =
      const VerificationMeta('pathOrValue');
  @override
  late final GeneratedColumn<String> pathOrValue = GeneratedColumn<String>(
      'path_or_value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceFingerprintMeta =
      const VerificationMeta('sourceFingerprint');
  @override
  late final GeneratedColumn<String> sourceFingerprint =
      GeneratedColumn<String>('source_fingerprint', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _schemaVersionMeta =
      const VerificationMeta('schemaVersion');
  @override
  late final GeneratedColumn<int> schemaVersion = GeneratedColumn<int>(
      'schema_version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        assetId,
        cacheKind,
        pathOrValue,
        sourceFingerprint,
        schemaVersion,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cache_records';
  @override
  VerificationContext validateIntegrity(Insertable<CacheRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('asset_id')) {
      context.handle(_assetIdMeta,
          assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta));
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('cache_kind')) {
      context.handle(_cacheKindMeta,
          cacheKind.isAcceptableOrUnknown(data['cache_kind']!, _cacheKindMeta));
    } else if (isInserting) {
      context.missing(_cacheKindMeta);
    }
    if (data.containsKey('path_or_value')) {
      context.handle(
          _pathOrValueMeta,
          pathOrValue.isAcceptableOrUnknown(
              data['path_or_value']!, _pathOrValueMeta));
    } else if (isInserting) {
      context.missing(_pathOrValueMeta);
    }
    if (data.containsKey('source_fingerprint')) {
      context.handle(
          _sourceFingerprintMeta,
          sourceFingerprint.isAcceptableOrUnknown(
              data['source_fingerprint']!, _sourceFingerprintMeta));
    } else if (isInserting) {
      context.missing(_sourceFingerprintMeta);
    }
    if (data.containsKey('schema_version')) {
      context.handle(
          _schemaVersionMeta,
          schemaVersion.isAcceptableOrUnknown(
              data['schema_version']!, _schemaVersionMeta));
    } else if (isInserting) {
      context.missing(_schemaVersionMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CacheRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CacheRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      assetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}asset_id'])!,
      cacheKind: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cache_kind'])!,
      pathOrValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path_or_value'])!,
      sourceFingerprint: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}source_fingerprint'])!,
      schemaVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}schema_version'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CacheRecordsTable createAlias(String alias) {
    return $CacheRecordsTable(attachedDatabase, alias);
  }
}

class CacheRecord extends DataClass implements Insertable<CacheRecord> {
  final String id;
  final String assetId;
  final String cacheKind;
  final String pathOrValue;
  final String sourceFingerprint;
  final int schemaVersion;
  final DateTime updatedAt;
  const CacheRecord(
      {required this.id,
      required this.assetId,
      required this.cacheKind,
      required this.pathOrValue,
      required this.sourceFingerprint,
      required this.schemaVersion,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['asset_id'] = Variable<String>(assetId);
    map['cache_kind'] = Variable<String>(cacheKind);
    map['path_or_value'] = Variable<String>(pathOrValue);
    map['source_fingerprint'] = Variable<String>(sourceFingerprint);
    map['schema_version'] = Variable<int>(schemaVersion);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CacheRecordsCompanion toCompanion(bool nullToAbsent) {
    return CacheRecordsCompanion(
      id: Value(id),
      assetId: Value(assetId),
      cacheKind: Value(cacheKind),
      pathOrValue: Value(pathOrValue),
      sourceFingerprint: Value(sourceFingerprint),
      schemaVersion: Value(schemaVersion),
      updatedAt: Value(updatedAt),
    );
  }

  factory CacheRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CacheRecord(
      id: serializer.fromJson<String>(json['id']),
      assetId: serializer.fromJson<String>(json['assetId']),
      cacheKind: serializer.fromJson<String>(json['cacheKind']),
      pathOrValue: serializer.fromJson<String>(json['pathOrValue']),
      sourceFingerprint: serializer.fromJson<String>(json['sourceFingerprint']),
      schemaVersion: serializer.fromJson<int>(json['schemaVersion']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'assetId': serializer.toJson<String>(assetId),
      'cacheKind': serializer.toJson<String>(cacheKind),
      'pathOrValue': serializer.toJson<String>(pathOrValue),
      'sourceFingerprint': serializer.toJson<String>(sourceFingerprint),
      'schemaVersion': serializer.toJson<int>(schemaVersion),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CacheRecord copyWith(
          {String? id,
          String? assetId,
          String? cacheKind,
          String? pathOrValue,
          String? sourceFingerprint,
          int? schemaVersion,
          DateTime? updatedAt}) =>
      CacheRecord(
        id: id ?? this.id,
        assetId: assetId ?? this.assetId,
        cacheKind: cacheKind ?? this.cacheKind,
        pathOrValue: pathOrValue ?? this.pathOrValue,
        sourceFingerprint: sourceFingerprint ?? this.sourceFingerprint,
        schemaVersion: schemaVersion ?? this.schemaVersion,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CacheRecord copyWithCompanion(CacheRecordsCompanion data) {
    return CacheRecord(
      id: data.id.present ? data.id.value : this.id,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      cacheKind: data.cacheKind.present ? data.cacheKind.value : this.cacheKind,
      pathOrValue:
          data.pathOrValue.present ? data.pathOrValue.value : this.pathOrValue,
      sourceFingerprint: data.sourceFingerprint.present
          ? data.sourceFingerprint.value
          : this.sourceFingerprint,
      schemaVersion: data.schemaVersion.present
          ? data.schemaVersion.value
          : this.schemaVersion,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CacheRecord(')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('cacheKind: $cacheKind, ')
          ..write('pathOrValue: $pathOrValue, ')
          ..write('sourceFingerprint: $sourceFingerprint, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, assetId, cacheKind, pathOrValue,
      sourceFingerprint, schemaVersion, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CacheRecord &&
          other.id == this.id &&
          other.assetId == this.assetId &&
          other.cacheKind == this.cacheKind &&
          other.pathOrValue == this.pathOrValue &&
          other.sourceFingerprint == this.sourceFingerprint &&
          other.schemaVersion == this.schemaVersion &&
          other.updatedAt == this.updatedAt);
}

class CacheRecordsCompanion extends UpdateCompanion<CacheRecord> {
  final Value<String> id;
  final Value<String> assetId;
  final Value<String> cacheKind;
  final Value<String> pathOrValue;
  final Value<String> sourceFingerprint;
  final Value<int> schemaVersion;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CacheRecordsCompanion({
    this.id = const Value.absent(),
    this.assetId = const Value.absent(),
    this.cacheKind = const Value.absent(),
    this.pathOrValue = const Value.absent(),
    this.sourceFingerprint = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CacheRecordsCompanion.insert({
    required String id,
    required String assetId,
    required String cacheKind,
    required String pathOrValue,
    required String sourceFingerprint,
    required int schemaVersion,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        assetId = Value(assetId),
        cacheKind = Value(cacheKind),
        pathOrValue = Value(pathOrValue),
        sourceFingerprint = Value(sourceFingerprint),
        schemaVersion = Value(schemaVersion),
        updatedAt = Value(updatedAt);
  static Insertable<CacheRecord> custom({
    Expression<String>? id,
    Expression<String>? assetId,
    Expression<String>? cacheKind,
    Expression<String>? pathOrValue,
    Expression<String>? sourceFingerprint,
    Expression<int>? schemaVersion,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (assetId != null) 'asset_id': assetId,
      if (cacheKind != null) 'cache_kind': cacheKind,
      if (pathOrValue != null) 'path_or_value': pathOrValue,
      if (sourceFingerprint != null) 'source_fingerprint': sourceFingerprint,
      if (schemaVersion != null) 'schema_version': schemaVersion,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CacheRecordsCompanion copyWith(
      {Value<String>? id,
      Value<String>? assetId,
      Value<String>? cacheKind,
      Value<String>? pathOrValue,
      Value<String>? sourceFingerprint,
      Value<int>? schemaVersion,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CacheRecordsCompanion(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      cacheKind: cacheKind ?? this.cacheKind,
      pathOrValue: pathOrValue ?? this.pathOrValue,
      sourceFingerprint: sourceFingerprint ?? this.sourceFingerprint,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<String>(assetId.value);
    }
    if (cacheKind.present) {
      map['cache_kind'] = Variable<String>(cacheKind.value);
    }
    if (pathOrValue.present) {
      map['path_or_value'] = Variable<String>(pathOrValue.value);
    }
    if (sourceFingerprint.present) {
      map['source_fingerprint'] = Variable<String>(sourceFingerprint.value);
    }
    if (schemaVersion.present) {
      map['schema_version'] = Variable<int>(schemaVersion.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CacheRecordsCompanion(')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('cacheKind: $cacheKind, ')
          ..write('pathOrValue: $pathOrValue, ')
          ..write('sourceFingerprint: $sourceFingerprint, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BackupJobsTable extends BackupJobs
    with TableInfo<$BackupJobsTable, BackupJob> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackupJobsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assetIdMeta =
      const VerificationMeta('assetId');
  @override
  late final GeneratedColumn<String> assetId = GeneratedColumn<String>(
      'asset_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _remotePathMeta =
      const VerificationMeta('remotePath');
  @override
  late final GeneratedColumn<String> remotePath = GeneratedColumn<String>(
      'remote_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _attemptsMeta =
      const VerificationMeta('attempts');
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
      'attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        assetId,
        state,
        remotePath,
        errorMessage,
        attempts,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backup_jobs';
  @override
  VerificationContext validateIntegrity(Insertable<BackupJob> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('asset_id')) {
      context.handle(_assetIdMeta,
          assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta));
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('remote_path')) {
      context.handle(
          _remotePathMeta,
          remotePath.isAcceptableOrUnknown(
              data['remote_path']!, _remotePathMeta));
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    if (data.containsKey('attempts')) {
      context.handle(_attemptsMeta,
          attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BackupJob map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackupJob(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      assetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}asset_id'])!,
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      remotePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_path']),
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
      attempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempts'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BackupJobsTable createAlias(String alias) {
    return $BackupJobsTable(attachedDatabase, alias);
  }
}

class BackupJob extends DataClass implements Insertable<BackupJob> {
  final String id;
  final String assetId;
  final String state;
  final String? remotePath;
  final String? errorMessage;
  final int attempts;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BackupJob(
      {required this.id,
      required this.assetId,
      required this.state,
      this.remotePath,
      this.errorMessage,
      required this.attempts,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['asset_id'] = Variable<String>(assetId);
    map['state'] = Variable<String>(state);
    if (!nullToAbsent || remotePath != null) {
      map['remote_path'] = Variable<String>(remotePath);
    }
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['attempts'] = Variable<int>(attempts);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BackupJobsCompanion toCompanion(bool nullToAbsent) {
    return BackupJobsCompanion(
      id: Value(id),
      assetId: Value(assetId),
      state: Value(state),
      remotePath: remotePath == null && nullToAbsent
          ? const Value.absent()
          : Value(remotePath),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      attempts: Value(attempts),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BackupJob.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackupJob(
      id: serializer.fromJson<String>(json['id']),
      assetId: serializer.fromJson<String>(json['assetId']),
      state: serializer.fromJson<String>(json['state']),
      remotePath: serializer.fromJson<String?>(json['remotePath']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      attempts: serializer.fromJson<int>(json['attempts']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'assetId': serializer.toJson<String>(assetId),
      'state': serializer.toJson<String>(state),
      'remotePath': serializer.toJson<String?>(remotePath),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'attempts': serializer.toJson<int>(attempts),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BackupJob copyWith(
          {String? id,
          String? assetId,
          String? state,
          Value<String?> remotePath = const Value.absent(),
          Value<String?> errorMessage = const Value.absent(),
          int? attempts,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      BackupJob(
        id: id ?? this.id,
        assetId: assetId ?? this.assetId,
        state: state ?? this.state,
        remotePath: remotePath.present ? remotePath.value : this.remotePath,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
        attempts: attempts ?? this.attempts,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  BackupJob copyWithCompanion(BackupJobsCompanion data) {
    return BackupJob(
      id: data.id.present ? data.id.value : this.id,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      state: data.state.present ? data.state.value : this.state,
      remotePath:
          data.remotePath.present ? data.remotePath.value : this.remotePath,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackupJob(')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('state: $state, ')
          ..write('remotePath: $remotePath, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('attempts: $attempts, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, assetId, state, remotePath, errorMessage,
      attempts, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackupJob &&
          other.id == this.id &&
          other.assetId == this.assetId &&
          other.state == this.state &&
          other.remotePath == this.remotePath &&
          other.errorMessage == this.errorMessage &&
          other.attempts == this.attempts &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BackupJobsCompanion extends UpdateCompanion<BackupJob> {
  final Value<String> id;
  final Value<String> assetId;
  final Value<String> state;
  final Value<String?> remotePath;
  final Value<String?> errorMessage;
  final Value<int> attempts;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BackupJobsCompanion({
    this.id = const Value.absent(),
    this.assetId = const Value.absent(),
    this.state = const Value.absent(),
    this.remotePath = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.attempts = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BackupJobsCompanion.insert({
    required String id,
    required String assetId,
    required String state,
    this.remotePath = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.attempts = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        assetId = Value(assetId),
        state = Value(state),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<BackupJob> custom({
    Expression<String>? id,
    Expression<String>? assetId,
    Expression<String>? state,
    Expression<String>? remotePath,
    Expression<String>? errorMessage,
    Expression<int>? attempts,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (assetId != null) 'asset_id': assetId,
      if (state != null) 'state': state,
      if (remotePath != null) 'remote_path': remotePath,
      if (errorMessage != null) 'error_message': errorMessage,
      if (attempts != null) 'attempts': attempts,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BackupJobsCompanion copyWith(
      {Value<String>? id,
      Value<String>? assetId,
      Value<String>? state,
      Value<String?>? remotePath,
      Value<String?>? errorMessage,
      Value<int>? attempts,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return BackupJobsCompanion(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      state: state ?? this.state,
      remotePath: remotePath ?? this.remotePath,
      errorMessage: errorMessage ?? this.errorMessage,
      attempts: attempts ?? this.attempts,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<String>(assetId.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (remotePath.present) {
      map['remote_path'] = Variable<String>(remotePath.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackupJobsCompanion(')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('state: $state, ')
          ..write('remotePath: $remotePath, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('attempts: $attempts, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SharedAlbumsTable extends SharedAlbums
    with TableInfo<$SharedAlbumsTable, SharedAlbum> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SharedAlbumsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ownerNameMeta =
      const VerificationMeta('ownerName');
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
      'owner_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _partnerNameMeta =
      const VerificationMeta('partnerName');
  @override
  late final GeneratedColumn<String> partnerName = GeneratedColumn<String>(
      'partner_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _manifestPathMeta =
      const VerificationMeta('manifestPath');
  @override
  late final GeneratedColumn<String> manifestPath = GeneratedColumn<String>(
      'manifest_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isJoinedMeta =
      const VerificationMeta('isJoined');
  @override
  late final GeneratedColumn<bool> isJoined = GeneratedColumn<bool>(
      'is_joined', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_joined" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, ownerName, partnerName, manifestPath, isJoined, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shared_albums';
  @override
  VerificationContext validateIntegrity(Insertable<SharedAlbum> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('owner_name')) {
      context.handle(_ownerNameMeta,
          ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta));
    } else if (isInserting) {
      context.missing(_ownerNameMeta);
    }
    if (data.containsKey('partner_name')) {
      context.handle(
          _partnerNameMeta,
          partnerName.isAcceptableOrUnknown(
              data['partner_name']!, _partnerNameMeta));
    }
    if (data.containsKey('manifest_path')) {
      context.handle(
          _manifestPathMeta,
          manifestPath.isAcceptableOrUnknown(
              data['manifest_path']!, _manifestPathMeta));
    } else if (isInserting) {
      context.missing(_manifestPathMeta);
    }
    if (data.containsKey('is_joined')) {
      context.handle(_isJoinedMeta,
          isJoined.isAcceptableOrUnknown(data['is_joined']!, _isJoinedMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SharedAlbum map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SharedAlbum(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      ownerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_name'])!,
      partnerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}partner_name']),
      manifestPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}manifest_path'])!,
      isJoined: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_joined'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SharedAlbumsTable createAlias(String alias) {
    return $SharedAlbumsTable(attachedDatabase, alias);
  }
}

class SharedAlbum extends DataClass implements Insertable<SharedAlbum> {
  final String id;
  final String title;
  final String ownerName;
  final String? partnerName;
  final String manifestPath;
  final bool isJoined;
  final DateTime updatedAt;
  const SharedAlbum(
      {required this.id,
      required this.title,
      required this.ownerName,
      this.partnerName,
      required this.manifestPath,
      required this.isJoined,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['owner_name'] = Variable<String>(ownerName);
    if (!nullToAbsent || partnerName != null) {
      map['partner_name'] = Variable<String>(partnerName);
    }
    map['manifest_path'] = Variable<String>(manifestPath);
    map['is_joined'] = Variable<bool>(isJoined);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SharedAlbumsCompanion toCompanion(bool nullToAbsent) {
    return SharedAlbumsCompanion(
      id: Value(id),
      title: Value(title),
      ownerName: Value(ownerName),
      partnerName: partnerName == null && nullToAbsent
          ? const Value.absent()
          : Value(partnerName),
      manifestPath: Value(manifestPath),
      isJoined: Value(isJoined),
      updatedAt: Value(updatedAt),
    );
  }

  factory SharedAlbum.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SharedAlbum(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      ownerName: serializer.fromJson<String>(json['ownerName']),
      partnerName: serializer.fromJson<String?>(json['partnerName']),
      manifestPath: serializer.fromJson<String>(json['manifestPath']),
      isJoined: serializer.fromJson<bool>(json['isJoined']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'ownerName': serializer.toJson<String>(ownerName),
      'partnerName': serializer.toJson<String?>(partnerName),
      'manifestPath': serializer.toJson<String>(manifestPath),
      'isJoined': serializer.toJson<bool>(isJoined),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SharedAlbum copyWith(
          {String? id,
          String? title,
          String? ownerName,
          Value<String?> partnerName = const Value.absent(),
          String? manifestPath,
          bool? isJoined,
          DateTime? updatedAt}) =>
      SharedAlbum(
        id: id ?? this.id,
        title: title ?? this.title,
        ownerName: ownerName ?? this.ownerName,
        partnerName: partnerName.present ? partnerName.value : this.partnerName,
        manifestPath: manifestPath ?? this.manifestPath,
        isJoined: isJoined ?? this.isJoined,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SharedAlbum copyWithCompanion(SharedAlbumsCompanion data) {
    return SharedAlbum(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      partnerName:
          data.partnerName.present ? data.partnerName.value : this.partnerName,
      manifestPath: data.manifestPath.present
          ? data.manifestPath.value
          : this.manifestPath,
      isJoined: data.isJoined.present ? data.isJoined.value : this.isJoined,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SharedAlbum(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('ownerName: $ownerName, ')
          ..write('partnerName: $partnerName, ')
          ..write('manifestPath: $manifestPath, ')
          ..write('isJoined: $isJoined, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, ownerName, partnerName, manifestPath, isJoined, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SharedAlbum &&
          other.id == this.id &&
          other.title == this.title &&
          other.ownerName == this.ownerName &&
          other.partnerName == this.partnerName &&
          other.manifestPath == this.manifestPath &&
          other.isJoined == this.isJoined &&
          other.updatedAt == this.updatedAt);
}

class SharedAlbumsCompanion extends UpdateCompanion<SharedAlbum> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> ownerName;
  final Value<String?> partnerName;
  final Value<String> manifestPath;
  final Value<bool> isJoined;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SharedAlbumsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.partnerName = const Value.absent(),
    this.manifestPath = const Value.absent(),
    this.isJoined = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SharedAlbumsCompanion.insert({
    required String id,
    required String title,
    required String ownerName,
    this.partnerName = const Value.absent(),
    required String manifestPath,
    this.isJoined = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        ownerName = Value(ownerName),
        manifestPath = Value(manifestPath),
        updatedAt = Value(updatedAt);
  static Insertable<SharedAlbum> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? ownerName,
    Expression<String>? partnerName,
    Expression<String>? manifestPath,
    Expression<bool>? isJoined,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (ownerName != null) 'owner_name': ownerName,
      if (partnerName != null) 'partner_name': partnerName,
      if (manifestPath != null) 'manifest_path': manifestPath,
      if (isJoined != null) 'is_joined': isJoined,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SharedAlbumsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? ownerName,
      Value<String?>? partnerName,
      Value<String>? manifestPath,
      Value<bool>? isJoined,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return SharedAlbumsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      ownerName: ownerName ?? this.ownerName,
      partnerName: partnerName ?? this.partnerName,
      manifestPath: manifestPath ?? this.manifestPath,
      isJoined: isJoined ?? this.isJoined,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (partnerName.present) {
      map['partner_name'] = Variable<String>(partnerName.value);
    }
    if (manifestPath.present) {
      map['manifest_path'] = Variable<String>(manifestPath.value);
    }
    if (isJoined.present) {
      map['is_joined'] = Variable<bool>(isJoined.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SharedAlbumsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('ownerName: $ownerName, ')
          ..write('partnerName: $partnerName, ')
          ..write('manifestPath: $manifestPath, ')
          ..write('isJoined: $isJoined, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SharedCommentsTable extends SharedComments
    with TableInfo<$SharedCommentsTable, SharedComment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SharedCommentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sharedAlbumIdMeta =
      const VerificationMeta('sharedAlbumId');
  @override
  late final GeneratedColumn<String> sharedAlbumId = GeneratedColumn<String>(
      'shared_album_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assetIdMeta =
      const VerificationMeta('assetId');
  @override
  late final GeneratedColumn<String> assetId = GeneratedColumn<String>(
      'asset_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorNameMeta =
      const VerificationMeta('authorName');
  @override
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
      'author_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sharedAlbumId, assetId, authorName, body, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shared_comments';
  @override
  VerificationContext validateIntegrity(Insertable<SharedComment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shared_album_id')) {
      context.handle(
          _sharedAlbumIdMeta,
          sharedAlbumId.isAcceptableOrUnknown(
              data['shared_album_id']!, _sharedAlbumIdMeta));
    } else if (isInserting) {
      context.missing(_sharedAlbumIdMeta);
    }
    if (data.containsKey('asset_id')) {
      context.handle(_assetIdMeta,
          assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta));
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('author_name')) {
      context.handle(
          _authorNameMeta,
          authorName.isAcceptableOrUnknown(
              data['author_name']!, _authorNameMeta));
    } else if (isInserting) {
      context.missing(_authorNameMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SharedComment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SharedComment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sharedAlbumId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}shared_album_id'])!,
      assetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}asset_id'])!,
      authorName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_name'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SharedCommentsTable createAlias(String alias) {
    return $SharedCommentsTable(attachedDatabase, alias);
  }
}

class SharedComment extends DataClass implements Insertable<SharedComment> {
  final String id;
  final String sharedAlbumId;
  final String assetId;
  final String authorName;
  final String body;
  final DateTime createdAt;
  const SharedComment(
      {required this.id,
      required this.sharedAlbumId,
      required this.assetId,
      required this.authorName,
      required this.body,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shared_album_id'] = Variable<String>(sharedAlbumId);
    map['asset_id'] = Variable<String>(assetId);
    map['author_name'] = Variable<String>(authorName);
    map['body'] = Variable<String>(body);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SharedCommentsCompanion toCompanion(bool nullToAbsent) {
    return SharedCommentsCompanion(
      id: Value(id),
      sharedAlbumId: Value(sharedAlbumId),
      assetId: Value(assetId),
      authorName: Value(authorName),
      body: Value(body),
      createdAt: Value(createdAt),
    );
  }

  factory SharedComment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SharedComment(
      id: serializer.fromJson<String>(json['id']),
      sharedAlbumId: serializer.fromJson<String>(json['sharedAlbumId']),
      assetId: serializer.fromJson<String>(json['assetId']),
      authorName: serializer.fromJson<String>(json['authorName']),
      body: serializer.fromJson<String>(json['body']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sharedAlbumId': serializer.toJson<String>(sharedAlbumId),
      'assetId': serializer.toJson<String>(assetId),
      'authorName': serializer.toJson<String>(authorName),
      'body': serializer.toJson<String>(body),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SharedComment copyWith(
          {String? id,
          String? sharedAlbumId,
          String? assetId,
          String? authorName,
          String? body,
          DateTime? createdAt}) =>
      SharedComment(
        id: id ?? this.id,
        sharedAlbumId: sharedAlbumId ?? this.sharedAlbumId,
        assetId: assetId ?? this.assetId,
        authorName: authorName ?? this.authorName,
        body: body ?? this.body,
        createdAt: createdAt ?? this.createdAt,
      );
  SharedComment copyWithCompanion(SharedCommentsCompanion data) {
    return SharedComment(
      id: data.id.present ? data.id.value : this.id,
      sharedAlbumId: data.sharedAlbumId.present
          ? data.sharedAlbumId.value
          : this.sharedAlbumId,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      authorName:
          data.authorName.present ? data.authorName.value : this.authorName,
      body: data.body.present ? data.body.value : this.body,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SharedComment(')
          ..write('id: $id, ')
          ..write('sharedAlbumId: $sharedAlbumId, ')
          ..write('assetId: $assetId, ')
          ..write('authorName: $authorName, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sharedAlbumId, assetId, authorName, body, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SharedComment &&
          other.id == this.id &&
          other.sharedAlbumId == this.sharedAlbumId &&
          other.assetId == this.assetId &&
          other.authorName == this.authorName &&
          other.body == this.body &&
          other.createdAt == this.createdAt);
}

class SharedCommentsCompanion extends UpdateCompanion<SharedComment> {
  final Value<String> id;
  final Value<String> sharedAlbumId;
  final Value<String> assetId;
  final Value<String> authorName;
  final Value<String> body;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SharedCommentsCompanion({
    this.id = const Value.absent(),
    this.sharedAlbumId = const Value.absent(),
    this.assetId = const Value.absent(),
    this.authorName = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SharedCommentsCompanion.insert({
    required String id,
    required String sharedAlbumId,
    required String assetId,
    required String authorName,
    required String body,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sharedAlbumId = Value(sharedAlbumId),
        assetId = Value(assetId),
        authorName = Value(authorName),
        body = Value(body),
        createdAt = Value(createdAt);
  static Insertable<SharedComment> custom({
    Expression<String>? id,
    Expression<String>? sharedAlbumId,
    Expression<String>? assetId,
    Expression<String>? authorName,
    Expression<String>? body,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sharedAlbumId != null) 'shared_album_id': sharedAlbumId,
      if (assetId != null) 'asset_id': assetId,
      if (authorName != null) 'author_name': authorName,
      if (body != null) 'body': body,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SharedCommentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? sharedAlbumId,
      Value<String>? assetId,
      Value<String>? authorName,
      Value<String>? body,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SharedCommentsCompanion(
      id: id ?? this.id,
      sharedAlbumId: sharedAlbumId ?? this.sharedAlbumId,
      assetId: assetId ?? this.assetId,
      authorName: authorName ?? this.authorName,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sharedAlbumId.present) {
      map['shared_album_id'] = Variable<String>(sharedAlbumId.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<String>(assetId.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SharedCommentsCompanion(')
          ..write('id: $id, ')
          ..write('sharedAlbumId: $sharedAlbumId, ')
          ..write('assetId: $assetId, ')
          ..write('authorName: $authorName, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SharedReactionsTable extends SharedReactions
    with TableInfo<$SharedReactionsTable, SharedReaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SharedReactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sharedAlbumIdMeta =
      const VerificationMeta('sharedAlbumId');
  @override
  late final GeneratedColumn<String> sharedAlbumId = GeneratedColumn<String>(
      'shared_album_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assetIdMeta =
      const VerificationMeta('assetId');
  @override
  late final GeneratedColumn<String> assetId = GeneratedColumn<String>(
      'asset_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorNameMeta =
      const VerificationMeta('authorName');
  @override
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
      'author_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reactionMeta =
      const VerificationMeta('reaction');
  @override
  late final GeneratedColumn<String> reaction = GeneratedColumn<String>(
      'reaction', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sharedAlbumId, assetId, authorName, reaction, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shared_reactions';
  @override
  VerificationContext validateIntegrity(Insertable<SharedReaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shared_album_id')) {
      context.handle(
          _sharedAlbumIdMeta,
          sharedAlbumId.isAcceptableOrUnknown(
              data['shared_album_id']!, _sharedAlbumIdMeta));
    } else if (isInserting) {
      context.missing(_sharedAlbumIdMeta);
    }
    if (data.containsKey('asset_id')) {
      context.handle(_assetIdMeta,
          assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta));
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('author_name')) {
      context.handle(
          _authorNameMeta,
          authorName.isAcceptableOrUnknown(
              data['author_name']!, _authorNameMeta));
    } else if (isInserting) {
      context.missing(_authorNameMeta);
    }
    if (data.containsKey('reaction')) {
      context.handle(_reactionMeta,
          reaction.isAcceptableOrUnknown(data['reaction']!, _reactionMeta));
    } else if (isInserting) {
      context.missing(_reactionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SharedReaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SharedReaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sharedAlbumId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}shared_album_id'])!,
      assetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}asset_id'])!,
      authorName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_name'])!,
      reaction: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reaction'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SharedReactionsTable createAlias(String alias) {
    return $SharedReactionsTable(attachedDatabase, alias);
  }
}

class SharedReaction extends DataClass implements Insertable<SharedReaction> {
  final String id;
  final String sharedAlbumId;
  final String assetId;
  final String authorName;
  final String reaction;
  final DateTime createdAt;
  const SharedReaction(
      {required this.id,
      required this.sharedAlbumId,
      required this.assetId,
      required this.authorName,
      required this.reaction,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shared_album_id'] = Variable<String>(sharedAlbumId);
    map['asset_id'] = Variable<String>(assetId);
    map['author_name'] = Variable<String>(authorName);
    map['reaction'] = Variable<String>(reaction);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SharedReactionsCompanion toCompanion(bool nullToAbsent) {
    return SharedReactionsCompanion(
      id: Value(id),
      sharedAlbumId: Value(sharedAlbumId),
      assetId: Value(assetId),
      authorName: Value(authorName),
      reaction: Value(reaction),
      createdAt: Value(createdAt),
    );
  }

  factory SharedReaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SharedReaction(
      id: serializer.fromJson<String>(json['id']),
      sharedAlbumId: serializer.fromJson<String>(json['sharedAlbumId']),
      assetId: serializer.fromJson<String>(json['assetId']),
      authorName: serializer.fromJson<String>(json['authorName']),
      reaction: serializer.fromJson<String>(json['reaction']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sharedAlbumId': serializer.toJson<String>(sharedAlbumId),
      'assetId': serializer.toJson<String>(assetId),
      'authorName': serializer.toJson<String>(authorName),
      'reaction': serializer.toJson<String>(reaction),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SharedReaction copyWith(
          {String? id,
          String? sharedAlbumId,
          String? assetId,
          String? authorName,
          String? reaction,
          DateTime? createdAt}) =>
      SharedReaction(
        id: id ?? this.id,
        sharedAlbumId: sharedAlbumId ?? this.sharedAlbumId,
        assetId: assetId ?? this.assetId,
        authorName: authorName ?? this.authorName,
        reaction: reaction ?? this.reaction,
        createdAt: createdAt ?? this.createdAt,
      );
  SharedReaction copyWithCompanion(SharedReactionsCompanion data) {
    return SharedReaction(
      id: data.id.present ? data.id.value : this.id,
      sharedAlbumId: data.sharedAlbumId.present
          ? data.sharedAlbumId.value
          : this.sharedAlbumId,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      authorName:
          data.authorName.present ? data.authorName.value : this.authorName,
      reaction: data.reaction.present ? data.reaction.value : this.reaction,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SharedReaction(')
          ..write('id: $id, ')
          ..write('sharedAlbumId: $sharedAlbumId, ')
          ..write('assetId: $assetId, ')
          ..write('authorName: $authorName, ')
          ..write('reaction: $reaction, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sharedAlbumId, assetId, authorName, reaction, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SharedReaction &&
          other.id == this.id &&
          other.sharedAlbumId == this.sharedAlbumId &&
          other.assetId == this.assetId &&
          other.authorName == this.authorName &&
          other.reaction == this.reaction &&
          other.createdAt == this.createdAt);
}

class SharedReactionsCompanion extends UpdateCompanion<SharedReaction> {
  final Value<String> id;
  final Value<String> sharedAlbumId;
  final Value<String> assetId;
  final Value<String> authorName;
  final Value<String> reaction;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SharedReactionsCompanion({
    this.id = const Value.absent(),
    this.sharedAlbumId = const Value.absent(),
    this.assetId = const Value.absent(),
    this.authorName = const Value.absent(),
    this.reaction = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SharedReactionsCompanion.insert({
    required String id,
    required String sharedAlbumId,
    required String assetId,
    required String authorName,
    required String reaction,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sharedAlbumId = Value(sharedAlbumId),
        assetId = Value(assetId),
        authorName = Value(authorName),
        reaction = Value(reaction),
        createdAt = Value(createdAt);
  static Insertable<SharedReaction> custom({
    Expression<String>? id,
    Expression<String>? sharedAlbumId,
    Expression<String>? assetId,
    Expression<String>? authorName,
    Expression<String>? reaction,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sharedAlbumId != null) 'shared_album_id': sharedAlbumId,
      if (assetId != null) 'asset_id': assetId,
      if (authorName != null) 'author_name': authorName,
      if (reaction != null) 'reaction': reaction,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SharedReactionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? sharedAlbumId,
      Value<String>? assetId,
      Value<String>? authorName,
      Value<String>? reaction,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SharedReactionsCompanion(
      id: id ?? this.id,
      sharedAlbumId: sharedAlbumId ?? this.sharedAlbumId,
      assetId: assetId ?? this.assetId,
      authorName: authorName ?? this.authorName,
      reaction: reaction ?? this.reaction,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sharedAlbumId.present) {
      map['shared_album_id'] = Variable<String>(sharedAlbumId.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<String>(assetId.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (reaction.present) {
      map['reaction'] = Variable<String>(reaction.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SharedReactionsCompanion(')
          ..write('id: $id, ')
          ..write('sharedAlbumId: $sharedAlbumId, ')
          ..write('assetId: $assetId, ')
          ..write('authorName: $authorName, ')
          ..write('reaction: $reaction, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InviteIdentitiesTable extends InviteIdentities
    with TableInfo<$InviteIdentitiesTable, InviteIdentity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InviteIdentitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _inviteCodeMeta =
      const VerificationMeta('inviteCode');
  @override
  late final GeneratedColumn<String> inviteCode = GeneratedColumn<String>(
      'invite_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, inviteCode, role, displayName, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invite_identities';
  @override
  VerificationContext validateIntegrity(Insertable<InviteIdentity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('invite_code')) {
      context.handle(
          _inviteCodeMeta,
          inviteCode.isAcceptableOrUnknown(
              data['invite_code']!, _inviteCodeMeta));
    } else if (isInserting) {
      context.missing(_inviteCodeMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InviteIdentity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InviteIdentity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      inviteCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invite_code'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $InviteIdentitiesTable createAlias(String alias) {
    return $InviteIdentitiesTable(attachedDatabase, alias);
  }
}

class InviteIdentity extends DataClass implements Insertable<InviteIdentity> {
  final String id;
  final String inviteCode;
  final String role;
  final String displayName;
  final DateTime createdAt;
  const InviteIdentity(
      {required this.id,
      required this.inviteCode,
      required this.role,
      required this.displayName,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['invite_code'] = Variable<String>(inviteCode);
    map['role'] = Variable<String>(role);
    map['display_name'] = Variable<String>(displayName);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InviteIdentitiesCompanion toCompanion(bool nullToAbsent) {
    return InviteIdentitiesCompanion(
      id: Value(id),
      inviteCode: Value(inviteCode),
      role: Value(role),
      displayName: Value(displayName),
      createdAt: Value(createdAt),
    );
  }

  factory InviteIdentity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InviteIdentity(
      id: serializer.fromJson<String>(json['id']),
      inviteCode: serializer.fromJson<String>(json['inviteCode']),
      role: serializer.fromJson<String>(json['role']),
      displayName: serializer.fromJson<String>(json['displayName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'inviteCode': serializer.toJson<String>(inviteCode),
      'role': serializer.toJson<String>(role),
      'displayName': serializer.toJson<String>(displayName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InviteIdentity copyWith(
          {String? id,
          String? inviteCode,
          String? role,
          String? displayName,
          DateTime? createdAt}) =>
      InviteIdentity(
        id: id ?? this.id,
        inviteCode: inviteCode ?? this.inviteCode,
        role: role ?? this.role,
        displayName: displayName ?? this.displayName,
        createdAt: createdAt ?? this.createdAt,
      );
  InviteIdentity copyWithCompanion(InviteIdentitiesCompanion data) {
    return InviteIdentity(
      id: data.id.present ? data.id.value : this.id,
      inviteCode:
          data.inviteCode.present ? data.inviteCode.value : this.inviteCode,
      role: data.role.present ? data.role.value : this.role,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InviteIdentity(')
          ..write('id: $id, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('role: $role, ')
          ..write('displayName: $displayName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, inviteCode, role, displayName, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InviteIdentity &&
          other.id == this.id &&
          other.inviteCode == this.inviteCode &&
          other.role == this.role &&
          other.displayName == this.displayName &&
          other.createdAt == this.createdAt);
}

class InviteIdentitiesCompanion extends UpdateCompanion<InviteIdentity> {
  final Value<String> id;
  final Value<String> inviteCode;
  final Value<String> role;
  final Value<String> displayName;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const InviteIdentitiesCompanion({
    this.id = const Value.absent(),
    this.inviteCode = const Value.absent(),
    this.role = const Value.absent(),
    this.displayName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InviteIdentitiesCompanion.insert({
    required String id,
    required String inviteCode,
    required String role,
    required String displayName,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        inviteCode = Value(inviteCode),
        role = Value(role),
        displayName = Value(displayName),
        createdAt = Value(createdAt);
  static Insertable<InviteIdentity> custom({
    Expression<String>? id,
    Expression<String>? inviteCode,
    Expression<String>? role,
    Expression<String>? displayName,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (inviteCode != null) 'invite_code': inviteCode,
      if (role != null) 'role': role,
      if (displayName != null) 'display_name': displayName,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InviteIdentitiesCompanion copyWith(
      {Value<String>? id,
      Value<String>? inviteCode,
      Value<String>? role,
      Value<String>? displayName,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return InviteIdentitiesCompanion(
      id: id ?? this.id,
      inviteCode: inviteCode ?? this.inviteCode,
      role: role ?? this.role,
      displayName: displayName ?? this.displayName,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (inviteCode.present) {
      map['invite_code'] = Variable<String>(inviteCode.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InviteIdentitiesCompanion(')
          ..write('id: $id, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('role: $role, ')
          ..write('displayName: $displayName, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecycleBinEntriesTable extends RecycleBinEntries
    with TableInfo<$RecycleBinEntriesTable, RecycleBinEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecycleBinEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _assetIdMeta =
      const VerificationMeta('assetId');
  @override
  late final GeneratedColumn<String> assetId = GeneratedColumn<String>(
      'asset_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _originalAlbumIdsCsvMeta =
      const VerificationMeta('originalAlbumIdsCsv');
  @override
  late final GeneratedColumn<String> originalAlbumIdsCsv =
      GeneratedColumn<String>('original_album_ids_csv', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns =>
      [assetId, deletedAt, originalAlbumIdsCsv];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recycle_bin_entries';
  @override
  VerificationContext validateIntegrity(Insertable<RecycleBinEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('asset_id')) {
      context.handle(_assetIdMeta,
          assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta));
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    } else if (isInserting) {
      context.missing(_deletedAtMeta);
    }
    if (data.containsKey('original_album_ids_csv')) {
      context.handle(
          _originalAlbumIdsCsvMeta,
          originalAlbumIdsCsv.isAcceptableOrUnknown(
              data['original_album_ids_csv']!, _originalAlbumIdsCsvMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {assetId};
  @override
  RecycleBinEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecycleBinEntry(
      assetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}asset_id'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at'])!,
      originalAlbumIdsCsv: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}original_album_ids_csv'])!,
    );
  }

  @override
  $RecycleBinEntriesTable createAlias(String alias) {
    return $RecycleBinEntriesTable(attachedDatabase, alias);
  }
}

class RecycleBinEntry extends DataClass implements Insertable<RecycleBinEntry> {
  final String assetId;
  final DateTime deletedAt;
  final String originalAlbumIdsCsv;
  const RecycleBinEntry(
      {required this.assetId,
      required this.deletedAt,
      required this.originalAlbumIdsCsv});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['asset_id'] = Variable<String>(assetId);
    map['deleted_at'] = Variable<DateTime>(deletedAt);
    map['original_album_ids_csv'] = Variable<String>(originalAlbumIdsCsv);
    return map;
  }

  RecycleBinEntriesCompanion toCompanion(bool nullToAbsent) {
    return RecycleBinEntriesCompanion(
      assetId: Value(assetId),
      deletedAt: Value(deletedAt),
      originalAlbumIdsCsv: Value(originalAlbumIdsCsv),
    );
  }

  factory RecycleBinEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecycleBinEntry(
      assetId: serializer.fromJson<String>(json['assetId']),
      deletedAt: serializer.fromJson<DateTime>(json['deletedAt']),
      originalAlbumIdsCsv:
          serializer.fromJson<String>(json['originalAlbumIdsCsv']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'assetId': serializer.toJson<String>(assetId),
      'deletedAt': serializer.toJson<DateTime>(deletedAt),
      'originalAlbumIdsCsv': serializer.toJson<String>(originalAlbumIdsCsv),
    };
  }

  RecycleBinEntry copyWith(
          {String? assetId,
          DateTime? deletedAt,
          String? originalAlbumIdsCsv}) =>
      RecycleBinEntry(
        assetId: assetId ?? this.assetId,
        deletedAt: deletedAt ?? this.deletedAt,
        originalAlbumIdsCsv: originalAlbumIdsCsv ?? this.originalAlbumIdsCsv,
      );
  RecycleBinEntry copyWithCompanion(RecycleBinEntriesCompanion data) {
    return RecycleBinEntry(
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      originalAlbumIdsCsv: data.originalAlbumIdsCsv.present
          ? data.originalAlbumIdsCsv.value
          : this.originalAlbumIdsCsv,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecycleBinEntry(')
          ..write('assetId: $assetId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('originalAlbumIdsCsv: $originalAlbumIdsCsv')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(assetId, deletedAt, originalAlbumIdsCsv);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecycleBinEntry &&
          other.assetId == this.assetId &&
          other.deletedAt == this.deletedAt &&
          other.originalAlbumIdsCsv == this.originalAlbumIdsCsv);
}

class RecycleBinEntriesCompanion extends UpdateCompanion<RecycleBinEntry> {
  final Value<String> assetId;
  final Value<DateTime> deletedAt;
  final Value<String> originalAlbumIdsCsv;
  final Value<int> rowid;
  const RecycleBinEntriesCompanion({
    this.assetId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.originalAlbumIdsCsv = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecycleBinEntriesCompanion.insert({
    required String assetId,
    required DateTime deletedAt,
    this.originalAlbumIdsCsv = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : assetId = Value(assetId),
        deletedAt = Value(deletedAt);
  static Insertable<RecycleBinEntry> custom({
    Expression<String>? assetId,
    Expression<DateTime>? deletedAt,
    Expression<String>? originalAlbumIdsCsv,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (assetId != null) 'asset_id': assetId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (originalAlbumIdsCsv != null)
        'original_album_ids_csv': originalAlbumIdsCsv,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecycleBinEntriesCompanion copyWith(
      {Value<String>? assetId,
      Value<DateTime>? deletedAt,
      Value<String>? originalAlbumIdsCsv,
      Value<int>? rowid}) {
    return RecycleBinEntriesCompanion(
      assetId: assetId ?? this.assetId,
      deletedAt: deletedAt ?? this.deletedAt,
      originalAlbumIdsCsv: originalAlbumIdsCsv ?? this.originalAlbumIdsCsv,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (assetId.present) {
      map['asset_id'] = Variable<String>(assetId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (originalAlbumIdsCsv.present) {
      map['original_album_ids_csv'] =
          Variable<String>(originalAlbumIdsCsv.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecycleBinEntriesCompanion(')
          ..write('assetId: $assetId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('originalAlbumIdsCsv: $originalAlbumIdsCsv, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MediaAssetsTable mediaAssets = $MediaAssetsTable(this);
  late final $AlbumsTable albums = $AlbumsTable(this);
  late final $AlbumAssetsTable albumAssets = $AlbumAssetsTable(this);
  late final $TimelineBucketsTable timelineBuckets =
      $TimelineBucketsTable(this);
  late final $PlaceClustersTable placeClusters = $PlaceClustersTable(this);
  late final $PeopleEmbeddingsTable peopleEmbeddings =
      $PeopleEmbeddingsTable(this);
  late final $SmartAnalysisResultsTable smartAnalysisResults =
      $SmartAnalysisResultsTable(this);
  late final $CacheRecordsTable cacheRecords = $CacheRecordsTable(this);
  late final $BackupJobsTable backupJobs = $BackupJobsTable(this);
  late final $SharedAlbumsTable sharedAlbums = $SharedAlbumsTable(this);
  late final $SharedCommentsTable sharedComments = $SharedCommentsTable(this);
  late final $SharedReactionsTable sharedReactions =
      $SharedReactionsTable(this);
  late final $InviteIdentitiesTable inviteIdentities =
      $InviteIdentitiesTable(this);
  late final $RecycleBinEntriesTable recycleBinEntries =
      $RecycleBinEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        mediaAssets,
        albums,
        albumAssets,
        timelineBuckets,
        placeClusters,
        peopleEmbeddings,
        smartAnalysisResults,
        cacheRecords,
        backupJobs,
        sharedAlbums,
        sharedComments,
        sharedReactions,
        inviteIdentities,
        recycleBinEntries
      ];
}

typedef $$MediaAssetsTableCreateCompanionBuilder = MediaAssetsCompanion
    Function({
  required String id,
  required String platformId,
  required String fileName,
  required String mediaKind,
  required DateTime createdAt,
  required DateTime addedAt,
  required int width,
  required int height,
  required int sizeBytes,
  Value<String?> folderName,
  Value<String?> cameraMake,
  Value<String?> cameraModel,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String?> placeName,
  Value<bool> isFavorite,
  Value<bool> isHidden,
  Value<bool> isDeleted,
  Value<String> statusesCsv,
  Value<String?> contentHash,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$MediaAssetsTableUpdateCompanionBuilder = MediaAssetsCompanion
    Function({
  Value<String> id,
  Value<String> platformId,
  Value<String> fileName,
  Value<String> mediaKind,
  Value<DateTime> createdAt,
  Value<DateTime> addedAt,
  Value<int> width,
  Value<int> height,
  Value<int> sizeBytes,
  Value<String?> folderName,
  Value<String?> cameraMake,
  Value<String?> cameraModel,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String?> placeName,
  Value<bool> isFavorite,
  Value<bool> isHidden,
  Value<bool> isDeleted,
  Value<String> statusesCsv,
  Value<String?> contentHash,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$MediaAssetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MediaAssetsTable,
    MediaAsset,
    $$MediaAssetsTableFilterComposer,
    $$MediaAssetsTableOrderingComposer,
    $$MediaAssetsTableCreateCompanionBuilder,
    $$MediaAssetsTableUpdateCompanionBuilder> {
  $$MediaAssetsTableTableManager(_$AppDatabase db, $MediaAssetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MediaAssetsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MediaAssetsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> platformId = const Value.absent(),
            Value<String> fileName = const Value.absent(),
            Value<String> mediaKind = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> addedAt = const Value.absent(),
            Value<int> width = const Value.absent(),
            Value<int> height = const Value.absent(),
            Value<int> sizeBytes = const Value.absent(),
            Value<String?> folderName = const Value.absent(),
            Value<String?> cameraMake = const Value.absent(),
            Value<String?> cameraModel = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String?> placeName = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<bool> isHidden = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<String> statusesCsv = const Value.absent(),
            Value<String?> contentHash = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MediaAssetsCompanion(
            id: id,
            platformId: platformId,
            fileName: fileName,
            mediaKind: mediaKind,
            createdAt: createdAt,
            addedAt: addedAt,
            width: width,
            height: height,
            sizeBytes: sizeBytes,
            folderName: folderName,
            cameraMake: cameraMake,
            cameraModel: cameraModel,
            latitude: latitude,
            longitude: longitude,
            placeName: placeName,
            isFavorite: isFavorite,
            isHidden: isHidden,
            isDeleted: isDeleted,
            statusesCsv: statusesCsv,
            contentHash: contentHash,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String platformId,
            required String fileName,
            required String mediaKind,
            required DateTime createdAt,
            required DateTime addedAt,
            required int width,
            required int height,
            required int sizeBytes,
            Value<String?> folderName = const Value.absent(),
            Value<String?> cameraMake = const Value.absent(),
            Value<String?> cameraModel = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String?> placeName = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<bool> isHidden = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<String> statusesCsv = const Value.absent(),
            Value<String?> contentHash = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              MediaAssetsCompanion.insert(
            id: id,
            platformId: platformId,
            fileName: fileName,
            mediaKind: mediaKind,
            createdAt: createdAt,
            addedAt: addedAt,
            width: width,
            height: height,
            sizeBytes: sizeBytes,
            folderName: folderName,
            cameraMake: cameraMake,
            cameraModel: cameraModel,
            latitude: latitude,
            longitude: longitude,
            placeName: placeName,
            isFavorite: isFavorite,
            isHidden: isHidden,
            isDeleted: isDeleted,
            statusesCsv: statusesCsv,
            contentHash: contentHash,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$MediaAssetsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $MediaAssetsTable> {
  $$MediaAssetsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get platformId => $state.composableBuilder(
      column: $state.table.platformId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get fileName => $state.composableBuilder(
      column: $state.table.fileName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get mediaKind => $state.composableBuilder(
      column: $state.table.mediaKind,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get addedAt => $state.composableBuilder(
      column: $state.table.addedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get width => $state.composableBuilder(
      column: $state.table.width,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get height => $state.composableBuilder(
      column: $state.table.height,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sizeBytes => $state.composableBuilder(
      column: $state.table.sizeBytes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get folderName => $state.composableBuilder(
      column: $state.table.folderName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get cameraMake => $state.composableBuilder(
      column: $state.table.cameraMake,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get cameraModel => $state.composableBuilder(
      column: $state.table.cameraModel,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get longitude => $state.composableBuilder(
      column: $state.table.longitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get placeName => $state.composableBuilder(
      column: $state.table.placeName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isFavorite => $state.composableBuilder(
      column: $state.table.isFavorite,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isHidden => $state.composableBuilder(
      column: $state.table.isHidden,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isDeleted => $state.composableBuilder(
      column: $state.table.isDeleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get statusesCsv => $state.composableBuilder(
      column: $state.table.statusesCsv,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get contentHash => $state.composableBuilder(
      column: $state.table.contentHash,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$MediaAssetsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $MediaAssetsTable> {
  $$MediaAssetsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get platformId => $state.composableBuilder(
      column: $state.table.platformId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get fileName => $state.composableBuilder(
      column: $state.table.fileName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get mediaKind => $state.composableBuilder(
      column: $state.table.mediaKind,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get addedAt => $state.composableBuilder(
      column: $state.table.addedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get width => $state.composableBuilder(
      column: $state.table.width,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get height => $state.composableBuilder(
      column: $state.table.height,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sizeBytes => $state.composableBuilder(
      column: $state.table.sizeBytes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get folderName => $state.composableBuilder(
      column: $state.table.folderName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get cameraMake => $state.composableBuilder(
      column: $state.table.cameraMake,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get cameraModel => $state.composableBuilder(
      column: $state.table.cameraModel,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get longitude => $state.composableBuilder(
      column: $state.table.longitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get placeName => $state.composableBuilder(
      column: $state.table.placeName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isFavorite => $state.composableBuilder(
      column: $state.table.isFavorite,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isHidden => $state.composableBuilder(
      column: $state.table.isHidden,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isDeleted => $state.composableBuilder(
      column: $state.table.isDeleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get statusesCsv => $state.composableBuilder(
      column: $state.table.statusesCsv,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get contentHash => $state.composableBuilder(
      column: $state.table.contentHash,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$AlbumsTableCreateCompanionBuilder = AlbumsCompanion Function({
  required String id,
  required String title,
  Value<String?> sourceFolder,
  Value<String?> coverAssetId,
  Value<bool> isAuto,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$AlbumsTableUpdateCompanionBuilder = AlbumsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> sourceFolder,
  Value<String?> coverAssetId,
  Value<bool> isAuto,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$AlbumsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AlbumsTable,
    Album,
    $$AlbumsTableFilterComposer,
    $$AlbumsTableOrderingComposer,
    $$AlbumsTableCreateCompanionBuilder,
    $$AlbumsTableUpdateCompanionBuilder> {
  $$AlbumsTableTableManager(_$AppDatabase db, $AlbumsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AlbumsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AlbumsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> sourceFolder = const Value.absent(),
            Value<String?> coverAssetId = const Value.absent(),
            Value<bool> isAuto = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlbumsCompanion(
            id: id,
            title: title,
            sourceFolder: sourceFolder,
            coverAssetId: coverAssetId,
            isAuto: isAuto,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> sourceFolder = const Value.absent(),
            Value<String?> coverAssetId = const Value.absent(),
            Value<bool> isAuto = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AlbumsCompanion.insert(
            id: id,
            title: title,
            sourceFolder: sourceFolder,
            coverAssetId: coverAssetId,
            isAuto: isAuto,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$AlbumsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AlbumsTable> {
  $$AlbumsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sourceFolder => $state.composableBuilder(
      column: $state.table.sourceFolder,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get coverAssetId => $state.composableBuilder(
      column: $state.table.coverAssetId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isAuto => $state.composableBuilder(
      column: $state.table.isAuto,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AlbumsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AlbumsTable> {
  $$AlbumsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sourceFolder => $state.composableBuilder(
      column: $state.table.sourceFolder,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get coverAssetId => $state.composableBuilder(
      column: $state.table.coverAssetId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isAuto => $state.composableBuilder(
      column: $state.table.isAuto,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$AlbumAssetsTableCreateCompanionBuilder = AlbumAssetsCompanion
    Function({
  required String albumId,
  required String assetId,
  Value<int> sortOrder,
  required DateTime addedAt,
  Value<int> rowid,
});
typedef $$AlbumAssetsTableUpdateCompanionBuilder = AlbumAssetsCompanion
    Function({
  Value<String> albumId,
  Value<String> assetId,
  Value<int> sortOrder,
  Value<DateTime> addedAt,
  Value<int> rowid,
});

class $$AlbumAssetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AlbumAssetsTable,
    AlbumAsset,
    $$AlbumAssetsTableFilterComposer,
    $$AlbumAssetsTableOrderingComposer,
    $$AlbumAssetsTableCreateCompanionBuilder,
    $$AlbumAssetsTableUpdateCompanionBuilder> {
  $$AlbumAssetsTableTableManager(_$AppDatabase db, $AlbumAssetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AlbumAssetsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AlbumAssetsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> albumId = const Value.absent(),
            Value<String> assetId = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<DateTime> addedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlbumAssetsCompanion(
            albumId: albumId,
            assetId: assetId,
            sortOrder: sortOrder,
            addedAt: addedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String albumId,
            required String assetId,
            Value<int> sortOrder = const Value.absent(),
            required DateTime addedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AlbumAssetsCompanion.insert(
            albumId: albumId,
            assetId: assetId,
            sortOrder: sortOrder,
            addedAt: addedAt,
            rowid: rowid,
          ),
        ));
}

class $$AlbumAssetsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AlbumAssetsTable> {
  $$AlbumAssetsTableFilterComposer(super.$state);
  ColumnFilters<String> get albumId => $state.composableBuilder(
      column: $state.table.albumId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sortOrder => $state.composableBuilder(
      column: $state.table.sortOrder,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get addedAt => $state.composableBuilder(
      column: $state.table.addedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AlbumAssetsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AlbumAssetsTable> {
  $$AlbumAssetsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get albumId => $state.composableBuilder(
      column: $state.table.albumId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sortOrder => $state.composableBuilder(
      column: $state.table.sortOrder,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get addedAt => $state.composableBuilder(
      column: $state.table.addedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TimelineBucketsTableCreateCompanionBuilder = TimelineBucketsCompanion
    Function({
  required String id,
  required String title,
  required DateTime startAt,
  required DateTime endAt,
  Value<int> assetCount,
  Value<int> rowid,
});
typedef $$TimelineBucketsTableUpdateCompanionBuilder = TimelineBucketsCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<DateTime> startAt,
  Value<DateTime> endAt,
  Value<int> assetCount,
  Value<int> rowid,
});

class $$TimelineBucketsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TimelineBucketsTable,
    TimelineBucket,
    $$TimelineBucketsTableFilterComposer,
    $$TimelineBucketsTableOrderingComposer,
    $$TimelineBucketsTableCreateCompanionBuilder,
    $$TimelineBucketsTableUpdateCompanionBuilder> {
  $$TimelineBucketsTableTableManager(
      _$AppDatabase db, $TimelineBucketsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TimelineBucketsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TimelineBucketsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> startAt = const Value.absent(),
            Value<DateTime> endAt = const Value.absent(),
            Value<int> assetCount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimelineBucketsCompanion(
            id: id,
            title: title,
            startAt: startAt,
            endAt: endAt,
            assetCount: assetCount,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required DateTime startAt,
            required DateTime endAt,
            Value<int> assetCount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimelineBucketsCompanion.insert(
            id: id,
            title: title,
            startAt: startAt,
            endAt: endAt,
            assetCount: assetCount,
            rowid: rowid,
          ),
        ));
}

class $$TimelineBucketsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TimelineBucketsTable> {
  $$TimelineBucketsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get startAt => $state.composableBuilder(
      column: $state.table.startAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get endAt => $state.composableBuilder(
      column: $state.table.endAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get assetCount => $state.composableBuilder(
      column: $state.table.assetCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TimelineBucketsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TimelineBucketsTable> {
  $$TimelineBucketsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get startAt => $state.composableBuilder(
      column: $state.table.startAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get endAt => $state.composableBuilder(
      column: $state.table.endAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get assetCount => $state.composableBuilder(
      column: $state.table.assetCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PlaceClustersTableCreateCompanionBuilder = PlaceClustersCompanion
    Function({
  required String id,
  required String name,
  Value<String?> country,
  required double latitude,
  required double longitude,
  Value<int> assetCount,
  Value<int> rowid,
});
typedef $$PlaceClustersTableUpdateCompanionBuilder = PlaceClustersCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> country,
  Value<double> latitude,
  Value<double> longitude,
  Value<int> assetCount,
  Value<int> rowid,
});

class $$PlaceClustersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlaceClustersTable,
    PlaceCluster,
    $$PlaceClustersTableFilterComposer,
    $$PlaceClustersTableOrderingComposer,
    $$PlaceClustersTableCreateCompanionBuilder,
    $$PlaceClustersTableUpdateCompanionBuilder> {
  $$PlaceClustersTableTableManager(_$AppDatabase db, $PlaceClustersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PlaceClustersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PlaceClustersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> country = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<int> assetCount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaceClustersCompanion(
            id: id,
            name: name,
            country: country,
            latitude: latitude,
            longitude: longitude,
            assetCount: assetCount,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> country = const Value.absent(),
            required double latitude,
            required double longitude,
            Value<int> assetCount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaceClustersCompanion.insert(
            id: id,
            name: name,
            country: country,
            latitude: latitude,
            longitude: longitude,
            assetCount: assetCount,
            rowid: rowid,
          ),
        ));
}

class $$PlaceClustersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PlaceClustersTable> {
  $$PlaceClustersTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get country => $state.composableBuilder(
      column: $state.table.country,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get longitude => $state.composableBuilder(
      column: $state.table.longitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get assetCount => $state.composableBuilder(
      column: $state.table.assetCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$PlaceClustersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PlaceClustersTable> {
  $$PlaceClustersTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get country => $state.composableBuilder(
      column: $state.table.country,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get longitude => $state.composableBuilder(
      column: $state.table.longitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get assetCount => $state.composableBuilder(
      column: $state.table.assetCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PeopleEmbeddingsTableCreateCompanionBuilder
    = PeopleEmbeddingsCompanion Function({
  required String id,
  required String displayName,
  required String embeddingJson,
  Value<int> faceCount,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$PeopleEmbeddingsTableUpdateCompanionBuilder
    = PeopleEmbeddingsCompanion Function({
  Value<String> id,
  Value<String> displayName,
  Value<String> embeddingJson,
  Value<int> faceCount,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$PeopleEmbeddingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PeopleEmbeddingsTable,
    PeopleEmbedding,
    $$PeopleEmbeddingsTableFilterComposer,
    $$PeopleEmbeddingsTableOrderingComposer,
    $$PeopleEmbeddingsTableCreateCompanionBuilder,
    $$PeopleEmbeddingsTableUpdateCompanionBuilder> {
  $$PeopleEmbeddingsTableTableManager(
      _$AppDatabase db, $PeopleEmbeddingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PeopleEmbeddingsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PeopleEmbeddingsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<String> embeddingJson = const Value.absent(),
            Value<int> faceCount = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PeopleEmbeddingsCompanion(
            id: id,
            displayName: displayName,
            embeddingJson: embeddingJson,
            faceCount: faceCount,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String displayName,
            required String embeddingJson,
            Value<int> faceCount = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PeopleEmbeddingsCompanion.insert(
            id: id,
            displayName: displayName,
            embeddingJson: embeddingJson,
            faceCount: faceCount,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$PeopleEmbeddingsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PeopleEmbeddingsTable> {
  $$PeopleEmbeddingsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get displayName => $state.composableBuilder(
      column: $state.table.displayName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get embeddingJson => $state.composableBuilder(
      column: $state.table.embeddingJson,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get faceCount => $state.composableBuilder(
      column: $state.table.faceCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$PeopleEmbeddingsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PeopleEmbeddingsTable> {
  $$PeopleEmbeddingsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get displayName => $state.composableBuilder(
      column: $state.table.displayName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get embeddingJson => $state.composableBuilder(
      column: $state.table.embeddingJson,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get faceCount => $state.composableBuilder(
      column: $state.table.faceCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SmartAnalysisResultsTableCreateCompanionBuilder
    = SmartAnalysisResultsCompanion Function({
  required String id,
  required String assetId,
  required String jobKind,
  required String resultJson,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$SmartAnalysisResultsTableUpdateCompanionBuilder
    = SmartAnalysisResultsCompanion Function({
  Value<String> id,
  Value<String> assetId,
  Value<String> jobKind,
  Value<String> resultJson,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$SmartAnalysisResultsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SmartAnalysisResultsTable,
    SmartAnalysisResult,
    $$SmartAnalysisResultsTableFilterComposer,
    $$SmartAnalysisResultsTableOrderingComposer,
    $$SmartAnalysisResultsTableCreateCompanionBuilder,
    $$SmartAnalysisResultsTableUpdateCompanionBuilder> {
  $$SmartAnalysisResultsTableTableManager(
      _$AppDatabase db, $SmartAnalysisResultsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$SmartAnalysisResultsTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$SmartAnalysisResultsTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> assetId = const Value.absent(),
            Value<String> jobKind = const Value.absent(),
            Value<String> resultJson = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SmartAnalysisResultsCompanion(
            id: id,
            assetId: assetId,
            jobKind: jobKind,
            resultJson: resultJson,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String assetId,
            required String jobKind,
            required String resultJson,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SmartAnalysisResultsCompanion.insert(
            id: id,
            assetId: assetId,
            jobKind: jobKind,
            resultJson: resultJson,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$SmartAnalysisResultsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SmartAnalysisResultsTable> {
  $$SmartAnalysisResultsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get jobKind => $state.composableBuilder(
      column: $state.table.jobKind,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get resultJson => $state.composableBuilder(
      column: $state.table.resultJson,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SmartAnalysisResultsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SmartAnalysisResultsTable> {
  $$SmartAnalysisResultsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get jobKind => $state.composableBuilder(
      column: $state.table.jobKind,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get resultJson => $state.composableBuilder(
      column: $state.table.resultJson,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$CacheRecordsTableCreateCompanionBuilder = CacheRecordsCompanion
    Function({
  required String id,
  required String assetId,
  required String cacheKind,
  required String pathOrValue,
  required String sourceFingerprint,
  required int schemaVersion,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CacheRecordsTableUpdateCompanionBuilder = CacheRecordsCompanion
    Function({
  Value<String> id,
  Value<String> assetId,
  Value<String> cacheKind,
  Value<String> pathOrValue,
  Value<String> sourceFingerprint,
  Value<int> schemaVersion,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CacheRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CacheRecordsTable,
    CacheRecord,
    $$CacheRecordsTableFilterComposer,
    $$CacheRecordsTableOrderingComposer,
    $$CacheRecordsTableCreateCompanionBuilder,
    $$CacheRecordsTableUpdateCompanionBuilder> {
  $$CacheRecordsTableTableManager(_$AppDatabase db, $CacheRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CacheRecordsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CacheRecordsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> assetId = const Value.absent(),
            Value<String> cacheKind = const Value.absent(),
            Value<String> pathOrValue = const Value.absent(),
            Value<String> sourceFingerprint = const Value.absent(),
            Value<int> schemaVersion = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CacheRecordsCompanion(
            id: id,
            assetId: assetId,
            cacheKind: cacheKind,
            pathOrValue: pathOrValue,
            sourceFingerprint: sourceFingerprint,
            schemaVersion: schemaVersion,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String assetId,
            required String cacheKind,
            required String pathOrValue,
            required String sourceFingerprint,
            required int schemaVersion,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CacheRecordsCompanion.insert(
            id: id,
            assetId: assetId,
            cacheKind: cacheKind,
            pathOrValue: pathOrValue,
            sourceFingerprint: sourceFingerprint,
            schemaVersion: schemaVersion,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$CacheRecordsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CacheRecordsTable> {
  $$CacheRecordsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get cacheKind => $state.composableBuilder(
      column: $state.table.cacheKind,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get pathOrValue => $state.composableBuilder(
      column: $state.table.pathOrValue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sourceFingerprint => $state.composableBuilder(
      column: $state.table.sourceFingerprint,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get schemaVersion => $state.composableBuilder(
      column: $state.table.schemaVersion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CacheRecordsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CacheRecordsTable> {
  $$CacheRecordsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get cacheKind => $state.composableBuilder(
      column: $state.table.cacheKind,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get pathOrValue => $state.composableBuilder(
      column: $state.table.pathOrValue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sourceFingerprint => $state.composableBuilder(
      column: $state.table.sourceFingerprint,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get schemaVersion => $state.composableBuilder(
      column: $state.table.schemaVersion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$BackupJobsTableCreateCompanionBuilder = BackupJobsCompanion Function({
  required String id,
  required String assetId,
  required String state,
  Value<String?> remotePath,
  Value<String?> errorMessage,
  Value<int> attempts,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$BackupJobsTableUpdateCompanionBuilder = BackupJobsCompanion Function({
  Value<String> id,
  Value<String> assetId,
  Value<String> state,
  Value<String?> remotePath,
  Value<String?> errorMessage,
  Value<int> attempts,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$BackupJobsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BackupJobsTable,
    BackupJob,
    $$BackupJobsTableFilterComposer,
    $$BackupJobsTableOrderingComposer,
    $$BackupJobsTableCreateCompanionBuilder,
    $$BackupJobsTableUpdateCompanionBuilder> {
  $$BackupJobsTableTableManager(_$AppDatabase db, $BackupJobsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$BackupJobsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$BackupJobsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> assetId = const Value.absent(),
            Value<String> state = const Value.absent(),
            Value<String?> remotePath = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<int> attempts = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BackupJobsCompanion(
            id: id,
            assetId: assetId,
            state: state,
            remotePath: remotePath,
            errorMessage: errorMessage,
            attempts: attempts,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String assetId,
            required String state,
            Value<String?> remotePath = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<int> attempts = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              BackupJobsCompanion.insert(
            id: id,
            assetId: assetId,
            state: state,
            remotePath: remotePath,
            errorMessage: errorMessage,
            attempts: attempts,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$BackupJobsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $BackupJobsTable> {
  $$BackupJobsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get state => $state.composableBuilder(
      column: $state.table.state,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get remotePath => $state.composableBuilder(
      column: $state.table.remotePath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get errorMessage => $state.composableBuilder(
      column: $state.table.errorMessage,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get attempts => $state.composableBuilder(
      column: $state.table.attempts,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$BackupJobsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $BackupJobsTable> {
  $$BackupJobsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get state => $state.composableBuilder(
      column: $state.table.state,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get remotePath => $state.composableBuilder(
      column: $state.table.remotePath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get errorMessage => $state.composableBuilder(
      column: $state.table.errorMessage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get attempts => $state.composableBuilder(
      column: $state.table.attempts,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SharedAlbumsTableCreateCompanionBuilder = SharedAlbumsCompanion
    Function({
  required String id,
  required String title,
  required String ownerName,
  Value<String?> partnerName,
  required String manifestPath,
  Value<bool> isJoined,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$SharedAlbumsTableUpdateCompanionBuilder = SharedAlbumsCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String> ownerName,
  Value<String?> partnerName,
  Value<String> manifestPath,
  Value<bool> isJoined,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$SharedAlbumsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SharedAlbumsTable,
    SharedAlbum,
    $$SharedAlbumsTableFilterComposer,
    $$SharedAlbumsTableOrderingComposer,
    $$SharedAlbumsTableCreateCompanionBuilder,
    $$SharedAlbumsTableUpdateCompanionBuilder> {
  $$SharedAlbumsTableTableManager(_$AppDatabase db, $SharedAlbumsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SharedAlbumsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SharedAlbumsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> ownerName = const Value.absent(),
            Value<String?> partnerName = const Value.absent(),
            Value<String> manifestPath = const Value.absent(),
            Value<bool> isJoined = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SharedAlbumsCompanion(
            id: id,
            title: title,
            ownerName: ownerName,
            partnerName: partnerName,
            manifestPath: manifestPath,
            isJoined: isJoined,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String ownerName,
            Value<String?> partnerName = const Value.absent(),
            required String manifestPath,
            Value<bool> isJoined = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SharedAlbumsCompanion.insert(
            id: id,
            title: title,
            ownerName: ownerName,
            partnerName: partnerName,
            manifestPath: manifestPath,
            isJoined: isJoined,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$SharedAlbumsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SharedAlbumsTable> {
  $$SharedAlbumsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get ownerName => $state.composableBuilder(
      column: $state.table.ownerName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get partnerName => $state.composableBuilder(
      column: $state.table.partnerName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get manifestPath => $state.composableBuilder(
      column: $state.table.manifestPath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isJoined => $state.composableBuilder(
      column: $state.table.isJoined,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SharedAlbumsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SharedAlbumsTable> {
  $$SharedAlbumsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get ownerName => $state.composableBuilder(
      column: $state.table.ownerName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get partnerName => $state.composableBuilder(
      column: $state.table.partnerName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get manifestPath => $state.composableBuilder(
      column: $state.table.manifestPath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isJoined => $state.composableBuilder(
      column: $state.table.isJoined,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SharedCommentsTableCreateCompanionBuilder = SharedCommentsCompanion
    Function({
  required String id,
  required String sharedAlbumId,
  required String assetId,
  required String authorName,
  required String body,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SharedCommentsTableUpdateCompanionBuilder = SharedCommentsCompanion
    Function({
  Value<String> id,
  Value<String> sharedAlbumId,
  Value<String> assetId,
  Value<String> authorName,
  Value<String> body,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SharedCommentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SharedCommentsTable,
    SharedComment,
    $$SharedCommentsTableFilterComposer,
    $$SharedCommentsTableOrderingComposer,
    $$SharedCommentsTableCreateCompanionBuilder,
    $$SharedCommentsTableUpdateCompanionBuilder> {
  $$SharedCommentsTableTableManager(
      _$AppDatabase db, $SharedCommentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SharedCommentsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SharedCommentsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sharedAlbumId = const Value.absent(),
            Value<String> assetId = const Value.absent(),
            Value<String> authorName = const Value.absent(),
            Value<String> body = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SharedCommentsCompanion(
            id: id,
            sharedAlbumId: sharedAlbumId,
            assetId: assetId,
            authorName: authorName,
            body: body,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sharedAlbumId,
            required String assetId,
            required String authorName,
            required String body,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SharedCommentsCompanion.insert(
            id: id,
            sharedAlbumId: sharedAlbumId,
            assetId: assetId,
            authorName: authorName,
            body: body,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$SharedCommentsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SharedCommentsTable> {
  $$SharedCommentsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sharedAlbumId => $state.composableBuilder(
      column: $state.table.sharedAlbumId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get authorName => $state.composableBuilder(
      column: $state.table.authorName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get body => $state.composableBuilder(
      column: $state.table.body,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SharedCommentsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SharedCommentsTable> {
  $$SharedCommentsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sharedAlbumId => $state.composableBuilder(
      column: $state.table.sharedAlbumId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get authorName => $state.composableBuilder(
      column: $state.table.authorName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get body => $state.composableBuilder(
      column: $state.table.body,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SharedReactionsTableCreateCompanionBuilder = SharedReactionsCompanion
    Function({
  required String id,
  required String sharedAlbumId,
  required String assetId,
  required String authorName,
  required String reaction,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SharedReactionsTableUpdateCompanionBuilder = SharedReactionsCompanion
    Function({
  Value<String> id,
  Value<String> sharedAlbumId,
  Value<String> assetId,
  Value<String> authorName,
  Value<String> reaction,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SharedReactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SharedReactionsTable,
    SharedReaction,
    $$SharedReactionsTableFilterComposer,
    $$SharedReactionsTableOrderingComposer,
    $$SharedReactionsTableCreateCompanionBuilder,
    $$SharedReactionsTableUpdateCompanionBuilder> {
  $$SharedReactionsTableTableManager(
      _$AppDatabase db, $SharedReactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SharedReactionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SharedReactionsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sharedAlbumId = const Value.absent(),
            Value<String> assetId = const Value.absent(),
            Value<String> authorName = const Value.absent(),
            Value<String> reaction = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SharedReactionsCompanion(
            id: id,
            sharedAlbumId: sharedAlbumId,
            assetId: assetId,
            authorName: authorName,
            reaction: reaction,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sharedAlbumId,
            required String assetId,
            required String authorName,
            required String reaction,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SharedReactionsCompanion.insert(
            id: id,
            sharedAlbumId: sharedAlbumId,
            assetId: assetId,
            authorName: authorName,
            reaction: reaction,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$SharedReactionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SharedReactionsTable> {
  $$SharedReactionsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sharedAlbumId => $state.composableBuilder(
      column: $state.table.sharedAlbumId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get authorName => $state.composableBuilder(
      column: $state.table.authorName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get reaction => $state.composableBuilder(
      column: $state.table.reaction,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SharedReactionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SharedReactionsTable> {
  $$SharedReactionsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sharedAlbumId => $state.composableBuilder(
      column: $state.table.sharedAlbumId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get authorName => $state.composableBuilder(
      column: $state.table.authorName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get reaction => $state.composableBuilder(
      column: $state.table.reaction,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$InviteIdentitiesTableCreateCompanionBuilder
    = InviteIdentitiesCompanion Function({
  required String id,
  required String inviteCode,
  required String role,
  required String displayName,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$InviteIdentitiesTableUpdateCompanionBuilder
    = InviteIdentitiesCompanion Function({
  Value<String> id,
  Value<String> inviteCode,
  Value<String> role,
  Value<String> displayName,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$InviteIdentitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InviteIdentitiesTable,
    InviteIdentity,
    $$InviteIdentitiesTableFilterComposer,
    $$InviteIdentitiesTableOrderingComposer,
    $$InviteIdentitiesTableCreateCompanionBuilder,
    $$InviteIdentitiesTableUpdateCompanionBuilder> {
  $$InviteIdentitiesTableTableManager(
      _$AppDatabase db, $InviteIdentitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$InviteIdentitiesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$InviteIdentitiesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> inviteCode = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InviteIdentitiesCompanion(
            id: id,
            inviteCode: inviteCode,
            role: role,
            displayName: displayName,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String inviteCode,
            required String role,
            required String displayName,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              InviteIdentitiesCompanion.insert(
            id: id,
            inviteCode: inviteCode,
            role: role,
            displayName: displayName,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$InviteIdentitiesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $InviteIdentitiesTable> {
  $$InviteIdentitiesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get inviteCode => $state.composableBuilder(
      column: $state.table.inviteCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get role => $state.composableBuilder(
      column: $state.table.role,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get displayName => $state.composableBuilder(
      column: $state.table.displayName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$InviteIdentitiesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $InviteIdentitiesTable> {
  $$InviteIdentitiesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get inviteCode => $state.composableBuilder(
      column: $state.table.inviteCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get role => $state.composableBuilder(
      column: $state.table.role,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get displayName => $state.composableBuilder(
      column: $state.table.displayName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$RecycleBinEntriesTableCreateCompanionBuilder
    = RecycleBinEntriesCompanion Function({
  required String assetId,
  required DateTime deletedAt,
  Value<String> originalAlbumIdsCsv,
  Value<int> rowid,
});
typedef $$RecycleBinEntriesTableUpdateCompanionBuilder
    = RecycleBinEntriesCompanion Function({
  Value<String> assetId,
  Value<DateTime> deletedAt,
  Value<String> originalAlbumIdsCsv,
  Value<int> rowid,
});

class $$RecycleBinEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecycleBinEntriesTable,
    RecycleBinEntry,
    $$RecycleBinEntriesTableFilterComposer,
    $$RecycleBinEntriesTableOrderingComposer,
    $$RecycleBinEntriesTableCreateCompanionBuilder,
    $$RecycleBinEntriesTableUpdateCompanionBuilder> {
  $$RecycleBinEntriesTableTableManager(
      _$AppDatabase db, $RecycleBinEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RecycleBinEntriesTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$RecycleBinEntriesTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> assetId = const Value.absent(),
            Value<DateTime> deletedAt = const Value.absent(),
            Value<String> originalAlbumIdsCsv = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecycleBinEntriesCompanion(
            assetId: assetId,
            deletedAt: deletedAt,
            originalAlbumIdsCsv: originalAlbumIdsCsv,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String assetId,
            required DateTime deletedAt,
            Value<String> originalAlbumIdsCsv = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecycleBinEntriesCompanion.insert(
            assetId: assetId,
            deletedAt: deletedAt,
            originalAlbumIdsCsv: originalAlbumIdsCsv,
            rowid: rowid,
          ),
        ));
}

class $$RecycleBinEntriesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $RecycleBinEntriesTable> {
  $$RecycleBinEntriesTableFilterComposer(super.$state);
  ColumnFilters<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get originalAlbumIdsCsv => $state.composableBuilder(
      column: $state.table.originalAlbumIdsCsv,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$RecycleBinEntriesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $RecycleBinEntriesTable> {
  $$RecycleBinEntriesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get originalAlbumIdsCsv => $state.composableBuilder(
      column: $state.table.originalAlbumIdsCsv,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MediaAssetsTableTableManager get mediaAssets =>
      $$MediaAssetsTableTableManager(_db, _db.mediaAssets);
  $$AlbumsTableTableManager get albums =>
      $$AlbumsTableTableManager(_db, _db.albums);
  $$AlbumAssetsTableTableManager get albumAssets =>
      $$AlbumAssetsTableTableManager(_db, _db.albumAssets);
  $$TimelineBucketsTableTableManager get timelineBuckets =>
      $$TimelineBucketsTableTableManager(_db, _db.timelineBuckets);
  $$PlaceClustersTableTableManager get placeClusters =>
      $$PlaceClustersTableTableManager(_db, _db.placeClusters);
  $$PeopleEmbeddingsTableTableManager get peopleEmbeddings =>
      $$PeopleEmbeddingsTableTableManager(_db, _db.peopleEmbeddings);
  $$SmartAnalysisResultsTableTableManager get smartAnalysisResults =>
      $$SmartAnalysisResultsTableTableManager(_db, _db.smartAnalysisResults);
  $$CacheRecordsTableTableManager get cacheRecords =>
      $$CacheRecordsTableTableManager(_db, _db.cacheRecords);
  $$BackupJobsTableTableManager get backupJobs =>
      $$BackupJobsTableTableManager(_db, _db.backupJobs);
  $$SharedAlbumsTableTableManager get sharedAlbums =>
      $$SharedAlbumsTableTableManager(_db, _db.sharedAlbums);
  $$SharedCommentsTableTableManager get sharedComments =>
      $$SharedCommentsTableTableManager(_db, _db.sharedComments);
  $$SharedReactionsTableTableManager get sharedReactions =>
      $$SharedReactionsTableTableManager(_db, _db.sharedReactions);
  $$InviteIdentitiesTableTableManager get inviteIdentities =>
      $$InviteIdentitiesTableTableManager(_db, _db.inviteIdentities);
  $$RecycleBinEntriesTableTableManager get recycleBinEntries =>
      $$RecycleBinEntriesTableTableManager(_db, _db.recycleBinEntries);
}
