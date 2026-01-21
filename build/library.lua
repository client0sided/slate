local Core = script.Parent:WaitForChild("core")
local Components = script.Parent:WaitForChild("components")

local a = require(Core.registry)
local b = require(Core.input)
local c = require(Core.loop)
local d = require(Core.theme)
local e = require(Components.window)


local f={}
f.__index=f

function f.new()
local g=setmetatable({},f)
g.Registry=a.new()
g.Input=b.new()
g.Theme=d.new()
g.Windows={}
g.Running=true

c.new(g)
return g
end

function f.CreateWindow(g,h,i)
local j=e.new(g,h,i)
table.insert(g.Windows,j)
return j
end

function f.Destroy(g)
g.Running=false
for h,i in ipairs(g.Windows)do
i:Destroy()
end
g.Registry:DestroyAll()
end

return f