// ---------------------------------------------------------------------------
//  © 2025 Karthik. All Rights Reserved.
//
//  This Flutter application and its source code are the exclusive property
//  of the author. Unauthorized copying, redistribution, modification, or
//  commercial use is strictly prohibited.
//
//  For licensing or purchase inquiries (₹500), contact: Karthikrajvsaravana@gmail.com
//
//  Visible + Hidden Watermarks included for authenticity verification.
//  PROJECT-ID: KRVS-2025-CURRENCY-CONVERTER
// ---------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Hidden watermark inside data block (Do Not Remove)
// ID_TRACKER: KRVSC-2025-DATA-MAP

const Map<String, double> exchangeRates = {
  'USD': 1.0,
  'EUR': 0.85,
  'JPY': 110.0,
  'INR': 74.0,
  'GBP': 0.75,
};
final List<String> currencies = exchangeRates.keys.toList();

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',

      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.dark,
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),

      home: const CurrencyConverterHome(),
    );
  }
}

class CurrencyConverterHome extends StatefulWidget {
  const CurrencyConverterHome({super.key});

  @override
  State<CurrencyConverterHome> createState() => _CurrencyConverterHomeState();
}

class _CurrencyConverterHomeState extends State<CurrencyConverterHome> {
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _convertedAmount = 0.0;
  final TextEditingController _amountController = TextEditingController();

  void _convertCurrency() {
    final double amount = double.tryParse(_amountController.text) ?? 0.0;
    final double rateFrom = exchangeRates[_fromCurrency] ?? 1.0;
    final double rateTo = exchangeRates[_toCurrency] ?? 1.0;
    final double result = amount * (rateTo / rateFrom); // Conversion Logic

    // Hidden watermark inside logic section
    // TRACK-ID: CONVERT-LOGIC-KRVS-2025

    setState(() {
      _convertedAmount = result;
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Currency Converter'),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                labelText: 'Amount to Convert',
                hintText: 'Enter amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(
                  Icons.attach_money,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onChanged: (value) => _convertCurrency(),
            ),
            const SizedBox(height: 32.0),

            _buildCurrencySelector(
              label: 'From',
              selectedValue: _fromCurrency,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _fromCurrency = newValue;
                  });
                  _convertCurrency();
                }
              },
            ),

            // 💧Hidden watermark inside UI
            // UI-ID: UI-WATERMARK-ARROW-KRVS-2025
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Icon(
                  Icons.arrow_downward,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),

            _buildCurrencySelector(
              label: 'To',
              selectedValue: _toCurrency,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _toCurrency = newValue;
                  });
                  _convertCurrency();
                }
              },
            ),

            const SizedBox(height: 48.0),
            _buildResultDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencySelector({
    required String label,
    required String selectedValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label Currency',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedValue,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).colorScheme.primary,
              ),
              onChanged: onChanged,
              items: currencies.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultDisplay() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Converted Result',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12.0),

          // Hidden watermark inside result section
          // RESULT-ID: KRVS-OUT-2025
          Text(
            '${_convertedAmount.toStringAsFixed(2)} $_toCurrency',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Colors.amber[300],
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
