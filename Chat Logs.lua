rconsoletitle("Bender - Chat Logs")

for _,v in pairs(game.Players:GetChildren()) do
    v.Chatted:Connect(function(msg)
         rconsoleprint(v.Name .. ": " .. msg .. "\n")
    end)
end

game.Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(msg2)
        rconsoleprint(player.Name .. ": " .. msg2 .. "\n")
    end)
end)
