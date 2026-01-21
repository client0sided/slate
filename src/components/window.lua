local Square = require(script.Parent.primitives.square)
local Text = require(script.Parent.primitives.text)

local Window = {}
Window.__index = Window

function Window.new(library, title, desc)
    local self = setmetatable({
        Library = library,
        Theme = library.Theme,
        Input = library.Input,
        Registry = library.Registry,
        Pos = Vector2.new(400, 300),
        Size = Vector2.new(360, 180),
        Dragging = false,
        DragOffset = Vector2.new(0, 0),
        Alive = true
    }, Window)

    self.Background = Square.new(self.Registry, {
        Size = self.Size,
        Position = self.Pos,
        Color = self.Theme.Background,
        Filled = true,
        ZIndex = 1
    })

    self.Topbar = Square.new(self.Registry, {
        Size = Vector2.new(self.Size.X, 36),
        Position = self.Pos,
        Color = self.Theme.Topbar,
        Filled = true,
        ZIndex = 2
    })

    self.Title = Text.new(self.Registry, {
        Text = title,
        Size = 14,
        Position = self.Pos + Vector2.new(12, 8),
        Color = self.Theme.Text,
        ZIndex = 3
    })

    self.Desc = Text.new(self.Registry, {
        Text = desc,
        Size = 13,
        Position = self.Pos + Vector2.new(12, 52),
        Color = self.Theme.SubText,
        ZIndex = 3
    })

    self.Close = Text.new(self.Registry, {
        Text = "✕",
        Size = 14,
        Position = self.Pos + Vector2.new(self.Size.X - 26, 10),
        Color = self.Theme.Close,
        ZIndex = 4
    })

    return self
end

function Window:Update()
    if not self.Alive then return end

    local mouse = self.Input.Mouse
    local down = self.Input.LeftDown

    local topbar = {
        x1 = self.Pos.X,
        y1 = self.Pos.Y,
        x2 = self.Pos.X + self.Size.X,
        y2 = self.Pos.Y + 36
    }

    local closeBox = {
        x1 = self.Close.Obj.Position.X,
        y1 = self.Close.Obj.Position.Y,
        x2 = self.Close.Obj.Position.X + 14,
        y2 = self.Close.Obj.Position.Y + 14
    }

    if down and mouse.X >= topbar.x1 and mouse.X <= topbar.x2 and mouse.Y >= topbar.y1 and mouse.Y <= topbar.y2 then
        if not self.Dragging then
            self.Dragging = true
            self.DragOffset = mouse - self.Pos
        end
    elseif not down then
        self.Dragging = false
    end

    if self.Dragging then
        self.Pos = mouse - self.DragOffset
        self.Background:SetPosition(self.Pos)
        self.Topbar:SetPosition(self.Pos)
        self.Title:SetPosition(self.Pos + Vector2.new(12, 8))
        self.Desc:SetPosition(self.Pos + Vector2.new(12, 52))
        self.Close:SetPosition(self.Pos + Vector2.new(self.Size.X - 26, 10))
    end

    if down and mouse.X >= closeBox.x1 and mouse.X <= closeBox.x2 and mouse.Y >= closeBox.y1 and mouse.Y <= closeBox.y2 then
        self:Destroy()
    end
end

function Window:Destroy()
    if not self.Alive then return end
    self.Alive = false
    self.Background:Destroy()
    self.Topbar:Destroy()
    self.Title:Destroy()
    self.Desc:Destroy()
    self.Close:Destroy()
end

return Window
