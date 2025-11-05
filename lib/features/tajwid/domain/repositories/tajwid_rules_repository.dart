import '../entities/tajwid_rule_entity.dart';

abstract class TajwidRulesRepository {
  Future<List<TajwidRuleEntity>> getAllRules();
  Future<List<TajwidRuleEntity>> searchRules(String query);
  Future<TajwidRuleEntity?> getRuleById(String id);
  Future<List<TajwidRuleEntity>> getRulesByCategory(String categoryId);
}
