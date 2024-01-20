import 'dart:math' as math;

void main() {
  presentPosW = parsePosition('Kh8'); //to do
}

enum Type { pawn, knight, bishop, rook, queen, king }

//presentPos.length < 32
var presentPosW = <Piece>[];
var presentPosN = <Piece>[];
var targetPosW = <Piece>[];
var targetPosN = <Piece>[];

void findMatches(List<Piece> prsList, List<Piece> trgList) {
  //подсчёт пешек, ферзей и тд
  Map<Type, List<Piece>> prs = countPieces(prsList);
  Map<Type, List<Piece>> trg = countPieces(trgList);

  for (Type t in Type.values) {
    int remainder = trg[t]!.length - prs[t]!.length;
    int matchAmount; //сколько ищем пар

    if (remainder >= 0) {
      matchAmount = trg[t]!.length - remainder;
      //всевозможные расстояния
      for (int i = 0; i < prs[t]!.length; i++) {
        for (int j = 0; j < trg[t]!.length; j++) {
          //m[i][j] = r(prs[t]![i], trg[t]![j]);
        }
      }
    } else {
      matchAmount = remainder - trg[t]!.length;
    }
  }
}

(List<Piece>, List<Piece>) optimPairs(List<Piece> small, List<Piece> big) {
  List<Piece> halfFromSmall = [], halfFromBig = [];

  List<List<double>> m = List.generate(
      big.length, growable: false, (_) => List.filled(big.length, 0.0));
  for (int i = 0; i < small.length; i++) {
    for (int j = 0; j < small.length; j++) {
      m[i][j] = r(big[i], small[j]);
    }
  }
  double max, min;
  int ii = -1, jj = -1;
  for (int n = 0; n < small.length; n++) {
    max = 0.0;
    for (int i = 0; i < m.length; i++) {
      min = 1e+6;
      for (int j = 0; j < m[i].length; j++) {
        if (m[i][j] < min) {
          min = m[i][j];
          jj = j;
        }
      }
      if (min > max) {
        max = min;
        ii = i;
      }
    }

    halfFromBig.add(big[ii]);
    halfFromSmall.add(small[jj]);
    for (int i = 0; i < m.length; i++) {
      m[i][jj] = 0;
    }
    for (double d in m[ii]) {
      d = 128;
    }
  }
  return (halfFromSmall, halfFromBig);
}

(double, Stack) someRecursive(List<List<double>> m) {
  // m.length < m[0].length
  double min = 1e+6;
  int i, j = 0;
  Stack path = Stack();

  if (m.length == 2) {
    for (i = 0; i < m[0].length; i++) {
      for (; j < i; j++) {
        min = math.min(min, m[0][i] + m[1][j]);
      }
      for (j++; j < m[1].length; j++) {
        min = math.min(min, m[0][i] + m[1][j]);
      }
    }
    return (min, Stack.init(j, i));
  } else {
    for (int i = 0; i < m[0].length; i++) {
      List<List<double>> truncatedM = [...m];
      truncatedM.removeAt(i);
      for (int j = 0; j < truncatedM[0].length; j++) {
        truncatedM[j].removeAt(j);
      }
      var (d, token) = someRecursive(truncatedM);
      if (d < min) {
        min = d;
        path = token;
        path.push(i);
      }
    }
    return (min, path);
  }
}

class Stack {
  final List<int> _path = [];

  void push(int i) => _path.add(i);

  get pop => _path.removeLast();

  Stack();

  Stack.init(int a, int b) {
    _path.addAll([a, b]);
  }
}

double r(Piece a, Piece b) =>
    math.sqrt(math.pow(a.h - b.h, 2) + math.pow(a.v - b.v, 2));

Map<Type, List<Piece>> countPieces(List<Piece> l) {
  Map<Type, List<Piece>> m = {for (var value in Type.values) value: []};
  for (Piece p in l) {
    m[p.type]!.add(p);
  }
  return m;
}

bool areThereAnyMatches(List<Piece> posW, List<Piece> posN) {
  bool res;
  int i, j = 0;
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
