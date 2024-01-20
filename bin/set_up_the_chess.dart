void main() {
  presentPos = parsePosition('K', true); //to do
}

enum Type { pawn, knight, bishop, rook, queen, king }

//presentPos.length < 32
var presentPos = <Piece>[];
var startPos = <Piece>[];

bool areThereAnyMatches(List<Piece> posW, List<Piece> posN) {
  int i, j;
  bool res = false;
  //check b-b matches
  for (i = 0; i < posN.length; i++) {
    for (j = i + 1; j < posN.length; j++) {
      if (Piece.isTheSameLoc(posN[i], posN[j])) break;
    }
  }
  if (i < posN.length) {
    res = true;
  } else {
    for (i = 0; i < posW.length; i++) {
      //check w-w matches
      j = i + 1;
      while ( j < posW.length && !Piece.isTheSameLoc(posW[i], posW[j])) {
        j++;
      }
      if (i < posW.length) break;
      //check w-b matches
      for (j = 0; j < posN.length; j++) {
        if (Piece.isTheSameLoc(posW[i], posN[j])) break;
      }
      if (i < posN.length) break;
    }
  }
  return res;
}

Piece parsePiece(String s, bool nigger) {
  Type type;
  int hc = s[0].hashCode;
  final hcA = 'a'.hashCode;
  final hcH = 'h'.hashCode;

  if (hc >= hcA && hc <= hcH) {
    type = Type.pawn;
    s = 'P$s';
  } else {
    type = switch (s[0]) {
      'N' => Type.knight,
      'B' => Type.bishop,
      'R' => Type.rook,
      'Q' => Type.queen,
      'K' => Type.king,
      _ => throw Exception('creating piece err')
    };
    hc = s[1].hashCode;
    if (hc < hcA || hc > hcH) {
      throw Exception('creating piece err');
    }
  }
  int h = hc - hcA;

  int v = int.tryParse(s[2], radix: 9) ?? 0;
  if (v == 0) throw Exception();
  v -= 1;

  return Piece(type, h, v, nigger);
}

List<Piece> parsePosition(String s, bool nigger) {
  var words = s.split(' ');
  return [for (var word in words) parsePiece(word, nigger)];
}

class Piece {
  final Type type;
  final int h;
  final int v;
  final bool nigger;

  Piece(this.type, this.h, this.v, this.nigger);

  static bool isTheSameLoc(Piece p1, p2) {
    return (p1.h == p2.h && p1.v == p2.v);
  }
}



















import 'dart:math' as Math;

void main() {
  presentPosW = parsePosition('Kh8'); //to do
}

enum Type { pawn, knight, bishop, rook, queen, king }

//presentPos.length < 32
var presentPosW = <Piece>[];
var presentPosN = <Piece>[];
var targetPosW = <Piece>[];
var targetPosN = <Piece>[];

var prsMatch = <Piece>[];
var trgMatch = <Piece>[];

void findMatches(List<Piece> prsList, List<Piece> trgList) {
  //подсчет пешек, ферзей и тд
  Map<Type, List<Piece>> prs = countPieces(prsList);
  Map<Type, List<Piece>> trg = countPieces(trgList);
  
  for (Type t in Type.values) {
    //сколько ищем пар
    final matchAmount = Math.min(prs[t]!.length, trg[t]!.length);
    //останется 
    final remainder = (prs[t]!.length- trg[t]!.length).abs();    
    List<List<double>> m = makeMatrix(prs[t]!.length, trg[t]!.length);
    //всевозможные расстояния
    for (int i = 0; i < prs[t]!.length; i++) {
      for (int j = 0; j < trg[t]!.length; j++) {
        m[i][j] = r(prs[t]![i], trg[t]![j]);
      }
    }
    double max, min;
    int ii = 0;
    int jj = 0;
    for (int n = 0; n < matchAmount; n++){
      max = 0.0;
      for (int i = 0; i < m.length; i++) {
        min = 128.0;
        for (int j = 0; j < m[i].length; j++) {
          min = Math.min(m[i][j], min);
          int jj = j;
        }
        max = Math.max(min, max);
        int ii = i;
      }
      //работает только при remainder==0 TODO
      //запись в ответ
      prsMatch.add(prs[t]![ii]);
      trgMatch.add(trg[t]![jj]);
      for (int i = 0; i < m.length; i++) m[i][jj] =128;
      for (double d in m[ii]) d = 128;
    }
  }
  
}

double r(Piece a, Piece b)
  => Math.sqrt(Math.pow(a.h - b.h, 2) + Math.pow(a.v - b.v, 2));

Map<Type, List<Piece>> countPieces(List<Piece> l) {
  Map<Type, List<Piece>> m = {for (var value in Type.values) value:[]};
  for (Piece p in l) {
    m[p.type]!.add(p);
  }
  return m;
}

List<List<double>> makeMatrix(int a, int b) {
  int size = 10;
  List<List<double>> matrix = List<List<double>>(size);
  for (var i = 0; i < size; i++) {
    matrix[i] = List<double>(size);

    for (double e in matrix[i]) {
      e = 0.0;
    }

  }
  return matrix;
}

bool areThereAnyMatches(List<Piece> posW, List<Piece> posN) {
  bool res;
  int i, j;
  //check n-n matches
  int n = posN.length;
  for (i = 0; i < posN.length - 1 && n == posN.length; i++) {
    n = i + 1;
    while (n < posN.length && !Piece.isTheSameLoc(posN[i], posN[n])) {
      n++;
    }
  }
  if (n < posN.length) {
    res = true;
  } else {
    for (i = 0; i < posW.length && n == posN.length; i++) {
      //check w-w matches
      j = i + 1;
      while (j < posW.length && !Piece.isTheSameLoc(posW[i], posW[j])) {
        j++;
      }
      if (j < posW.length) break;
      //check w-n matches
      n = 0;
      while (n < posN.length && Piece.isTheSameLoc(posW[i], posN[n])) {
          n++;
      }
    }
    res = j < posW.length || n < posN.length;
  }
  return res;
}

Piece parsePiece(String s) {
  Type type;
  int hc = s[0].hashCode;
  final hcA = 'a'.hashCode;
  final hcH = 'h'.hashCode;

  if (hc >= hcA && hc <= hcH) {
    type = Type.pawn;
    s = 'P$s';
  } else {
    type = switch (s[0]) {
      'N' => Type.knight,
      'B' => Type.bishop,
      'R' => Type.rook,
      'Q' => Type.queen,
      'K' => Type.king,
      _ => throw Exception('creating piece err')
    };
    hc = s[1].hashCode;
    if (hc < hcA || hc > hcH) {
      throw Exception('creating piece err');
    }
  }
  int h = hc - hcA;

  int v = int.tryParse(s[2], radix: 9) ?? 0;
  if (v == 0) throw Exception();
  v -= 1;

  return Piece(type, h, v);
}

List<Piece> parsePosition(String s) {
  var words = s.split(' ');
  return [for (var word in words) parsePiece(word)];
}

class Piece {
  final Type type;
  final int h;
  final int v;

  Piece(this.type, this.h, this.v);

  static bool isTheSameLoc(Piece p1, p2) {
    return (p1.h == p2.h && p1.v == p2.v);
  }
}
