local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local flying = false
local bodyPosition = nil
local bodyGyro = nil

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local flyButton = Instance.new("TextButton")
flyButton.Parent = screenGui
flyButton.Size = UDim2.new(0, 150, 0, 50)
flyButton.Position = UDim2.new(0.5, -75, 0.9, 0)
flyButton.Text = "ВКЛЮЧИТЬ ПОЛЁТ"
flyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
flyButton.TextColor3 = Color3.fromRGB(0, 0, 0)
flyButton.Font = Enum.Font.SourceSansBold
flyButton.TextSize = 18

local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local moveDirection = Vector3.new()
local speed = 60

local function updateFly()
    if not flying or not bodyPosition then return end
    
    moveDirection = Vector3.new()
    
    if userInputService:IsKeyDown(Enum.KeyCode.W) then
        moveDirection = moveDirection + Vector3.new(0, 0, -1)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.S) then
        moveDirection = moveDirection + Vector3.new(0, 0, 1)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.A) then
        moveDirection = moveDirection + Vector3.new(-1, 0, 0)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.D) then
        moveDirection = moveDirection + Vector3.new(1, 0, 0)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.Space) then
        moveDirection = moveDirection + Vector3.new(0, 1, 0)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        moveDirection = moveDirection + Vector3.new(0, -1, 0)
    end
    
    if moveDirection.Magnitude > 0 then
        moveDirection = moveDirection.Unit
    end
    
    local camera = workspace.CurrentCamera
    local moveVector = (camera.CFrame:VectorToWorldSpace(moveDirection)) * speed
    
    local newPos = character.HumanoidRootPart.Position + moveVector
    bodyPosition.Position = newPos
    bodyGyro.CFrame = camera.CFrame
end

local function startFly()
    if flying then return end
    flying = true
    
    local hrp = character:WaitForChild("HumanoidRootPart")
    
    bodyPosition = Instance.new("BodyPosition")
    bodyPosition.MaxForce = Vector3.new(400000, 400000, 400000)
    bodyPosition.D = 5000
    bodyPosition.P = 20000
    bodyPosition.Position = hrp.Position
    bodyPosition.Parent = hrp
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
    bodyGyro.D = 500
    bodyGyro.P = 20000
    bodyGyro.CFrame = hrp.CFrame
    bodyGyro.Parent = hrp
    
    humanoid.PlatformStand = true
    
    flyButton.Text = "ВЫКЛЮЧИТЬ ПОЛЁТ"
    flyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    
    runService.RenderStepped:Connect(updateFly)
end

local function stopFly()
    if not flying then return end
    flying = false
    
    if bodyPosition then
        bodyPosition:Destroy()
        bodyPosition = nil
    end
    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end
    
    humanoid.PlatformStand = false
    
    flyButton.Text = "ВКЛЮЧИТЬ ПОЛЁТ"
    flyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
end

flyButton.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
    else
        startFly()
    end
end)
