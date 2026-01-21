local Registry = require(script.Parent.Parent.core.registry)

local Square = {}
Square.__index = Square

function Square.new(registry, props)
    local obj = Drawing.new("Square")
    for k,v in pairs(props) do
        obj[k] = v
    end
    registry:Add(obj)
    return setmetatable({Obj = obj}, Square)
end

function Square:SetPosition(pos)
    self.Obj.Position = pos
end

function Square:SetSize(size)
    self.Obj.Size = size
end

function Square:Destroy()
    pcall(function() self.Obj:Remove() end)
end

return Square
