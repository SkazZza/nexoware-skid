local hooks = {}

function hooks:new(CClosure)
    local HookTable = {
        tables = {},
        upvalues = {},
        hookfuncs = {}
    }

    self._hooks = HookTable
    self._setcclosure = CClosure and true or false

    return HookTable
end

function hooks:SetupHook(...)
    local Args = {...}
    local Exist = Args[1] ~= nil or false
    local Type = Exist and Args[1] or "Table"
    local One = Exist and Args[2] or Args[1]
    local Two = Exist and Args[3] or Args[2]
    local Func = Exist and Args[4] or Args[3]
    local OldFunc, SetClosure = nil, self._setcclosure

    if (Type == "Table") then
        OldFunc = One[Two]
        One[Two] = SetClosure and newcclosure(Func) or Func

        table.insert(self._hooks.tables, {
            Table = One,
            FuncName = Two,
            Func = OldFunc
        })

        return OldFunc
    elseif (Type == "Upvalue") then
        OldFunc = debug.getupvalue(One, Two)

        debug.setupvalue(One, Two, SetClosure and newcclosure(Func) or Func)

        table.insert(self._hooks.upvalues, {
            Func = One,
            Index = Two,
            OldFunc = OldFunc
        })
    elseif (Type == "HookFunc") then
        OldFunc = hookfunction(One[Two], Func)

        table.insert(self._hooks.hookfuncs, {
            Table = One,
            FuncName = Two,
            Func = OldFunc
        })

        return OldFunc
    end

    return OldFunc
end

function hooks:ResetHooks()
    for HookType, v in pairs(self._hooks) do
        for i, Table in pairs(v) do
            if (HookType == "tables") then
                Table.Table[Table.FuncName] = Table.Func
            elseif (HookType == "hookfuncs") then
                hookfunction(Table.Table[Table.FuncName], Table.Func)
            elseif (HookType == "upvalues") then
                debug.setupvalue(Table.Func, Table.Index, Table.OldFunc)
            end
        end
    end
end

return hooks
