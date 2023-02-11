# lua-which

[![test](https://github.com/mah0x211/lua-which/actions/workflows/test.yml/badge.svg)](https://github.com/mah0x211/lua-which/actions/workflows/test.yml)
[![codecov](https://codecov.io/gh/mah0x211/lua-which/branch/master/graph/badge.svg)](https://codecov.io/gh/mah0x211/lua-which)

locate a program file in the user's path.


## Installation

```
luarocks install which
```

## pathname, err = which( progname )

`which` function returns a pathname of specified progname.

**Parameters**

- `prgname:string`: program filename.

**Returns**

- `pathname:string`: pathname of progname.
- `err:string`: error messages on failure.

**Example**

```lua
local which = require('which')
print(which('ls')) -- '/bin/ls'
```

