-- hack vault for brainrots

return function(section)
    local elements = loadstring(game:HttpGet(getgitpath("src").."elements.lua"))()
    local utils = loadstring(game:HttpGet(getgitpath("src").."utils.lua"))()

    local plr = game:GetService("Players").LocalPlayer
    getgenv().FarmRots = false

    local function teleportTo(position)
        local root = utils.GetRoot(plr)
        if not root then
            return false
        end

        root.CFrame = CFrame.new(position)
        return true
    end

    elements:Toggle("Farm Brainrots", section, function(v)
        utils.StartToggleLoop("FarmRots", v, function()
            local entities = workspace:FindFirstChild("EntitiesFolder")
            if not entities then return end

            teleportTo(Vector3.new(-2494, 4, -726))
            task.wait(0.25)

            for _, br in pairs(entities:GetChildren()) do
                local spawnZone = br:GetAttribute("SpawnZone")

                if tostring(spawnZone) == "22" then
                    local prompt = (
                        br:FindFirstChild("TakeBrainrotPrompt", true)
                        or utils.FindFirstDescendantOfClass(br, "ProximityPrompt")
                    )

                    if prompt then
                        local targetPart = br.PrimaryPart or prompt.Parent
                        if targetPart and targetPart:IsA("BasePart") then
                            teleportTo(targetPart.Position)
                            task.wait(0.2)
                        end

                        repeat
                            utils.FirePrompt(prompt)
                            task.wait()
                        until not getgenv().FarmRots or not br.Parent or br:FindFirstChild("Attachment", true)
                        teleportTo(Vector3.new(77, 4, -729))
                        task.wait(1)
                    end
                end
            end
        end, 0.05)
    end)
end
