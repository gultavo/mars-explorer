String _pad(int n) => n.toString().padLeft(2, '0');

/// dd/MM/aaaa
String formatDate(DateTime d) => '${_pad(d.day)}/${_pad(d.month)}/${d.year}';

/// dd/MM/aaaa · HH:mm
String formatDateTime(DateTime d) =>
    '${formatDate(d)} · ${_pad(d.hour)}:${_pad(d.minute)}';

/// aaaa-MM-dd (formato dos filtros `date_taken` da API)
String formatIsoDate(DateTime d) => '${d.year}-${_pad(d.month)}-${_pad(d.day)}';

const monthNames = [
  'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', //
  'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro',
];
