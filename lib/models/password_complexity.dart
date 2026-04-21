enum PasswordComplexity {
  low(minLength: 4, maxLength: 6),
  medium(minLength: 7, maxLength: 10),
  high(minLength: 11, maxLength: 16);

  final int minLength;
  final int maxLength;

  const PasswordComplexity({
    required this.minLength,
    required this.maxLength,
  });
}



extension PasswordComplexityExtension on PasswordComplexity {
String get title {
 switch (this) {
 case PasswordComplexity.low:
 return 'Baixa';
 case PasswordComplexity.medium:
 return 'Média';
 case PasswordComplexity.high:
 return 'Alta';
 }
 }
int get length {
 switch (this) {
    case PasswordComplexity.low:
        return 4;
    case PasswordComplexity.medium:
        return 4;
    case PasswordComplexity.high:
        return 4;
 }
 }
 
}


