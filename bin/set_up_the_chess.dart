import 'dart:convert';
import 'dart:math' as math;

void main() {
  var presentPosW = parsePosition('Kg1 Rf1 f2 g3 h4'),
      presentPosN = parsePosition('Kg8 Rf8 f7 g6 h5'),
      targetPosW = parsePosition(
          'a2 b2 c2 d2 e2 f2 g2 h2 Ra1 Nb1 Bc1 Qd1 Ke1 Bf1 Ng1 Rh1'),
      targetPosN = parsePosition(
          'a7 b7 c7 d7 e7 f7 g7 h7 Ra8 Nb8 Bc8 Qd8 Ke8 Bf8 Ng8 Rh8');

  var matchesInPresent = areThereAnyMatches(presentPosW, presentPosN),
      matchesInTarget = areThereAnyMatches(targetPosW, targetPosN);
  if (matchesInPresent != null || matchesInTarget != null) {
    throw Exception(matchesInPresent ?? ('target', matchesInTarget));
  }

  var (prsToMoveW, trgToMoveW) = findMatches(presentPosW, targetPosW);
  var (prsToMoveN, trgToMoveN) = findMatches(presentPosN, targetPosN);

  print('---WHITE---');
  print(prsToMoveW);
  print('----TO----');
  print(trgToMoveW);
  print('---NIGGERS---');
  print(prsToMoveN);
  print('----TO----');
  print(trgToMoveN);
}

(List<Piece>, List<Piece>) findMatches(
    List<Piece> prsList, List<Piece> trgList) {
  var prsHalf = <Piece>[], trgHalf = <Piece>[];
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
  List<List<double>> matrix = List.generate(
      small.length,
      growable: false,
      (_) => List.filled(big.length, 0.0, growable: true));
  for (int i = 0; i < small.length; i++) {
    for (int j = 0; j < big.length; j++) {
      matrix[i][j] = r(small[i], big[j]);
    }
  }

  MyStack stack = theBestSet(matrix).$2;
  List<Piece> halfFromBig =
      List.generate(stack.length, (index) => big[stack.at(index)]);
  return halfFromBig;
}

(double, MyStack) theBestSet(List<List<double>> m) {
  // m.length < m[0].length
  int j = 0, i;
  double min = 1e+6;
  if (m.isEmpty) {
    return (0.0, MyStack([]));
  } else if (m.length == 1) {
    int ii = -1;
    for (i = 0; i < m[0].length; i++) {
      if (m[0][i] < min) {
        min = m[0][i];
        ii = i;
      }
    }
    return (min, MyStack([ii]));
  } else if (m.length == 2) {
    int ii = -1, jj = -1;
    for (i = 0; i < m[0].length; i++) {
      for (j = 0; j < i; j++) {
        if (min > m[0][i] + m[1][j]) {
          min = m[0][i] + m[1][j];
          ii = i;
          jj = j;
        }
      }
      for (j = i + 1; j < m[1].length; j++) {
        if (min > m[0][i] + m[1][j]) {
          min = m[0][i] + m[1][j];
          ii = i;
          jj = j;
        }
      }
    }
    return (min, MyStack([jj, ii]));
  } else {
    MyStack path = MyStack.err();
    List<List<double>> nedoTruncatedM = m.skip(1).toList(growable: false);
    for (int i = 0; i < m[0].length; i++) {
      var trM = withoutLine(i, nedoTruncatedM);
      var (d, token) = theBestSet(trM);
      if (d + m[0][i] < min) {
        min = d + m[0][i];
        path = token;
        path.forUntoEveryOneThatHathShallBeGiven(i);
        path.push(i);
      }
    }
    return (min, path);
  }
}

List<List<double>> withoutLine(int line, List<List<double>> nedoTruncatedM) => [
      for (int j = 0; j < nedoTruncatedM.length; j++)
        [...nedoTruncatedM[j].take(line), ...nedoTruncatedM[j].skip(line + 1)]
    ];

double r(Piece a, Piece b) =>
    math.sqrt(math.pow(a.h - b.h, 2) + math.pow(a.v - b.v, 2));

Map<Type, List<Piece>> countPieces(List<Piece> l) {
  Map<Type, List<Piece>> m = {for (var value in Type.values) value: []};
  for (Piece p in l) {
    m[p.type]!.add(p);
  }
  return m;
}

enum Color { whiteWhite, whiteNigger, niggerNigger }

// Color value represents, where exactly was match
(Piece, Piece, Color)? areThereAnyMatches(List<Piece> posW, List<Piece> posN) {
  (Piece, Piece, Color)? res;
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
    res = (posN[i], posN[n], Color.niggerNigger);
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
      while (n < posN.length && !Piece.isTheSameLoc(posW[i], posN[n])) {
        n++;
      }
    }
    if (j < posW.length) {
      res = (posW[i], posW[j], Color.whiteWhite);
    } else if (n < posN.length) {
      res = (posW[i], posN[n], Color.whiteNigger);
    }
  }
  return res;
}

Piece parsePiece(String s) {
  Type type;
  int hc = s[0].codeUnitAt(0);
  final hcA = 'a'.codeUnitAt(0), hcH = 'h'.codeUnitAt(0);

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
    hc = s[1].codeUnitAt(0);
    if (hc < hcA || hc > hcH) {
      throw Exception('creating piece err');
    }
  }
  int h = hc - hcA;

  int v = int.tryParse(s[2], radix: 9) ?? 0;
  if (v == 0) throw Exception();
  v--;

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

  get letter => Utf8Decoder().convert(["a".codeUnitAt(0) + h]);

  static int toH(String s) => s.codeUnitAt(0) - 'a'.codeUnitAt(0);

  @override
  String toString() {
    return '''
    
${type.name} $letter($h)($v)''';
  }
}

enum Type { pawn, knight, bishop, rook, queen, king }

class MyStack {
  MyStack(List<int> args) : _path = List.from(args);

  MyStack.err() : _path = List.filled(256, 404);

  final List<int> _path;

  void push(int i) => _path.add(i);

  get pop => _path.removeLast();

  get length => _path.length;

  int at(int index) => _path[_path.length - 1 - index];

  void forUntoEveryOneThatHathShallBeGiven(int lineNum) {
    for (int i = 0; i < _path.length; i++) {
      if (_path[i] >= lineNum) {
        _path[i]++;
      }
    }
  }

  @override
  String toString() => _path.toString();
}
