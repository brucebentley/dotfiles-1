if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:javac='javac'

execute 'CompilerSet makeprg=' . s:javac

CompilerSet errorformat=
  \%E%f:%l:%c%\\s%\\+-%\\s%\\+%trror%\\s%\\+TS%n:%\\s%\\+%m,


finish
errorformat.java:29: error: ';' expected
      else f (option.equals("java")) {
                                    ^
errorformat.java:46: error: ';' expected
      else i (option.equals("sql")) {
                                   ^
errorformat.java:35: error: 'else' without 'if'
      else if (option.equals("perl")) {
      ^
errorformat.java:50: error: 'else' without 'if'
      else {
      ^
errorformat.java:58: error: ';' expected
    whie (RestartLoop = true) {
                             ^
errorformat.java:81: error: ';' expected
    topic()
           ^
6 errors
