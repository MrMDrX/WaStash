import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroine/heroine.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import 'package:wastash/cubits/saved_status_cubit.dart';
import 'package:wastash/pages/full_screen_viewer.dart';
import 'package:wastash/repositories/status_repository.dart';
import 'package:wastash/themes/app_theme.dart';
import 'package:wastash/utils/extensions.dart';
import 'package:wastash/utils/helpers.dart';
import 'package:wastash/widgets/custom_route.dart';

class SavedStatusPage extends StatefulWidget {
  const SavedStatusPage({super.key});

  @override
  State<SavedStatusPage> createState() => _SavedStatusPageState();
}

class _SavedStatusPageState extends State<SavedStatusPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(length: 2, vsync: this);
    context.read<SavedStatusCubit>().loadSavedStatuses();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<SavedStatusCubit>().loadSavedStatuses();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 0),
                child: Column(
                  children: [
                    Text(
                      context.l10n.savedStatus,
                      style: context.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.l10n.savedStatusSubtitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .extension<AppThemeExtension>()
                          ?.secondaryText
                          .copyWith(height: 1.4),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
          body: BlocBuilder<SavedStatusCubit, SavedStatusState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async =>
                    context.read<SavedStatusCubit>().loadSavedStatuses(),
                child: _buildContent(state, isDark),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(SavedStatusState state, bool isDark) {
    if (state is SavedStatusLoading) {
      return _buildShimmerLoading(isDark);
    } else if (state is SavedStatusError) {
      return Center(child: Text('Error: ${state.message}'));
    } else if (state is SavedStatusLoaded) {
      final images = state.files.where(StatusRepository.isImage).toList();
      final videos = state.files.where(StatusRepository.isVideo).toList();
      return Column(
        children: [
          Container(
            height: 48,
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.symmetric(horizontal: 80),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF232323) : const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(24),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: isDark
                    ? const Color(0xFF151515)
                    : const Color(0xFFE6E6E6),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: context.colors.onSurface,
              unselectedLabelColor: isDark
                  ? context.colors.onSurface.withValues(alpha: 0.38)
                  : Colors.grey[400],
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              labelStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                //fontFamily: 'Geist',
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                //fontFamily: 'Geist',
              ),
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              tabs: [
                Tab(
                  child: Text(
                    context.l10n.images,
                    style: TextStyle(
                      fontFamily: context.isArabic ? 'Rubik' : 'Geist',
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    context.l10n.videos,
                    style: TextStyle(
                      fontFamily: context.isArabic ? 'Rubik' : 'Geist',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildMediaGrid(images), _buildMediaGrid(videos)],
            ),
          ),
        ],
      );
    }
    return const SizedBox(); // Fallback
  }

  Widget _buildMediaGrid(List<String> uris) {
    if (uris.isEmpty) {
      return Center(child: Text(context.l10n.noSavedStatus));
    }

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.7,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => KeyedSubtree(
                key: ValueKey(uris[index]),
                child: _MediaThumbnail(uri: uris[index]),
              ),
              childCount: uris.length,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildShimmerLoading(bool isDark) {
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Column(
        children: [
          // Tab Bar Skeleton
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          // Grid Skeleton
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.7,
                        ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Container(
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[800] : Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      childCount: 6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MediaThumbnail extends StatelessWidget {
  final String uri;
  final _channel = const MethodChannel('io.github.mrmdrx.wastash/status_files');

  const _MediaThumbnail({required this.uri});

  Future<Uint8List> _loadImageBytes() async {
    try {
      final bytes = await _channel.invokeMethod<Uint8List>('getFileBytes', {
        'uri': uri,
      });
      return bytes ?? Uint8List(0);
    } catch (e) {
      return Uint8List(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openFullScreen(context),
      child: Container(
        decoration: ShapeDecoration(
          shape: SquircleBorder(radius: BorderRadius.circular(32)),
          shadows: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ValueListenableBuilder<Spring>(
          valueListenable: springNotifier,
          builder: (context, spring, _) => ValueListenableBuilder<bool>(
            valueListenable: adjustSpringTimingToRoute,
            builder: (context, adjustToRoute, _) =>
                ValueListenableBuilder<HeroineShuttleBuilder>(
                  valueListenable: flightShuttleNotifier,
                  builder: (context, shuttleBuilder, _) => Heroine(
                    tag: uri,
                    spring: spring,
                    adjustToRouteTransitionDuration: adjustToRoute,
                    flightShuttleBuilder: shuttleBuilder,
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                        shape: SquircleBorder(
                          radius: BorderRadius.circular(32),
                        ),
                      ),
                      child: StatusRepository.isImage(uri)
                          ? FutureBuilder<Uint8List>(
                              future: _loadImageBytes(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  return Image.memory(
                                    snapshot.data!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  );
                                }
                                return Container(
                                  color: context.colors.surface,
                                  child: Center(
                                    child: Icon(
                                      Icons.image,
                                      color: context.colors.onSurface
                                          .withValues(alpha: 0.6),
                                      size: 32,
                                    ),
                                  ),
                                );
                              },
                            )
                          : _VideoPreview(uri: uri),
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }

  void _openFullScreen(BuildContext context) {
    Navigator.push(
      context,
      CustomRoute(
        fullscreenDialog: true,
        title: context.l10n.status,
        builder: (context) => ValueListenableBuilder<double>(
          valueListenable:
              ModalRoute.of(context)?.secondaryAnimation ??
              const AlwaysStoppedAnimation(0),
          builder: (context, value, child) {
            final easedValue = Curves.easeOut.transform(value);
            return ColorFiltered(
              colorFilter: ColorFilter.mode(
                context.colors.surface.withValues(alpha: .5 * easedValue),
                BlendMode.srcOver,
              ),
              child: child!,
            );
          },
          child: FullScreenViewer(
            uri: uri,
            isVideo: StatusRepository.isVideo(uri),
            fromSavedStatus: true,
          ),
        ),
      ),
    ).then((_) {
      // Reload after returning from FullScreenViewer
      // ignore: use_build_context_synchronously
      context.read<SavedStatusCubit>().loadSavedStatuses();
    });
  }
}

class _VideoPreview extends StatefulWidget {
  final String uri;

  const _VideoPreview({required this.uri});

  @override
  State<_VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<_VideoPreview> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  Future<void> _initializeController() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.uri));
    try {
      await _controller?.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _isInitialized = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (_isInitialized && _controller != null)
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller!.value.size.width,
                height: _controller!.value.size.height,
                child: VideoPlayer(_controller!),
              ),
            ),
          )
        else
          Container(color: Colors.grey[800]),
        const Center(
          child: Icon(Icons.play_circle_filled, size: 50, color: Colors.white),
        ),
      ],
    );
  }
}
