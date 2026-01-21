local Registry = require(script.core.registry)
local Input = require(script.core.input)
local Loop = require(script.core.loop)
local Theme = require(script.core.theme)
local Window = require(script.components.window)

local Library = {}
Library.__index = Library

function Library.new()
    local self = setmetatable({}, Library)
    self.Registry = Registry.new()
    self.Input = Input.new()
    self.Theme = Theme.new()
    self.Windows = {}
    self.Running = true

    Loop.new(self)
    return self
end

function Library:CreateWindow(title, desc)
    local window = Window.new(self, title, desc)
    table.insert(self.Windows, window)
    return window
end

function Library:Destroy()
    self.Running = false
    for _, window in ipairs(self.Windows) do
        window:Destroy()
    end
    self.Registry:DestroyAll()
end

return Library
