import 'dart:math' as math;

void main() {
  var
    presentPosW = parsePosition('Kg1 Rf1 f2 g3 h4'),
    presentPosN = parsePosition('Kg8 Rf8 f7 g6 h5'),
    targetPosW = parsePosition('a2 b2 c2 d2 e2 f2 g2 h2 Ra1 Nb1 Bc1 Qd1 Ke1 Bf1 Ng1 Rh1'),
    targetPosN = parsePosition('a7 b7 c7 d7 e7 f7 g7 h7 Ra8 Nb8 Bc8 Qd8 Ke8 Bf8 Ng8 Rh8');
  
  bool b =
    areThereAnyMatches(presentPosW, presentPosN)
    || areThereAnyMatches(targetPosW, targetPosN);
  if (b) throw Exception('');
  
  var
    (prsToMoveW, trgToMoveW) = findMatches(presentPosW, presentPosW),
    (prsToMoveN, trgToMoveN) = findMatches(presentPosN, presentPosN);
  print(prsToMoveW);
  print(trgToMoveW);
  print(prsToMoveN);
  print(trgToMoveN);
}

(List<Piece>, List<Piece>) findMatches(List<Piece> prsList, List<Piece> trgList) {
  var
    prsHalf = <Piece>[],
    trgHalf = <Piece>[];
  //подсчёт пешек, ферзей и тд
  Map<Type, List<Piece>> prs = countPieces(prsList);
  Map<Type, List<Piece>> trg = countPieces(trgList);

  for (Type t in Type.values) {
    if (trg[t]!.length >= prs[t]!.length) {
      prsHalf.addAll(prs[t]!);
      trgHalf.addAll(selectFromBig(prs[t]!, trg[t]!));
    } else {
      trgHalf.addAll(trg[t]!);
      prsHalf.addAll(selectFromBig(trg[t]!, prs[t]!));
    }
  }
  return (prsHalf, trgHalf);
}

List<Piece> selectFromBig(List<Piece> small, List<Piece> big) {
  List<Piece> halfFromBig = [];

  List<List<double>> m = List.generate(
      small.length, growable: false, (_) => List.filled(big.length, 0.0));
  for (int i = 0; i < small.length; i++) {
    for (int j = 0; j < big.length; j++) {
      m[i][j] = r(small[i], big[j]);
    }
  }
  
  Stack stack = bestSet(m).$1;
  for (int i = 0; i < stack.length; i++) {
      halfFromBig[i] = big[stack.pop];
  }
  
  return halfFromBig;
}

(double, Stack) bestSet(List<List<double>> m) {
  // m.length < m[0].length
  int
    j = 0,
    i;
  double min = 1e+6;
  Stack path = Stack();
  if (m.isEmpty) {
      return (0.0, path);
  } else if (m.single != null) {
    int ii = -1;
    for (i = 0; i < m[0].length; i++) {
      if (m[0][i] < min) {
        min = m[0][i];
        ii = i;
      }
    }
    path.push(ii);
    return (min, path);
  } else if (m.length == 2) {
    int
      ii = -1,
      jj = -1;
    for (i = 0; i < m[0].length; i++) {
      for (j = 0; j < i; j++) {
        if (min > m[0][i] + m[1][j]) {
          min = m[0][i] + m[1][j];
          ii = i;
          jj = j;
        }
      }
      for (j++; j < m[1].length; j++) {
        if (min > m[0][i] + m[1][j]) {
          min = m[0][i] + m[1][j];
          ii = i;
          jj = j;
        }
      }
    }
    return (min, Stack.init([jj, ii]));
  } else {
    for (int i = 0; i < m[0].length; i++) {
      List<List<double>> truncatedM = [...m];
      truncatedM.removeAt(i);
      for (int j = 0; j < truncatedM[0].length; j++) {
        truncatedM[j].removeAt(j);
      }
      var (d, token) = bestSet(truncatedM);
      if (d < min) {
        min = d;
        path = token;
        path.push(i);
      }
    }
    return (min, path);
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

enum Type { pawn, knight, bishop, rook, queen, king }

class Stack {
  Stack();
  Stack.init(List<int> args) {
    _path.addAll(args);
  }
  
  final List<int> _path = [];

  void push(int i) => _path.add(i);
  get pop => _path.removeLast();

  get length => _path.length;
}