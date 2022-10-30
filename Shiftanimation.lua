local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")
 
local contextActionService = game:GetService("ContextActionService")
 
local running = false
 
local runAnim = Instance.new("Animation")
runAnim.AnimationId = "rbxassetid://5832447211"
 
local loadedRun = humanoid:LoadAnimation(runAnim)
 
--//Functions
 
local function handler(actionName, inputState, inputObject)
  if actionName == "Run" then
    if inputState == Enum.UserInputState.Begin then
      humanoid.WalkSpeed = 26
      loadedRun:Play()
      running = true
    end
    if inputState == Enum.UserInputState.End then
      if loadedRun.IsPlaying then
        loadedRun:Stop()
      end
      humanoid.WalkSpeed = 16
      running = false
    end
  end
end
 
contextActionService:BindAction("Run", handler, false, Enum.KeyCode.LeftShift)
 
while wait() do
  if humanoid.MoveDirection.Magnitude <= 0 and running then
    if loadedRun.IsPlaying then
      loadedRun:Stop()
    end
    humanoid.WalkSpeed = 16
    running = false
  end
end
 
humanoid.Jumping:Connect(function(active)
    if active == false and running == true then
      loadedRun:Play()
    end
end)