-- // THANK YOU QUIVING!!! \\ --

local Prefix = ""
local multSeperator = "||"

local Commands = {}

local function isInTable(str, tbl)
    for _,v in pairs(tbl) do
        if v == str then
            return true
        end
    end
    return false
end

local function splitByArgs(str, s, args)
    if (args == 0) then
        return {str}
    end
    
    local b = string.split(str, s)
    local tbl = {b[1]}
    for i = 1, args do
        if (i ~= 1) then
            table.insert(tbl, b[i])
        end
    end
    table.remove(b, 1)
    table.insert(tbl, table.concat(b, s, args, #b))
    return tbl
end

local function processCommand(str)
    local multiples = string.find(str, multSeperator) and string.split(str, multSeperator) or {str}
    for _,Str in pairs(multiples) do
        local split_commands = string.split(Str, " ")
        local command = string.sub(split_commands[1], #Prefix + 1, #split_commands[1])
        if (Commands[command]) then
            local info = Commands[command].Info
            local splitStr = splitByArgs(Str, " ", info.Args)
            if string.sub(splitStr[1],1,#Prefix) == Prefix then
                if string.lower(splitStr[1]) == Prefix .. info.Name or isInTable(string.lower(command), info.Aliases) then
                    if (info.Args == 0) then
                        info.Function()
                    else
                        table.remove(splitStr, 1)
                        info.Function(table.unpack(splitStr))
                    end
                end
            end
        end
    end
end

local function addCommand(info)
    if Commands[info.Name] then
        return
    end

    info.Args = info.Args or 0
    info.Aliases = info.Aliases or {}

    Commands[info.Name] = {
        Info = info
    }

    if #info.Aliases > 0 then
        for _,alias in next, info.Aliases do
            if not Commands[alias] then
                Commands[alias] = {
                    Info = info
                }
            end
        end
    end
end

--[[
usage:

addCommand({
    Name = "fuck",
    Aliases = {"fuck1", "fuck2"} -- if wanted, you don't need to type out 
    Args = 3,                       Aliases and Args if theyre going to be empty/0. It will autofill for you.
    Function = function(arg1, arg2, arg3)
    end
})
]]
