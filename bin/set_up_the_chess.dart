import 'dart:convert';
import 'dart:math' as math;

void main() {
//   var presentPosW = parsePosition('Kg1 Rf1 f2 g3 h4'),
//       presentPosN = parsePosition('Kg8 Rf8 f7 g6 h5'),
//       targetPosW = parsePosition(
//           'a2 b2 c2 d2 e2 f2 g2 h2 Ra1 Nb1 Bc1 Qd1 Ke1 Bf1 Ng1 Rh1'),
//       targetPosN = parsePosition(
//           'a7 b7 c7 d7 e7 f7 g7 h7 Ra8 Nb8 Bc8 Qd8 Ke8 Bf8 Ng8 Rh8');
//   ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  var presentPosW = parsePosition(''),
      presentPosN = parsePosition('e3 d3 a7 f3 a2 h7'),
      targetPosW = parsePosition(''),
      targetPosN = parsePosition('c5 d6 f5 g2');

  var matchesInPresent = areThereAnyMatches(presentPosW, presentPosN),
      matchesInTarget = areThereAnyMatches(targetPosW, targetPosN);
  
  if (matchesInPresent != null || matchesInTarget != null) {
    throw Exception(matchesInPresent ?? ('target', matchesInTarget));
  }

  var [prsToMoveW, trgToMoveW, restW] = findMatches(presentPosW, targetPosW);
  var [prsToMoveN, trgToMoveN, restN] = findMatches(presentPosN, targetPosN);

  var output = [''];
    output.add('---WHITE---');
  if (prsToMoveW.isEmpty) {
    output.add('No pieces to move');
  } else {
    output.add('Pieces to move:');
    for (var (i, e) in prsToMoveW.indexed) {
      var to = trgToMoveW[i].toString().replaceFirst(
          trgToMoveW[i].type.name, '');
      output.add('$e ->$to');
    }
    if (restW.isNotEmpty) {
      output.add('');
      output.add('Other pieces:');
      output.addAll([for (Piece p in restW) p.toString()]);
    }
  }
  var leftWidth = output.fold(0, (max, e) => math.max(max, e.length));
  leftWidth += 2;
  
  int counter = 0;
  
  void onRight(String s) {
    if (counter == output.length) {
      print(' ' * leftWidth + s);
    } else {
      print(output[counter].padRight(leftWidth) + s);
      counter++;
    }
  }
  
  onRight('');
  onRight('---NIGGERS---');
  if (prsToMoveN.isEmpty) {
    onRight('No pieces to move');
  } else {
    onRight('Pieces to move:');
    for (var (i, e) in prsToMoveN.indexed) {
      var to = trgToMoveN[i].toString().replaceFirst(
          trgToMoveN[i].type.name, '');
      onRight('$e ->$to');
    }
    if (restN.isNotEmpty) {
      onRight('');
      onRight('Other pieces:');
      [for (Piece p in restN) p.toString()].forEach(onRight);
    }
  }
  output.skip(counter).forEach(print);
}

List<List<Piece>> findMatches(
    List<Piece> prsList, List<Piece> trgList) {
  final [prsHalf, trgHalf, prsRest] =
    [for(var i = 0; i < 3; i++) <Piece>[]];
  //подсчёт пешек, ферзей и тд
  Map<Type, List<Piece>> prs = countPieces(prsList);
  Map<Type, List<Piece>> trg = countPieces(trgList);

  (List<Piece>, List<Piece>) rec;
  for (Type t in Type.values) {
    if (trg[t]!.length >= prs[t]!.length) {
      prsHalf.addAll(prs[t]!);
      rec = selectFromBig(prs[t]!, trg[t]!);
      trgHalf.addAll(rec.$1);
      prsRest.addAll(rec.$2);
    } else {
      trgHalf.addAll(trg[t]!);
      rec = selectFromBig(trg[t]!, prs[t]!);
      prsHalf.addAll(rec.$1);
      prsRest.addAll(rec.$2);
    }
  }
  return [prsHalf, trgHalf, prsRest];
}

(List<Piece>, List<Piece>) selectFromBig(List<Piece> small, List<Piece> big) {
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
  var indexes = stack.toList;
  indexes.sort();
  var d = [-1, ...indexes, big.length];
  var rest = [for (int i = 0; i < d.length - 1; i++)
              ...big.getRange(d[i]+1, d[i+1])];
  return (halfFromBig, rest);
}

(double, MyStack) theBestSet(List<List<double>> m) {
  // m.length < m[0].length
  int j = 0;
  double min = 1e+6;
  int length = m.length;
  switch (length) {
    case 0:
      return (0.0, MyStack([]));
    case 1:
      int ii = -1;
      for (var (i, e) in m[0].indexed) {
        if (e < min) {
          min = e;
          ii = i;
        }
      }
      return (min, MyStack([ii]));
    case 2:
      int ii = -1, jj = -1;
      for (var (i, e) in m[0].indexed) {
        for (j = 0; j < i; j++) {
          if (min > e + m[1][j]) {
            min = e + m[1][j];
            ii = i;
            jj = j;
          }
        }
        for (j = i + 1; j < m[1].length; j++) {
          if (min > e + m[1][j]) {
            min = e + m[1][j];
            ii = i;
            jj = j;
          }
        }
      }
      return (min, MyStack([jj, ii]));
    default:
      MyStack path = MyStack.err();
      List<List<double>> nedoTruncatedM = m.skip(1).toList(growable: false);
      for (var (i, e) in m[0].indexed) {
        var trM = withoutLine(i, nedoTruncatedM);
        var (d, token) = theBestSet(trM);
        if (d + e < min) {
          min = d + e;
          path = token;
          path.forUntoEveryOneThatHathShallBeGiven(i);
          path.push(i);
        }
      }
      return (min, path);
  }
}

List<List<double>> withoutLine(int line, List<List<double>> nedoTruncatedM) => [
      for (var e in nedoTruncated)
        [...e.take(line), ...e.skip(line + 1)]
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
  if (s == '') {
    return [];
  } else {
    var words = s.split(' ');
    return [for (var word in words) parsePiece(word)];
  }
}

class Piece {
  final Type type;
  final int h;
  final int v;

  Piece(this.type, this.h, this.v);

  static bool isTheSameLoc(Piece p1, p2) {
    return (p1.h == p2.h && p1.v == p2.v);
  }

  get letter => const Utf8Decoder().convert(["a".codeUnitAt(0) + h]);

  static int toH(String s) => s.codeUnitAt(0) - 'a'.codeUnitAt(0);

  @override
  String toString() {
    return '''
${type.name} $letter${v + 1}''';
  }
}

class MyStack {
  MyStack(List<int> args) : _path = List.from(args);

  MyStack.err() : _path = List.filled(256, 404);

  final List<int> _path;

  void push(int i) => _path.add(i);

  int get pop => _path.removeLast();

  int get length => _path.length;
  
  List<int> get toList => _path;

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

enum Type { pawn, knight, bishop, rook, queen, king }

enum Color { whiteWhite, whiteNigger, niggerNigger }
