import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../models/gallery_asset.dart';
import '../../models/media_status.dart';
import '../../widgets/status_badges.dart';

class PhotosScreen extends ConsumerStatefulWidget {
  const PhotosScreen({super.key});

  @override
  ConsumerState<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends ConsumerState<PhotosScreen> {
  int _segment = 0;
  double _tileSize = 112;

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(galleryRepositoryProvider);
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MemoryVault',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 14),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Photos')),
                ButtonSegment(value: 1, label: Text('Timeline')),
                ButtonSegment(value: 2, label: Text('Albums')),
              ],
              selected: {_segment},
              onSelectionChanged: (value) => setState(() => _segment = value.first),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                child: switch (_segment) {
                  0 => _PhotosGrid(
                      tileSize: _tileSize,
                      onScale: (scale) => setState(
                        () => _tileSize = (_tileSize / scale).clamp(76, 176),
                      ),
                    ),
                  1 => FutureBuilder(
                      future: repository.loadTimeline(),
                      builder: (context, snapshot) => _TimelineList(
                        buckets: snapshot.data ?? const [],
                      ),
                    ),
                  _ => FutureBuilder(
                      future: repository.loadAlbums(),
                      builder: (context, snapshot) => _AlbumList(
                        albums: snapshot.data ?? const [],
                      ),
                    ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotosGrid extends ConsumerWidget {
  const _PhotosGrid({required this.tileSize, required this.onScale});

  final double tileSize;
  final ValueChanged<double> onScale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(galleryRepositoryProvider);
    return StreamBuilder<List<GalleryAsset>>(
      stream: repository.watchPhotos(),
      builder: (context, snapshot) {
        final assets = snapshot.data ?? _sampleAssets();
        return GestureDetector(
          onScaleUpdate: (details) {
            if ((details.scale - 1).abs() > 0.03) onScale(details.scale);
          },
          child: GridView.builder(
            key: const ValueKey('photos-grid'),
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: tileSize,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            itemCount: assets.length,
            itemBuilder: (context, index) => _AssetTile(asset: assets[index]),
          ),
        );
      },
    );
  }
}

class _AssetTile extends StatelessWidget {
  const _AssetTile({required this.asset});

  final GalleryAsset asset;

  @override
  Widget build(BuildContext context) {
    final hue = asset.id.hashCode % 360;
    return Hero(
      tag: 'asset:${asset.id}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => _Viewer(asset: asset),
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [
                  HSLColor.fromAHSL(1, hue.toDouble(), 0.45, 0.42).toColor(),
                  HSLColor.fromAHSL(1, (hue + 45).toDouble(), 0.52, 0.62)
                      .toColor(),
                ],
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: 7,
                  right: 7,
                  bottom: 7,
                  child: StatusBadges(statuses: asset.statuses),
                ),
                if (asset.kind == MediaKind.video)
                  const Positioned(
                    top: 7,
                    right: 7,
                    child: Icon(Icons.play_circle_fill_rounded, color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Viewer extends StatelessWidget {
  const _Viewer({required this.asset});

  final GalleryAsset asset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.ios_share_rounded)),
          IconButton(onPressed: null, icon: Icon(Icons.favorite_border_rounded)),
          IconButton(onPressed: null, icon: Icon(Icons.more_horiz_rounded)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Hero(
                tag: 'asset:${asset.id}',
                child: InteractiveViewer(
                  child: AspectRatio(
                    aspectRatio: asset.width / asset.height,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2B2B2B), Color(0xFF77736A)],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            textColor: Colors.white,
            iconColor: Colors.white,
            title: Text(asset.fileName),
            subtitle: Text(
              '${asset.width} x ${asset.height} • ${asset.cameraModel ?? 'Unknown camera'}',
            ),
            trailing: StatusBadges(statuses: asset.statuses),
          ),
        ],
      ),
    );
  }
}

class _TimelineList extends StatelessWidget {
  const _TimelineList({required this.buckets});

  final List<dynamic> buckets;

  @override
  Widget build(BuildContext context) {
    final effective = buckets.isEmpty
        ? ['Today', 'Yesterday', 'July', 'June', '2025', '2024']
        : buckets.map((bucket) => bucket.title).toList();
    return ListView.separated(
      key: const ValueKey('timeline'),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          effective[index].toString(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        subtitle: const Text('Tap to see memories, places, and best shots'),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
      separatorBuilder: (_, __) => const Divider(height: 24),
      itemCount: effective.length,
    );
  }
}

class _AlbumList extends StatelessWidget {
  const _AlbumList({required this.albums});

  final List<dynamic> albums;

  @override
  Widget build(BuildContext context) {
    final effective = albums.isEmpty
        ? [
            'Camera',
            'Screenshots',
            'Downloads',
            'WhatsApp',
            'Telegram',
            'Instagram',
            'Favorites',
            'Hidden',
            'Recycle Bin',
          ]
        : albums.map((album) => album.title).toList();
    return GridView.builder(
      key: const ValueKey('albums'),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: effective.length,
      itemBuilder: (context, index) => Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              effective[index].toString(),
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}

List<GalleryAsset> _sampleAssets() {
  return List.generate(
    36,
    (index) => GalleryAsset(
      id: 'sample-$index',
      platformId: 'sample-$index',
      fileName: 'Memory_$index.jpg',
      kind: index % 8 == 0 ? MediaKind.video : MediaKind.photo,
      createdAt: DateTime.now().subtract(Duration(days: index)),
      addedAt: DateTime.now(),
      width: index.isEven ? 4032 : 3024,
      height: index.isEven ? 3024 : 4032,
      sizeBytes: 2400000 + index,
      cameraModel: index.isEven ? 'Samsung' : 'Pixel',
      placeName: ['Rajshahi', 'Dhaka', 'Cox\'s Bazar', 'Vietnam'][index % 4],
      statuses: {
        MediaStatus.local,
        if (index % 3 == 0) MediaStatus.backedUp,
        if (index % 5 == 0) MediaStatus.shared,
        if (index % 7 == 0) MediaStatus.queued,
      },
    ),
  );
}
