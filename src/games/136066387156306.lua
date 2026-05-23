-- Be Flash for Brainrots

return function(section)
    local elements = loadstring(game:HttpGet(getgitpath("src").."elements.lua"))()

    local repstorage = game:GetService("ReplicatedStorage")
    local eventsFold = repstorage.Events
    local dashev = repstorage.DashEvent
    local traintreadev = eventsFold.TrainTreadmillEvent

    local speedWalls = workspace.Gameplay.SpeedWalls
    
    local plr = game:GetService("Players").LocalPlayer
    local stamamt = plr.StaminaLevel

    getgenv().FarmBrainrots = false

    elements:Toggle("Farm Brainrots", section, function(bool)
        if bool then
            getgenv().FarmBrainrots = true

            while getgenv().FarmBrainrots do
                dashev:FireServer("StartCharge")
                task.wait()
                dashev:FireServer(3)
                task.wait()
                
                local bestArea = speedWalls.SpeedWall_1
                for _, v in pairs(speedWalls:GetChildren()) do
                    if v == bestArea then continue end
                    if v:GetAttribute("ReqSpeed") > bestArea:GetAttribute("ReqSpeed") and stamamt.Value >= v:GetAttribute("ReqSpeed") then
                        bestArea = v
                    end
                end

                local char = plr.Character
                char:MoveTo(bestArea.Position)
                task.wait(0.1)
                dashev:FireServer("EndWarp")

                task.wait(0.1)
            end
        else
            getgenv().FarmBrainrots = false
        end
    end)
end
