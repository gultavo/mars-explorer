import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../data/mock_data.dart';
import '../../widgets/photo_grid.dart';
import '../../widgets/screen_scaffold.dart';

/// 03 · Explorar por data — calendário (data terrestre, UTC) e grade de fotos.
class DateScreen extends StatefulWidget {
  const DateScreen({super.key});

  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  static final _first = MockData.landingDate;
  static final _last = MockData.lastPhotoDate;

  late DateTime _month = DateTime.utc(_last.year, _last.month);
  DateTime? _selected = _last;
  bool _loading = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool get _canGoBack => _month.isAfter(DateTime.utc(_first.year, _first.month));
  bool get _canGoForward =>
      _month.isBefore(DateTime.utc(_last.year, _last.month));

  void _shiftMonth(int delta) => setState(() {
        _month = DateTime.utc(_month.year, _month.month + delta);
        _selected = null;
        _loading = false;
        _timer?.cancel();
      });

  // TODO: trocar pela busca real na API (filtros date_taken:gte / date_taken:lt).
  void _pick(DateTime day) {
    setState(() {
      _selected = day;
      _loading = true;
    });
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => _loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selected;

    return ScreenBody(
      children: [
        const ScreenHeader(
          eyebrow: 'DATA TERRESTRE · UTC',
          title: 'Explorar por data',
          subtitle: 'Escolha um dia na Terra e veja o que a Curiosity fotografou.',
        ),
        SurfaceCard(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: _canGoBack ? () => _shiftMonth(-1) : null,
                    tooltip: 'Mês anterior',
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Expanded(
                    child: Text(
                      '${monthNames[_month.month - 1]} ${_month.year}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _canGoForward ? () => _shiftMonth(1) : null,
                    tooltip: 'Próximo mês',
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _MonthGrid(
                month: _month,
                selected: selected,
                first: _first,
                last: _last,
                onPick: _pick,
              ),
            ],
          ),
        ),
        if (selected == null)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 28),
            child: Text(
              'Toque em um dia para buscar as fotos.',
              textAlign: TextAlign.center,
              style: AppText.body,
            ),
          )
        else
          _DayResults(day: selected, loading: _loading),
      ],
    );
  }
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.month,
    required this.selected,
    required this.first,
    required this.last,
    required this.onPick,
  });

  final DateTime month;
  final DateTime? selected;
  final DateTime first;
  final DateTime last;
  final ValueChanged<DateTime> onPick;

  @override
  Widget build(BuildContext context) {
    // weekday: 1 = segunda … 7 = domingo; a grade começa no domingo.
    final leadingBlanks = month.weekday % 7;
    final daysInMonth = DateTime.utc(month.year, month.month + 1, 0).day;

    return Column(
      children: [
        Row(
          children: [
            for (final d in const ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'])
              Expanded(
                child: Text(
                  d,
                  textAlign: TextAlign.center,
                  style: AppText.mono.copyWith(fontSize: 10),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            mainAxisExtent: 40,
          ),
          itemCount: leadingBlanks + daysInMonth,
          itemBuilder: (context, i) {
            if (i < leadingBlanks) return const SizedBox.shrink();
            final day = DateTime.utc(month.year, month.month, i - leadingBlanks + 1);
            final enabled = !day.isBefore(first) && !day.isAfter(last);
            final on = day == selected;
            return Semantics(
              selected: on,
              label: '${day.day} de ${monthNames[day.month - 1]} de ${day.year}',
              child: Material(
                color: on ? AppColors.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: enabled ? () => onPick(day) : null,
                  child: Center(
                    child: ExcludeSemantics(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: on ? FontWeight.w700 : FontWeight.w400,
                          color: on
                              ? AppColors.onAccent
                              : enabled
                                  ? AppColors.text
                                  : AppColors.handle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _DayResults extends StatelessWidget {
  const _DayResults({required this.day, required this.loading});

  final DateTime day;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final sol = MockData.solForDate(day);
    final photos = MockData.photos(sol: sol, count: 6, date: day);
    final next = day.add(const Duration(days: 1));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Text(formatDate(day), style: AppText.sectionTitle),
            ),
            Text(
              loading ? 'buscando…' : '${photos.length} fotos · Sol $sol',
              style: AppText.body.copyWith(fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'date_taken:gte ${formatIsoDate(day)} · date_taken:lt ${formatIsoDate(next)}',
          style: AppText.mono.copyWith(fontSize: 10),
        ),
        const SizedBox(height: 12),
        if (loading)
          const PhotoGridSkeleton(count: 6)
        else
          PhotoGrid(photos: photos),
      ],
    );
  }
}
