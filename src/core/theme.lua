local Theme = {}
Theme.__index = Theme

function Theme.new()
    return setmetatable({
        Background = Color3.fromRGB(20, 20, 20),
        Topbar = Color3.fromRGB(28, 28, 28),
        Text = Color3.fromRGB(235, 235, 235),
        SubText = Color3.fromRGB(160, 160, 160),
        Close = Color3.fromRGB(200, 60, 60)
    }, Theme)
end

return Theme
