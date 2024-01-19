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
