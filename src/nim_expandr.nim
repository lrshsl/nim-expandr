import pkg/microparsec except `>>`
import nim_expandrpkg/andThenParser

export microparsec except `>>`
export `>>`, `<>`

when isMainModule:
  echo "\n>> Done"
