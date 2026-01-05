import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoicediscounting/src/components/wallet_card.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/mainlayout.dart';
import 'package:invoicediscounting/src/models/transaction_model.dart';

class TrainsationAll extends StatefulWidget {
  const TrainsationAll({super.key});

  @override
  State<TrainsationAll> createState() => _TrainsationAllState();
}

class _TrainsationAllState extends State<TrainsationAll> {
  String sortBy = 'newest';
  void showSort(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder:
          (_) => FilterSheet(
            title: 'Sort By',
            options: ['Newest', 'Oldest'],
            selected: sortBy,
            onApply: (v) {
              setState(() => sortBy = v == 'Newest' ? 'newest' : 'oldest');
            },
          ),
    );
  }

  void showType(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder:
          (_) => FilterSheet(
            title: 'Transaction Type',
            options: [
              'Deposit',
              'Withdrawal',
              'Subscription',
              'Repayment',
              'Interest',
              'Redemption',
            ],
            selected: selectedType,
            onApply: (v) {
              setState(() => selectedType = v?.toLowerCase());
            },
          ),
    );
  }

  void showMonth(BuildContext ctx) async {
    final picked = await showMonthPicker(ctx);
    if (picked != null) setState(() => selectedMonth = picked);
  }

  String? selectedType;
  DateTime? selectedMonth;

  final List<TransactionModel> all = [
    TransactionModel(
      title: 'Repayment',
      subtitle: 'PTC 14/11/2025',
      amount: 100000,
      type: 'repayment',
      date: DateTime(2025, 11, 14),
    ),
    TransactionModel(
      title: 'Deposit',
      subtitle: 'to your pocket 15/10/2025',
      amount: 25000,
      failed: true,
      type: 'deposit',
      date: DateTime(2025, 10, 15),
    ),
    TransactionModel(
      title: 'Subscription',
      subtitle: 'PTC 15/10/2025',
      amount: 100000,
      type: 'subscription',
      date: DateTime(2025, 10, 15),
    ),
    TransactionModel(
      title: 'Deposit',
      subtitle: 'to your pocket 15/10/2025',
      amount: 100000.00,
      type: 'deposit',
      date: DateTime(2025, 10, 15),
    ),

    TransactionModel(
      title: 'Withdrawal ',
      subtitle: 'from your pocket 14/11/2025',
      amount: -100000.00,
      type: 'withdrawal',
      date: DateTime(2025, 11, 14),
    ),
    TransactionModel(
      title: 'Deposit',
      subtitle: 'to your pocket 15/10/2025',
      amount: 25000.00,
      type: 'deposit',
      date: DateTime(2025, 10, 15),
    ),

    TransactionModel(
      title: 'Withdrawal ',
      subtitle: 'from your pocket 14/11/2025',
      amount: -25000.00,
      type: 'withdrawal',
      date: DateTime(2025, 11, 14),
    ),
  ];

  List<TransactionModel> get filtered {
    var list = [...all];

    if (selectedType != null) {
      final types = selectedType!.split(',');
      list = list.where((e) => types.contains(e.type)).toList();
    }

    if (selectedMonth != null) {
      list =
          list
              .where(
                (e) =>
                    e.date.month == selectedMonth!.month &&
                    e.date.year == selectedMonth!.year,
              )
              .toList();
    }

    list.sort(
      (a, b) =>
          sortBy == 'newest'
              ? b.date.compareTo(a.date)
              : a.date.compareTo(b.date),
    );

    return list;
  }

  Future<DateTime?> showMonthPicker(BuildContext context) async {
    int selectedYear = DateTime.now().year;
    int selectedMonth = DateTime.now().month;

    return showModalBottomSheet<DateTime>(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select Month',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  DropdownButton<int>(
                    value: selectedYear,
                    style: TextStyle(color: blackColor),
                    items: List.generate(
                      10,
                      (i) => DropdownMenuItem(
                        value: DateTime.now().year - i,
                        child: Text((DateTime.now().year - i).toString()),
                      ),
                    ),
                    onChanged: (v) => setState(() => selectedYear = v!),
                  ),

                  const SizedBox(height: 12),

                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: 12,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2.4,
                        ),
                    itemBuilder: (_, index) {
                      final m = index + 1;
                      final isSelected = m == selectedMonth;

                      return GestureDetector(
                        onTap: () => setState(() => selectedMonth = m),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? onboardingTitleColor
                                    : faintboxbackground,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            DateFormat.MMM().format(DateTime(0, m)),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child:  Text('Cancel',style: TextStyle(color: onboardingTitleColor),),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: onboardingTitleColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed:
                              () => Navigator.pop(
                                context,
                                DateTime(selectedYear, selectedMonth),
                              ),
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return MainLayout(
      ctx: 0,
      showDefaultBottom: true,
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 120 : 20,
            vertical: 16,
          ),
          child: Column(
            children: [
              WalletCard(),
              SizedBox(height: 10),
              _TopBar(
                onSort: () => showSort(context),
                onType: () => showType(context),
                onMonth: () => showMonth(context),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  itemBuilder: (_, i) => TransactionTile(t: filtered[i]),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
               Row(
  children: [
    Expanded(
      child: Text(
        'Need help ?',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    ),
    const SizedBox(width: 12),
    Flexible(
      child: Text(
        '+91-9876543210',
        textAlign: TextAlign.right,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
  ],
),
const SizedBox(height: 10),
Row(
  children: [
    Expanded(
      child: Text(
        'contact us if you have any concern',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
    const SizedBox(width: 12),
    Flexible(
      child: Text(
        'contact.person@domainmail.com',
        textAlign: TextAlign.right,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
  ],
),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onSort, onType, onMonth;
  const _TopBar({
    required this.onSort,
    required this.onType,
    required this.onMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Transactions', style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterChipWidget('Sort By', onSort),
            FilterChipWidget('Transaction Type', onType),
            FilterChipWidget('By Month', onMonth),
            FilterChipWidget('EMAIL STATEMENT', () {}),
          ],
        ),
      ],
    );
  }
}

class FilterSheet extends StatefulWidget {
  final String title;
  final List<String> options;
  final String? selected;
  final Function(String?) onApply;
  const FilterSheet({
    super.key,
    required this.title,
    required this.options,
    this.selected,
    required this.onApply,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  List<String> selected = [];

  @override
  void initState() {
    if (widget.selected != null && widget.selected!.isNotEmpty) {
      selected = widget.selected!.split(',');
    }
    super.initState();
  }

  bool get isMulti => widget.title == 'Transaction Type';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.title, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 12),

          ...widget.options.map((e) {
            return isMulti
                ? CheckboxListTile(
                  value: selected.contains(e),
                  activeColor: onboardingTitleColor,
                  title: Text(e, style: Theme.of(context).textTheme.bodyMedium),
                  onChanged: (v) {
                    setState(() {
                      v! ? selected.add(e) : selected.remove(e);
                    });
                  },
                )
                : RadioListTile(
                  value: e,
                  groupValue: selected.isEmpty ? null : selected.first,
                  activeColor: onboardingTitleColor,
                  title: Text(e, style: Theme.of(context).textTheme.bodyMedium),
                  onChanged: (v) => setState(() => selected = [v as String]),
                );
          }),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => setState(() => selected.clear()),
                  child:  Text('Clear',style: TextStyle(color: onboardingTitleColor),),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                            backgroundColor: onboardingTitleColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                  onPressed: () {
                    widget.onApply(
                      selected.isEmpty ? null : selected.join(','),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final TransactionModel t;
  const TransactionTile({super.key, required this.t});

  @override
  Widget build(BuildContext context) {
    final green = t.amount > 0 && !t.failed;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.title, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 4),
                Text(t.subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '${green ? '+' : '-'}₹${t.amount.abs().toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: green ? Colors.green : Colors.black,
                ),
                // style: TextStyle(
                //   color: green ? Colors.green : Colors.black,
                //   fontWeight: FontWeight.bold,
                // ),
              ),
              if (t.failed)
                const Text('FAILED', style: TextStyle(color: Colors.red)),
            ],
          ),
        ],
      ),
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const FilterChipWidget(this.label, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),

        decoration: BoxDecoration(
          color: faintboxbackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            // if (label != 'EMAIL STATEMENT') ...[
            //   const SizedBox(width: 4),
            //   const Icon(Icons.keyboard_arrow_down, size: 16),
            // ],
          ],
        ),
      ),
    );
  }
}
