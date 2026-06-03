-- flyui.lua
-- Version: 1.1
 
-- Instances:
 
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")
local UIGradient = Instance.new("UIGradient")
local TextButton = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local TextLabel_2 = Instance.new("TextLabel")
 
--Properties:
 
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
 
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(56, 56, 56)
Frame.Position = UDim2.new(0.285924822, 0, 0.330864191, 0)
Frame.Size = UDim2.new(0, 339, 0, 187)
 
UICorner.Parent = Frame
 
TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(125, 138, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(-0.00231036008, 0, -0.000686563901, 0)
TextLabel.Size = UDim2.new(0, 340, 0, 55)
TextLabel.Font = Enum.Font.Gotham
TextLabel.Text = "flyui.lua"
TextLabel.TextColor3 = Color3.fromRGB(225, 225, 225)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true
 
UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(98, 98, 98)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(191, 191, 191))}
UIGradient.Parent = TextLabel
 
TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
TextButton.Position = UDim2.new(0.204028934, 0, 0.531649828, 0)
TextButton.Size = UDim2.new(0, 200, 0, 50)
TextButton.Font = Enum.Font.Gotham
TextButton.Text = "Fly"
TextButton.TextColor3 = Color3.fromRGB(199, 199, 199)
TextButton.TextScaled = true
TextButton.TextSize = 14.000
TextButton.TextWrapped = true
 
UICorner_2.Parent = TextButton
TextButton.MouseButton1Down:connect(function()
    local function NQWSTGE_fake_script() -- Frame.Fly 
        local script = Instance.new('LocalScript', Frame)
 
        local plr = script.Parent.Parent.Parent.Parent
        repeat wait() until plr and plr.Character and plr.Character:findFirstChild("HumanoidRootPart") and plr.Character:findFirstChild("Humanoid") 
        local mouse = game.Players.LocalPlayer:GetMouse()  
        repeat wait() until mouse
 
        local torso = plr.Character.HumanoidRootPart 
        local flying = false
        local deb = true 
        local ctrl = {f = 0, b = 0, l = 0, r = 0} 
        local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
        local maxspeed = 1000 
        local speed = 50
        function Fly() 
            local bg = Instance.new("BodyGyro", torso) 
            bg.P = 9e4 
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
            bg.cframe = torso.CFrame 
            local bv = Instance.new("BodyVelocity", torso) 
            bv.velocity = Vector3.new(0,0.1,0) 
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 
            repeat wait() 
                plr.Character.Humanoid.PlatformStand = true 
                if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then 
                    speed = speed+.5+(speed/maxspeed) 
                    if speed > maxspeed then 
                        speed = maxspeed 
                    end 
                elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then 
                    speed = speed-1 
                    if speed < 0 then 
                        speed = 0
                    else
                        speed = 50
                    end 
                end 
                if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then 
                    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
                    lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 
                elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then 
                    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
                else 
                    bv.velocity = Vector3.new(0,0.1,0) 
                end 
                bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
            until not flying 
            ctrl = {f = 0, b = 0, l = 0, r = 0} 
            lastctrl = {f = 0, b = 0, l = 0, r = 0} 
 
            bg:Destroy() 
            bv:Destroy() 
            plr.Character.Humanoid.PlatformStand = false 
            speed = 50
        end 
 
        mouse.KeyDown:connect(function(key) 
            if key:lower() == "e" then 
                if flying then flying = false 
 speed = 50
                else 
 flying = true 
 Fly()
 
                end 
            elseif key:lower() == "w" then 
 ctrl.f = 1 
            elseif key:lower() == "s" then 
 ctrl.b = -1 
            elseif key:lower() == "a" then 
 ctrl.l = -1 
            elseif key:lower() == "d" then 
 ctrl.r = 1 
            end 
        end) 
 mouse.KeyUp:connect(function(key) 
            if key:lower() == "w" then 
 ctrl.f = 0 
            elseif key:lower() == "s" then 
 ctrl.b = 0 
            elseif key:lower() == "a" then 
 ctrl.l = 0 
            elseif key:lower() == "d" then 
 ctrl.r = 0 
            end 
        end)
 
 plr.Character.Humanoid.StateChanged:Connect(function(o,n)
            if n == Enum.HumanoidStateType.Running then
                ctrl.f = 1
            else
 ctrl.f = 0
            end
 
        end)
 script.Parent.TextButton.MouseButton1Click:Connect(function()
            if flying then
 flying = false
 speed = 50
            else
 flying = true
 Fly()
            end
        end)
 
    end
    coroutine.wrap(NQWSTGE_fake_script)()
    local function RAQA_fake_script() -- Frame.Buttons 
        local script = Instance.new('LocalScript', Frame)
 
        local Trigger = script.Parent.MiniTrext
        local IsMini = false
        function CreateTween(Instance,Style,Direction,Time,table,RepeatCount,CanRepeat,Delay)
            local ts = game:GetService("TweenService")
            local TweenInfo = TweenInfo.new(Time,Style,Direction,RepeatCount,CanRepeat,Delay)
            local Tween = ts:Create(Instance,TweenInfo,table)
            repeat wait() until Tween ~= nil
            return Tween
 
        end
 Trigger.MouseButton1Click:Connect(function()
            if IsMini then
 CreateTween(script.Parent,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0.5,{Size = UDim2.new(0.265, 0,0.1, 0)},0,false,0.1):Play()
 IsMini = false
 Trigger.Text = "-"
            else
 CreateTween(script.Parent,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0.5,{Size = UDim2.new(0.265, 0,0.042, 0)},0,false,0.1):Play()
 IsMini = true
 Trigger.Text = "+"
            end
        end)
 script.Parent.Delete.MouseButton1Click:Connect(function()
 script.Parent.Parent:Destroy()
        end)
    end
    coroutine.wrap(RAQA_fake_script)()
    local function TKVUMP_fake_script() -- Frame.Drag Gui 
        local script = Instance.new('LocalScript', Frame)
 
        local UserInputService = game:GetService("UserInputService")
 
        local gui = script.Parent
 
        local dragging
        local dragInput
        local dragStart
        local startPos
 
        local function update(input)
            local delta = input.Position - dragStart
 gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
 
 gui.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
 dragging = true
 dragStart = input.Position
 startPos = gui.Position
 
 input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
 dragging = false
                    end
                end)
            end
        end)
 
 gui.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
 dragInput = input
            end
        end)
 
 UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
 update(input)
            end
        end)
    end
    coroutine.wrap(TKVUMP_fake_script)()
