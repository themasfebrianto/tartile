import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../domain/repositories/tajwid_rules_repository.dart';
import '../../domain/repositories/tajwid_category_repository.dart';
import '../../domain/entities/tajwid_category_entity.dart';

class DashboardScreen extends StatefulWidget {
  final TajwidRulesRepository rulesRepository;
  final TajwidCategoryRepository categoryRepository;

  const DashboardScreen({
    super.key,
    required this.rulesRepository,
    required this.categoryRepository,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double _progress = 0.0;
  List<TajwidCategoryEntity> _categories = [];
  String? _hadithArabic;
  String? _hadithTranslation;
  bool _isHadithLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    _fetchRandomHadith();
  }

  Future<void> _loadData() async {
    final categories = await widget.categoryRepository.getAllCategories();

    setState(() {
      _categories = categories;
      // _progress = totalRules == 0 ? 0 : learnedRules / totalRules;
      _progress = 10;
    });
  }

  Future<void> _fetchRandomHadith() async {
    try {
      final response = await http.get(
        Uri.parse('https://muslim-api-three.vercel.app/v1/hadits'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final hadiths = data['data'] as List;

        if (hadiths.isNotEmpty) {
          final randomHadith = hadiths[Random().nextInt(hadiths.length)];
          setState(() {
            _hadithArabic = randomHadith['arab'] ?? '';
            _hadithTranslation = randomHadith['id'] ?? '';
            _isHadithLoading = false;
          });
        }
      } else {
        setState(() => _isHadithLoading = false);
      }
    } catch (e) {
      debugPrint('❌ Gagal ambil hadits: $e');
      setState(() => _isHadithLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DashboardScreen')),
      body: RefreshIndicator(
        onRefresh: () async {
          await _loadData();
          await _fetchRandomHadith();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ====== Hadits Hari Ini ======
              Text(
                'Hadits Hari Ini 📖',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              if (_isHadithLoading)
                const Center(child: CircularProgressIndicator())
              else if (_hadithArabic != null)
                Card(
                  color: Colors.teal.shade50,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _hadithArabic ?? '',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: 'NotoSansArabic',
                            fontSize: 20,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _hadithTranslation ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 24),

              // ====== Progress Belajar ======
              Text(
                'Progress Belajar',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: _progress,
                minHeight: 10,
                borderRadius: BorderRadius.circular(8),
                backgroundColor: Colors.grey[300],
              ),
              const SizedBox(height: 8),
              Text('${(_progress * 100).toStringAsFixed(0)}% selesai'),

              const SizedBox(height: 24),

              // ====== Kategori Tajwid ======
              Text(
                'Kategori Tajwid',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              ..._categories.map(
                (c) => Card(
                  child: ListTile(
                    title: Text(c.title),
                    subtitle: Text(c.description ?? ''),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                    onTap: () {
                      // TODO: navigate ke daftar aturan kategori
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
