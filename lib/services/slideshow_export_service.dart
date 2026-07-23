import 'package:ffmpeg_kit_flutter_new_min/ffmpeg_kit.dart';

class SlideshowExportService {
  Future<void> exportKenBurnsMp4({
    required List<String> imagePaths,
    required String outputPath,
    String? musicPath,
    String? title,
  }) async {
    if (imagePaths.isEmpty) {
      throw ArgumentError.value(imagePaths, 'imagePaths', 'Cannot be empty.');
    }

    final inputList = imagePaths
        .asMap()
        .entries
        .map((entry) => "-loop 1 -t 4 -i '${entry.value}'")
        .join(' ');
    final musicInput = musicPath == null ? '' : "-i '$musicPath'";
    final drawText = title == null
        ? ''
        : ",drawtext=text='$title':x=48:y=h-112:fontsize=42:fontcolor=white";
    final filter =
        "zoompan=z='min(zoom+0.0015,1.12)':d=120:s=1920x1080,fade=t=in:st=0:d=0.4,fade=t=out:st=3.6:d=0.4$drawText";
    final audioMap = musicPath == null ? '' : '-shortest';

    await FFmpegKit.execute(
      '$inputList $musicInput -filter_complex "$filter" '
      '-r 30 -pix_fmt yuv420p $audioMap "$outputPath"',
    );
  }
}
