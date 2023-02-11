require('luacov')
local testcase = require('testcase')
local which = require('which')

function testcase.which()
    -- test that return the filepath if command is found
    local pathname, err = which('ls')
    assert.match(pathname, '^[%w/]+/ls$', false)
    assert.is_nil(err)

    -- test that return nil if command is not found
    pathname, err = which('unknown_command')
    assert.is_nil(pathname)
    assert.is_nil(err)

    -- test that throws an error if progname argument is invalid
    err = assert.throws(which, 'ls ls')
    assert.match(err, 'progname must be string matching the pattern')
    err = assert.throws(which, {})
    assert.match(err, 'progname must be string matching the pattern')
end
