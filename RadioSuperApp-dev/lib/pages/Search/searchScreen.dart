import 'dart:async';
import 'package:flutter/material.dart';
import 'package:radio_super_app/models/search/responses/getRecentSearchesResponse.dart';
import 'package:radio_super_app/services/searchService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/Search/searchItemTile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future<GetSearchesListResponse>? _searchResultsFuture;
  List<String> _recentKeywords = [];
  bool _isSearching = false; // New flag to hide recent searches when typing

  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _loadRecentKeywords();
  }

  // Load recent keywords from SharedPreferences
  Future<void> _loadRecentKeywords() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? keywords = prefs.getStringList('recent_keywords');
    setState(() {
      _recentKeywords = keywords ?? [];
    });
  }

  // Save a keyword to recent searches list (new searches stay on top)
  Future<void> _saveKeyword(String keyword) async {
    if (keyword.trim().isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    List<String> recentKeywords = prefs.getStringList('recent_keywords') ?? [];

    // Remove existing entry if it's already in the list
    recentKeywords.remove(keyword);

    // Add new search to the top
    recentKeywords.insert(0, keyword);

    // Limit the number of recent searches
    if (recentKeywords.length > 10) {
      recentKeywords.removeLast(); // Keep only the last 10 searches
    }

    await prefs.setStringList('recent_keywords', recentKeywords);
    setState(() {
      _recentKeywords = recentKeywords;
    });
  }

  // Remove a single keyword from the recent searches list
  Future<void> _removeKeyword(String keyword) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> recentKeywords = prefs.getStringList('recent_keywords') ?? [];
    recentKeywords.remove(keyword);

    await prefs.setStringList('recent_keywords', recentKeywords);
    setState(() {
      _recentKeywords = recentKeywords;
    });
  }

  // Clear all recent searches
  Future<void> _clearRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('recent_keywords');
    setState(() {
      _recentKeywords = [];
    });
  }

  // Handle search input changes with debounce
  void _onSearchChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    setState(() {
      _isSearching = query.isNotEmpty; // Hide recent searches while typing
    });

    _debounceTimer = Timer(const Duration(milliseconds: 600), () {
      if (query.isNotEmpty) {
        _saveKeyword(query); // Save search to recent searches
        setState(() {
          _searchResultsFuture = SearchService().fetchSearchList(query);
        });
      } else {
        setState(() {
          _searchResultsFuture = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF171717),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: const Color(0xFF171717),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Search',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[900],
                    hintText: 'What do you want to listen to?',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchResultsFuture = null;
                          _isSearching = false;
                        });
                      },
                    )
                        : null,
                  ),
                  onChanged: _onSearchChanged,
                ),
                const SizedBox(height: 16),

                // Show recent searches if not currently searching
                if (!_isSearching && _recentKeywords.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Searches',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      TextButton(
                        onPressed: _clearRecentSearches,
                        child: const Text('Clear All', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      children: _recentKeywords.map((keyword) {
                        return ListTile(
                          title: Text(keyword, style: const TextStyle(color: Colors.white)),
                          trailing: IconButton(
                            icon: const Icon(Icons.close, color: Colors.grey),
                            onPressed: () => _removeKeyword(keyword),
                          ),
                          onTap: () {
                            _searchController.text = keyword;
                            _onSearchChanged(keyword);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Search results
                Expanded(
                  child: _searchResultsFuture == null
                      ? const Center(child: Text('Enter a keyword to search.', style: TextStyle(color: Colors.white)))
                      : FutureBuilder<GetSearchesListResponse>(
                    future: _searchResultsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.searchList.isEmpty) {
                        return const Center(
                          child: Text('No results found.', style: TextStyle(color: Colors.white)),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.searchList.length,
                          itemBuilder: (context, index) {
                            final searchItem = snapshot.data!.searchList[index];
                            return SearchItemTile(
                              imagePath: searchItem.picUrl,
                              description: searchItem.description,
                              name: searchItem.name,
                              entity: searchItem,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
