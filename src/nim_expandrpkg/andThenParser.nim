import microparsec/types except `>>`, `<>`
import results

# Sequential parser that returns a tuple (andThen)
#
# The `>>` operator from the microparsec library discards all but
# the last value, which is not the behavior I want
proc `>>`*[A, B](a: Parser[A], b: Parser[B]): Parser[(A, B)] =
  func(state: ParseState): ParseResult[(A, B)] =
      ParseResult[(A, B)].ok (?a state, ?b state)


# Sequential parser that tries to concatenate (flatAndThen)
proc `<>`*[A](a: Parser[A], b: Parser[A]): Parser[seq[A]] =
  func(state: ParseState): ParseResult[seq[A]] =
    ParseResult[seq[A]].ok @[?a state, ?b state]


proc `<>`*[A](p: Parser[A], ps: Parser[seq[A]]): Parser[seq[A]] =
  func(state: ParseState): ParseResult[seq[A]] =
    ParseResult[seq[A]].ok @[?p state] & (?ps state)


proc `<>`*[A](ps: Parser[seq[A]], p: Parser[A]): Parser[seq[A]] =
  func(state: ParseState): ParseResult[seq[A]] =
    ParseResult[seq[A]].ok (?ps state) + (?p state)


proc `<>`*[A](a: Parser[seq[A]], b: Parser[seq[A]]): Parser[seq[A]] =
  func(state: ParseState): ParseResult[seq[A]] =
    ParseResult[seq[A]].ok (?a state) & (?b state)


