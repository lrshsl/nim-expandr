import unittest, strutils, sugar

import nim_expandr

suite "andThen parsers":

  test "andThen: (A >> B) -> tuple[A, B]":
    let
      chars2Num = compose((chars: seq[char]) => chars.join(""), parseInt)
      num = map(many1 digit, chars2Num)
      p = (ch 'a') >> num

    check p.debugParse("a42c") == $(('a', 42), "c")
    check p.debugParse("abc") == $(unexpected: "\'b\'", expected: @["digit"])

  test "flatAndThen: (A <> A) -> seq[A]":
    let p = (ch 'a') <> (ch 'b')
    check p.debugParse("abc") == $(@['a', 'b'], "c")
    check p.debugParse("cba") == $(unexpected: "\'c\'", expected: @["\'a\'"])

  test "flatAndThen: (A <> seq[A]) -> seq[A]":
    let
      ident = (letter <|> ch '_') <> many (letter <|> digit <|> ch '_')

    check ident.debugParse("id_42 and rest") == $(@['i', 'd', '_', '4', '2'], " and rest")
    check ident.debugParse("#") == $(unexpected: "\'#\'", expected: @["letter", "\'_\'"])

