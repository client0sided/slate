local Registry = {}
Registry.__index = Registry

function Registry.new()
    return setmetatable({Objects = {}}, Registry)
end

function Registry:Add(obj)
    table.insert(self.Objects, obj)
end

function Registry:DestroyAll()
    for _, obj in ipairs(self.Objects) do
        pcall(function() obj:Remove() end)
    end
    table.clear(self.Objects)
end

return Registry
