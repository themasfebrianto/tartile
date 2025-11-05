import 'package:tartile/features/tajwid/data/dataSources/tajwid_rules_data_source.dart';

import '../../domain/entities/tajwid_rule_entity.dart';
import '../../domain/repositories/tajwid_rules_repository.dart';

class TajwidRulesRepositoryImpl implements TajwidRulesRepository {
  final TajwidRulesDataSource localDataSource;

  TajwidRulesRepositoryImpl(this.localDataSource);

  @override
  Future<List<TajwidRuleEntity>> getAllRules() => localDataSource.getAllRules();

  @override
  Future<List<TajwidRuleEntity>> searchRules(String query) =>
      localDataSource.searchRules(query);

  @override
  Future<TajwidRuleEntity?> getRuleById(String id) async {
    final rules = await localDataSource.getAllRules();
    return rules.firstWhere((r) => r.id == id);
  }

  @override
  Future<List<TajwidRuleEntity>> getRulesByCategory(String categoryId) async {
    final models = await localDataSource.getRulesByCategory(categoryId);
    return models.map((m) => m.toEntity()).toList();
  }
}
