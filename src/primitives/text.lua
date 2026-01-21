local Registry = require(script.Parent.Parent.core.registry)

local Text = {}
Text.__index = Text

function Text.new(registry, props)
    local obj = Drawing.new("Text")
    for k,v in pairs(props) do
        obj[k] = v
    end
    registry:Add(obj)
    return setmetatable({Obj = obj}, Text)
end

function Text:SetPosition(pos)
    self.Obj.Position = pos
end

function Text:SetText(text)
    self.Obj.Text = text
end

function Text:Destroy()
    pcall(function() self.Obj:Remove() end)
end

return Text
