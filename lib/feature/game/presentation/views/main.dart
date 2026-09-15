import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/games_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const GameListScreen(),
    );
  }
}

class GameListScreen extends ConsumerStatefulWidget {
  const GameListScreen({super.key});

  @override
  ConsumerState<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends ConsumerState<GameListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }
  
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(gameProvider.notifier).fetchNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Game List Data"),
      ),
      body: gameState.when(
          data: (paginatedData) {
            if (paginatedData.items.isEmpty) {
              return Center(child: const Text('No Game found'));
            }

            return RefreshIndicator(
                onRefresh: () => ref.read(gameProvider.notifier).refresh(),
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: paginatedData.items.length +
                        (paginatedData.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == paginatedData.items.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final game = paginatedData.items[index];
                      return Padding(
                        padding: EdgeInsets.only(right: 12, left: 12),
                        child: Card(
                          child: ListTile(
                            leading: game.backgroundImage != null ? Image.network(game.backgroundImage!, width: 50, fit:  BoxFit.cover, errorBuilder: (_,__,___,) => const Icon(Icons.gamepad)) : const Icon(Icons.gamepad),
                            title: Text(game.name ?? 'No Name'),
                            subtitle: Text('Rating: $game.rating')
                          ),
                        ),
                      );
                    }
                )
            );
          },

          loading: () => const Center(child: CircularProgressIndicator()),

          error: (err, stack) => Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Text('Error: $err'),
                ElevatedButton(
                    onPressed: () => ref.read(gameProvider.notifier).refresh(),
                    child: const Text('Retry'),
                )
              ],
            ),
          ),
      ),
    );
  }
}
