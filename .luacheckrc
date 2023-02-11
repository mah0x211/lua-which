std = 'max'
include_files = {
    'which.lua',
    'test/*_test.lua',
}
ignore = {
    'assert',
    -- unused argument
    '212',
    -- line is too long.
    '631',
}
