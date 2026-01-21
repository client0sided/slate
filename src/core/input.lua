local UIS = game:GetService("UserInputService")

local Input = {}
Input.__index = Input

function Input.new()
    local self = setmetatable({
        Mouse = Vector2.new(0, 0),
        LeftDown = false
    }, Input)

    UIS.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            self.LeftDown = true
        end
    end)

    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            self.LeftDown = false
        end
    end)

    return self
end

function Input:Update()
    self.Mouse = UIS:GetMouseLocation()
end

return Input
