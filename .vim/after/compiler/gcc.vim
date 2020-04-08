if exists(':CompilerSet') != 2
    command -nargs=* CompilerSet setlocal <args>
endif

let s:gcc='gcc'

CompilerSet errorformat=
            \%*[^\"]\"%f\"%*\\D%l:%c:\ %m,
            \%*[^\"]\"%f\"%*\\D%l:\ %m,
            \\"%f\"%*\\D%l:%c:\ %m,
            \\"%f\"%*\\D%l:\ %m,
            \%-G%f:%l:\ %trror:\ (Each\ undeclared\ identifier\ is\ reported\ only\ once,
            \%-G%f:%l:\ %trror:\ for\ each\ function\ it\ appears\ in.),
            \%f:%l:%c:\ %trror:\ %m,
            \%f:%l:%c:\ %tarning:\ %m,
            \%f:%l:%c:\ %m,
            \%f:%l:\ %trror:\ %m,
            \%f:%l:\ %tarning:\ %m,
            \%f:%l:\ %m,
            \%f:\\(%*[^\\)]\\):\ %m,
            \\"%f\"\\,\ line\ %l%*\\D%c%*[^\ ]\ %m,
            \%D%*\\a[%*\\d]:\ Entering\ directory\ %*[`']%f',
            \%X%*\\a[%*\\d]:\ Leaving\ directory\ %*[`']%f',
            \%D%*\\a:\ Entering\ directory\ %*[`']%f',
            \%X%*\\a:\ Leaving\ directory\ %*[`']%f',
            \%DMaking\ %*\\a\ in\ %f

execute 'CompilerSet makeprg=' . s:gcc

if exists('g:compiler_gcc_ignore_unmatched_lines')
    CompilerSet errorformat+=%-G%.%#
endif

finish
Compiled src/function.cpp 
In file included from src/function.cpp:3:
src/port-config.hpp:38:24: error: 'LEFT_INTAKE' was not declared in this scope; did you mean 'RIGHT_INTAKE'?
38 |         -RIGHT_INTAKE, LEFT_INTAKE,
|                        ^~~~~~~~~~~
|                        RIGHT_INTAKE
src/port-config.hpp:50:8: error: 'RIGHT_TRAY' was not declared in this scope
50 |       -RIGHT_TRAY, LEFT_TRAY,
|        ^~~~~~~~~~
src/port-config.hpp:55:25: error: 'LEFT_INTAKE' was not declared in this scope; did you mean 'RIGHT_INTAKE'?
55 |         {-RIGHT_INTAKE, LEFT_INTAKE}
|                         ^~~~~~~~~~~
|                         RIGHT_INTAKE
src/port-config.hpp:56:15: error: no matching function for call to 'okapi::AsyncControllerFactory::posIntegrated(<brace-enclosed initializer list>)'
56 |               );
|               ^
In file included from ./include/okapi/api.hpp:36,
from src/port-config.hpp:4,
from src/function.cpp:3:
./include/okapi/impl/control/async/asyncControllerFactory.hpp:118:3: note: candidate: 'static okapi::AsyncPosIntegratedController okapi::AsyncControllerFactory::posIntegrated(okapi::Motor, int32_t, const okapi::TimeUtil&)'
118 |   posIntegrated(Motor imotor,
|   ^~~~~~~~~~~~~
./include/okapi/impl/control/async/asyncControllerFactory.hpp:118:23: note:   no known conversion for argument 1 from '<brace-enclosed initializer list>' to 'okapi::Motor'
118 |   posIntegrated(Motor imotor,
|                 ~~~~~~^~~~~~
./include/okapi/impl/control/async/asyncControllerFactory.hpp:129:3: note: candidate: 'static okapi::AsyncPosIntegratedController okapi::AsyncControllerFactory::posIntegrated(okapi::MotorGroup, int32_t, const okapi::TimeUtil&)'
129 |   posIntegrated(MotorGroup imotor,
|   ^~~~~~~~~~~~~
./include/okapi/impl/control/async/asyncControllerFactory.hpp:129:28: note:   no known conversion for argument 1 from '<brace-enclosed initializer list>' to 'okapi::MotorGroup'
129 |   posIntegrated(MotorGroup imotor,
|                 ~~~~~~~~~~~^~~~~~
In file included from src/function.cpp:3:
src/port-config.hpp:63:16: error: 'RIGHT_TRAY' was not declared in this scope
63 |              {-RIGHT_TRAY, LEFT_TRAY}
|                ^~~~~~~~~~
src/port-config.hpp:64:13: error: no matching function for call to 'okapi::AsyncControllerFactory::posIntegrated(<brace-enclosed initializer list>)'
64 |             );
|             ^
In file included from ./include/okapi/api.hpp:36,
from src/port-config.hpp:4,
from src/function.cpp:3:
./include/okapi/impl/control/async/asyncControllerFactory.hpp:118:3: note: candidate: 'static okapi::AsyncPosIntegratedController okapi::AsyncControllerFactory::posIntegrated(okapi::Motor, int32_t, const okapi::TimeUtil&)'
118 |   posIntegrated(Motor imotor,
|   ^~~~~~~~~~~~~
./include/okapi/impl/control/async/asyncControllerFactory.hpp:118:23: note:   no known conversion for argument 1 from '<brace-enclosed initializer list>' to 'okapi::Motor'
118 |   posIntegrated(Motor imotor,
|                 ~~~~~~^~~~~~
./include/okapi/impl/control/async/asyncControllerFactory.hpp:129:3: note: candidate: 'static okapi::AsyncPosIntegratedController okapi::AsyncControllerFactory::posIntegrated(okapi::MotorGroup, int32_t, const okapi::TimeUtil&)'
129 |   posIntegrated(MotorGroup imotor,
|   ^~~~~~~~~~~~~
./include/okapi/impl/control/async/asyncControllerFactory.hpp:129:28: note:   no known conversion for argument 1 from '<brace-enclosed initializer list>' to 'okapi::MotorGroup'
129 |   posIntegrated(MotorGroup imotor,
|                 ~~~~~~~~~~~^~~~~~