end)
 
TextLabel_2.Parent = Frame
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.Position = UDim2.new(0.049923569, 0, 0.908490181, 0)
TextLabel_2.Size = UDim2.new(0, 45, 0, 17)
TextLabel_2.Font = Enum.Font.SourceSans
TextLabel_2.Text = "Made By Arroz"
TextLabel_2.TextColor3 = Color3.fromRGB(213, 213, 213)
TextLabel_2.TextSize = 14.000
 
-- Scripts:
 
local function MVOIGTP_fake_script() -- Frame.DragScript 
    local script = Instance.new('LocalScript', Frame)
 
    --Not made by me, check out this video: https://www.youtube.com/watch?v=z25nyNBG7Js&t=22s
    --Put this inside of your Frame and configure the speed if you would like.
    --Enjoy! Credits go to: https://www.youtube.com/watch?v=z25nyNBG7Js&t=22s
    
    local UIS = game:GetService('UserInputService')
    local frame = script.Parent
    local dragToggle = nil
    local dragSpeed = 0.25
    local dragStart = nil
    local startPos = nil
    
    local function updateInput(input)
        local delta = input.Position - dragStart
        local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
 startPos.Y.Scale, startPos.Y.Offset + delta.Y)
 game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
    end
    
 frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
 dragToggle = true
 dragStart = input.Position
 startPos = frame.Position
 input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
 dragToggle = false
                end
            end)
        end
    end)
    
 UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragToggle then
 updateInput(input)
            end
        end
    end)
    
end
coroutine.wrap(MVOIGTP_fake_script)()
