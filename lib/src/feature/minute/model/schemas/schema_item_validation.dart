// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atas/src/feature/minute/minute.dart';

enum SchemaItemValidationType { withMin, withMax, withMinMax, withFixedTotal, repeatable }

class SchemaItemValidation {
  final MinuteItemType type;
  final bool repeatable;
  final bool obligatory;
  final int? itemsAmount;
  final int? minItems;
  final int? maxItems;
  final SchemaItemValidationType validationType;

  SchemaItemValidation._({
    required this.type,
    required this.repeatable,
    required this.obligatory,
    required this.validationType,
    this.itemsAmount,
    this.minItems,
    this.maxItems,
  });

  factory SchemaItemValidation.withMin({required MinuteItemType type, required int minItems, bool obligatory = true}) {
    return SchemaItemValidation._(
      type: type,
      repeatable: false,
      obligatory: obligatory,
      minItems: minItems,
      validationType: SchemaItemValidationType.withMin,
    );
  }

  factory SchemaItemValidation.withMax({required MinuteItemType type, required int maxItems}) {
    return SchemaItemValidation._(
      type: type,
      repeatable: false,
      obligatory: true,
      maxItems: maxItems,
      validationType: SchemaItemValidationType.withMax,
    );
  }

  factory SchemaItemValidation.withMinMax(
      {required MinuteItemType type, required int minItems, required int maxItems}) {
    return SchemaItemValidation._(
      type: type,
      repeatable: false,
      obligatory: true,
      minItems: minItems,
      maxItems: maxItems,
      validationType: SchemaItemValidationType.withMinMax,
    );
  }

  factory SchemaItemValidation.withFixedTotal({
    required MinuteItemType type,
    required int total,
    bool obligatory = true,
  }) {
    return SchemaItemValidation._(
      type: type,
      repeatable: false,
      obligatory: obligatory,
      itemsAmount: total,
      validationType: SchemaItemValidationType.withFixedTotal,
    );
  }

  factory SchemaItemValidation.repeatable({required MinuteItemType type, bool obligatory = false}) {
    return SchemaItemValidation._(
      type: type,
      repeatable: true,
      obligatory: obligatory,
      validationType: SchemaItemValidationType.repeatable,
    );
  }

  bool withFixedTotalValidation(int items) {
    if (!obligatory) return true;
    return items == itemsAmount;
  }

  bool withMinMaxValidation(int items) {
    if (!obligatory) return true;
    return items >= minItems! && items <= maxItems!;
  }

  bool withMinValidation(int items) {
    if (!obligatory) return true;
    return items >= minItems!;
  }

  bool withMaxValidation(int items) {
    if (!obligatory) return true;
    return items <= maxItems!;
  }
}
