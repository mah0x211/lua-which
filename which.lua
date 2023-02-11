--
-- Copyright (C) 2023 Masatoshi Fukunaga
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--
local concat = table.concat
local ipairs = ipairs
local format = string.format
local match = string.match
local type = type
local popen = io.popen

local COMMANDS = {
    'type -p %q 2>&1',
    'which %q 2>&1',
}

--- which
--- @param progname string
--- @return string? pathname
--- @return any err
local function which(progname)
    if type(progname) ~= 'string' or not match(progname, '^[%w_][%w_-]*$') then
        error('progname must be string matching the pattern "^[%w_][%w_-]*$" ',
              2)
    end

    local errs
    for _, cmd in ipairs(COMMANDS) do
        local f = popen(format(cmd, progname))
        if f then
            local res = f:read('*a')
            f:close()
            if #res > 0 then
                local pathname = match(res, '^%s*([^%s]+)%s*$')
                if pathname then
                    return pathname
                elseif not errs then
                    errs = {}
                end
                errs[#errs + 1] = match(res, '^(.+)%s+$')
            end
        end
    end

    if errs and #errs == #COMMANDS then
        return nil, concat(errs, ', ')
    end
end

return which
