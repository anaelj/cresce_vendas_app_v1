import 'package:intl/intl.dart';

String formatBrlValue(double value) {
  final formatValue = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: '',
    decimalDigits: 2,
  );
  return formatValue.format(value);
}
