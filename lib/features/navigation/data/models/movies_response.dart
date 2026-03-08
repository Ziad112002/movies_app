import 'remote_movie_data.dart';

class MoviesResponse {
  final String status;
  final String statusMessage;
  final MovieData data;
  final ApiMeta? meta;

  const MoviesResponse({
    required this.status,
    required this.statusMessage,
    required this.data,
    this.meta,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    return MoviesResponse(
      status: json['status'] as String,
      statusMessage: json['status_message'] as String,
      data: MovieData.fromJson(json['data'] as Map<String, dynamic>),
      meta: json['@meta'] != null
          ? ApiMeta.fromJson(json['@meta'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'status_message': statusMessage,
    'data': data.toJson(),
    if (meta != null) '@meta': meta!.toJson(),
  };
}

class ApiMeta {
  final int apiVersion;
  final String executionTime;

  const ApiMeta({
    required this.apiVersion,
    required this.executionTime,
  });

  factory ApiMeta.fromJson(Map<String, dynamic> json) {
    return ApiMeta(
      apiVersion: json['api_version'] as int,
      executionTime: json['execution_time'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'api_version': apiVersion,
    'execution_time': executionTime,
  };
}



class Torrent {
  final String url;
  final String hash;
  final String quality; // "720p", "1080p", "480p" ...
  final String type; // "web", "bluray" ...
  final String isRepack;
  final String videoCodec;
  final String bitDepth;
  final String audioChannels;
  final int seeds;
  final int peers;
  final String size; // human readable "1.04 GB"
  final int sizeBytes;
  final String dateUploaded;
  final int dateUploadedUnix;

  const Torrent({
    required this.url,
    required this.hash,
    required this.quality,
    required this.type,
    required this.isRepack,
    required this.videoCodec,
    required this.bitDepth,
    required this.audioChannels,
    required this.seeds,
    required this.peers,
    required this.size,
    required this.sizeBytes,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) {
    return Torrent(
      url: json['url'] as String,
      hash: json['hash'] as String,
      quality: json['quality'] as String,
      type: json['type'] as String,
      isRepack: json['is_repack'] as String,
      videoCodec: json['video_codec'] as String,
      bitDepth: json['bit_depth'] as String,
      audioChannels: json['audio_channels'] as String,
      seeds: json['seeds'] as int,
      peers: json['peers'] as int,
      size: json['size'] as String,
      sizeBytes: json['size_bytes'] as int,
      dateUploaded: json['date_uploaded'] as String,
      dateUploadedUnix: json['date_uploaded_unix'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'url': url,
    'hash': hash,
    'quality': quality,
    'type': type,
    'is_repack': isRepack,
    'video_codec': videoCodec,
    'bit_depth': bitDepth,
    'audio_channels': audioChannels,
    'seeds': seeds,
    'peers': peers,
    'size': size,
    'size_bytes': sizeBytes,
    'date_uploaded': dateUploaded,
    'date_uploaded_unix': dateUploadedUnix,
  };
}