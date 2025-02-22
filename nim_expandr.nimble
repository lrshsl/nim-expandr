# Package

version       = "0.1.0"
author        = "lrshsl"
description   = "A new awesome nimble package"
license       = "EPL-2.0"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["nim_expandr"]


# Dependencies

requires "nim >= 2.2.0"
requires "microparsec >= 0.1.0"

task fmt, "Formats all nim files":
  exec "find . -name '*.nim' -exec nimpretty --indent:2 {} +"

