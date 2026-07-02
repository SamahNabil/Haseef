import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/profile_widgets.dart';

class DecisionType {
  const DecisionType({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
}

const decisionTypes = [
  DecisionType(
    id: 'mortgage',
    title: 'قرض عقاري',
    subtitle: 'تخطيط السكن والاستثمار',
    icon: Icons.home_work_outlined,
    iconColor: Color(0xFFE8A07A),
  ),
  DecisionType(
    id: 'car',
    title: 'شراء سيارة',
    subtitle: 'تقييم الجدوى والتمويل',
    icon: Icons.directions_car_outlined,
    iconColor: Color(0xFF4A9EFF),
  ),
  DecisionType(
    id: 'device',
    title: 'شراء جهاز',
    subtitle: 'مقارنة الكاش والتقسيط',
    icon: Icons.laptop_mac_outlined,
    iconColor: Color(0xFF7A9BB5),
  ),
  DecisionType(
    id: 'personal_loan',
    title: 'قرض شخصي',
    subtitle: 'دراسة الالتزامات الشهرية',
    icon: Icons.credit_card_outlined,
    iconColor: Color(0xFF9CA3AF),
  ),
  DecisionType(
    id: 'travel',
    title: 'سفر',
    subtitle: 'ميزانية الرحلة والادخار',
    icon: Icons.flight_outlined,
    iconColor: Color(0xFFE8A838),
  ),
  DecisionType(
    id: 'investment',
    title: 'استثمار',
    subtitle: 'تحليل المخاطر والعوائد',
    icon: Icons.trending_up_rounded,
    iconColor: Color(0xFF00BD8E),
  ),
  DecisionType(
    id: 'other',
    title: 'قرار آخر',
    subtitle: 'تخصيص قرار مالي جديد',
    icon: Icons.add_rounded,
    iconColor: Color(0xFF6B7B8D),
  ),
];

class DecisionFormState {
  const DecisionFormState({
    this.selectedTypeId,
    this.title = '',
    this.totalAmount = '',
    this.downPayment = '',
    this.monthlyInstallment = '',
    this.desiredResults = '',
  });

  final String? selectedTypeId;
  final String title;
  final String totalAmount;
  final String downPayment;
  final String monthlyInstallment;
  final String desiredResults;

  DecisionFormState copyWith({
    String? selectedTypeId,
    String? title,
    String? totalAmount,
    String? downPayment,
    String? monthlyInstallment,
    String? desiredResults,
  }) {
    return DecisionFormState(
      selectedTypeId: selectedTypeId ?? this.selectedTypeId,
      title: title ?? this.title,
      totalAmount: totalAmount ?? this.totalAmount,
      downPayment: downPayment ?? this.downPayment,
      monthlyInstallment: monthlyInstallment ?? this.monthlyInstallment,
      desiredResults: desiredResults ?? this.desiredResults,
    );
  }
}

class DecisionFormNotifier extends Notifier<DecisionFormState> {
  @override
  DecisionFormState build() => const DecisionFormState();

  void selectType(String id) {
    state = state.copyWith(selectedTypeId: id);
  }

  void updateTitle(String value) => state = state.copyWith(title: value);
  void updateTotalAmount(String value) =>
      state = state.copyWith(totalAmount: value);
  void updateDownPayment(String value) =>
      state = state.copyWith(downPayment: value);
  void updateMonthlyInstallment(String value) =>
      state = state.copyWith(monthlyInstallment: value);
  void updateDesiredResults(String value) =>
      state = state.copyWith(desiredResults: value);
}

final decisionFormProvider =
    NotifierProvider<DecisionFormNotifier, DecisionFormState>(
  DecisionFormNotifier.new,
);

const financialGoals = [
  FinancialGoal(label: 'منزل', icon: Icons.home_outlined),
  FinancialGoal(label: 'سيارة', icon: Icons.directions_car_outlined),
  FinancialGoal(label: 'زواج', icon: Icons.favorite_border_rounded),
  FinancialGoal(label: 'استثمار', icon: Icons.show_chart_rounded),
  FinancialGoal(label: 'سفر', icon: Icons.flight_outlined),
  FinancialGoal(label: 'طوارئ', icon: Icons.emergency_outlined),
];

class FinancialProfileState {
  const FinancialProfileState({
    this.monthlySalary = '0.00',
    this.additionalIncome = '0.00',
    this.monthlyExpenses = '0.00',
    this.monthlyObligations = '0.00',
    this.savings = '0.00',
    this.age = '25',
    this.selectedGoalIndex,
  });

  final String monthlySalary;
  final String additionalIncome;
  final String monthlyExpenses;
  final String monthlyObligations;
  final String savings;
  final String age;
  final int? selectedGoalIndex;

  FinancialProfileState copyWith({
    String? monthlySalary,
    String? additionalIncome,
    String? monthlyExpenses,
    String? monthlyObligations,
    String? savings,
    String? age,
    int? selectedGoalIndex,
  }) {
    return FinancialProfileState(
      monthlySalary: monthlySalary ?? this.monthlySalary,
      additionalIncome: additionalIncome ?? this.additionalIncome,
      monthlyExpenses: monthlyExpenses ?? this.monthlyExpenses,
      monthlyObligations: monthlyObligations ?? this.monthlyObligations,
      savings: savings ?? this.savings,
      age: age ?? this.age,
      selectedGoalIndex: selectedGoalIndex ?? this.selectedGoalIndex,
    );
  }
}

class FinancialProfileNotifier extends Notifier<FinancialProfileState> {
  @override
  FinancialProfileState build() => const FinancialProfileState();

  void updateField(String field, String value) {
    state = switch (field) {
      'salary' => state.copyWith(monthlySalary: value),
      'income' => state.copyWith(additionalIncome: value),
      'expenses' => state.copyWith(monthlyExpenses: value),
      'obligations' => state.copyWith(monthlyObligations: value),
      'savings' => state.copyWith(savings: value),
      'age' => state.copyWith(age: value),
      _ => state,
    };
  }

  void selectGoal(int index) {
    state = state.copyWith(selectedGoalIndex: index);
  }
}

final financialProfileProvider =
    NotifierProvider<FinancialProfileNotifier, FinancialProfileState>(
  FinancialProfileNotifier.new,
);
