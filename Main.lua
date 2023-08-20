   --[[

   ____                       _                       
   | __ )    ___   _ __     __| |   ___   _ __   
   |  _ \   / _ \ | '_ \   / _` |  / _ \ | '__|                                              
   | |_) | |  __/ | | | | | (_| | |  __/ | |             
   |____/   \___| |_| |_|  \__,_|  \___| |_|   

                        `. ___
                     __,' __`.                _..----....____
         __...--.'``;.   ,.   ;``--..__     .'    ,-._    _.-'
   _..-''-------'   `'   `'   `'     O ``-''._   (,;') _,'
   ,'________________                          \`-._`-','
   `._              ```````````------...___   '-.._'-:
      ```--.._      ,.                     ````--...__\-.
               `.--. `-`                       ____    |  |`
               `. `.                       ,'`````.  ;  ;`
                  `._`.        __________   `.      \'__/`
                     `-:._____/______/___/____`.     \  `
                                 |       `._    `.    \
                                 `._________`-.   `.   `.___
                                                SSt  `------'`




   --]]

   -- // Setup \\ --
      
      repeat task.wait() until game:IsLoaded()
      
         -----------------------------------------------------------------------------------------------------------------------------------------------------
      
         -- For PERSONAL use, NOT code use (touch this! ✅)
         getgenv().Whitelisted = {} getgenv().Pref = "!" getgenv().ChatlogsSpamText = "ff" getgenv().ChatSpamText = "Text" getgenv().AntiCrash = false;
      
         -- For CODE use, NOT PERSONAL use (DON'T touch this! ❌)
         getgenv().WhitelistCount = {} getgenv().Connections = {}  getgenv().WhitelistConnection = {} getgenv().LockedSound = false getgenv().softLagging = false getgenv().Search = {} getgenv().Chaos = false

         -----------------------------------------------------------------------------------------------------------------------------------------------------
      
         local isKohls, NBCKohlsID, BCKohlsID, placeID, jobID, User, Display, LP, UserInputService, Character, UserInputService, HttpService, openedChatLogs = false, 112420803, 115670532, game.PlaceId, game.JobId, game.Players.LocalPlayer.Name, game.Players.LocalPlayer.DisplayName, game.Players.LocalPlayer, game:GetService("UserInputService"), game.Players.LocalPlayer.Character, game:GetService("UserInputService"), game:GetService("HttpService"), false game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(game.Players.LocalPlayer.Name .. "'s admin")
      
         -- Game Check
         if (game.PlaceId == NBCKohlsID) or (game.PlaceId == BCKohlsID) then
            isKohls = true
      
            -- Importing Scripts
            
            loadstring(game:HttpGet("https://raw.githubusercontent.com/traveIing/bender/main/Progress%20Bar.lua"))()
            task.wait(0.5)
            setProgress(14, "Loading Command Bar...");
            loadstring(game:HttpGet("https://raw.githubusercontent.com/traveIing/bender/main/Command%20Bar.lua"))()
            setProgress(28, "Loading Notification System...");
            loadstring(game:HttpGet("https://raw.githubusercontent.com/traveIing/bender/main/Notification.lua"))()
            setProgress(42, "Loading Additional Functions..")
            loadstring(game:HttpGet("https://raw.githubusercontent.com/traveIing/bender/main/Functions.lua"))()
            setProgress(56, "Loading Profile GUI...")
            loadstring(game:HttpGet("https://raw.githubusercontent.com/traveIing/bender/main/Profile%20GUI.lua"))()
            setProgress(70, "Loading Countdown GUI...")
            loadstring(game:HttpGet("https://raw.githubusercontent.com/traveIing/bender/main/Countdown.lua"))()
            setProgress(84, "Loading MapColor API...")
            loadstring(game:HttpGet("https://raw.githubusercontent.com/traveIing/bender/main/Map%20Changer.lua"))()
            setProgress(85, "Loading Playerlist..");
            task.spawn(function()
            game.StarterGui:SetCoreGuiEnabled("PlayerList",  false)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/traveIing/bender/main/PlayerList.lua"))()
            end)
            setProgress(100, "Complete! ☑️");
      
      
            -- Crash Check
            task.spawn(function()
               if (CheckIfCrashed() == true) then
                  warn("SHECFS")
                  notify("Bender", "Moving you to another server..", 1)
                  task.wait(0.25)
                  ServerHop()
                  return
               else
                  warn("SHECPS")
               end
            end)
            -- Execution Check
            if not hasExecuted then
               warn("DBEXPS")
               getgenv().hasExecuted = true
            else
               warn("DBEXFS")
               chatNotify("It seems that you may have executed twice; please note that this will cause instability issues. If you did not mean to do so, please say 'rejoin'.", 1, 0, 0)
               print("As you have executed twice, some aspects of this script may be bugged out. Please say 'rejoin' to resolve this.")
               isKohls = false;
            end
      
            -- Greeting User
            if isfile("Bender/Status.txt") then
               playAudio("Intro")
               notify("Bender", "Welcome back, " .. Display .. "!", 2)
            else
               playAudio("Intro")
               notify("Bender", "Hello, " .. Display .. "! Thank you for using Bender V1.3!", 3)
            end
            -- Kicks if User Isn't In Correct Game
         else
            LP:Kick("Sorry, this script is not compatible with this game.")
         end
      
         -- // Startup \\ --
      
         if isKohls == true then
      
            -- New Player Checker --
      
            if not isfile("Bender/Status.txt") then
      
               function Callback(text)
                  if text == "Yes" then
                     notify("Bender", "Press 'F9', or type '/console' to view a list of commands.", 3)
                     print("Docs: https://github.com/traveIing/bender/blob/main/Documentation.md")
                     print("Discord: https://discord.gg/UCvJatDRfp")
                  end
               end
      
               local Bind = Instance.new("BindableFunction")
               Bind.OnInvoke = Callback
      
               game.StarterGui:SetCore(
               "SendNotification",
               {
                  Title = "Bender",
                  Text = "Hello, ".. Display .."! It looks like you're new, would you like a list of commands?",
                  Button1 = "Yes",
                  Button2 = "No",
                  Duration = 50,
                  Callback = Bind
               }
               )
            end
         end
      
         -- Beta User Checker
      
         local function isOnBeta()
            local success, contents = pcall(function()
            return readfile("Bender/Configs/DeveloperBeta.txt")
            end)
            return success and contents == "true"
         end
      
         local success, error = pcall(function()
         local isBeta = isOnBeta()
         if isBeta then
            warn("DVBTPS")
            BetaEnabled = true;
            promptBetaInfo()
         else
            BetaEnabled = false;
            warn("DVBTFS")
         end
         end)
      
         if not success then
            warn("Error occurred:", error)
         end
         ------------------------------------------
         Connections[#Connections + 1] = LP.Chatted:Connect(function(msg)
      
         -- // Split & Rest Variables \\ --
      
         local split = string.split(msg, " ")
         local rest = table.concat(string.split(msg, " "), " ", 1)
         local rest2 = table.concat(split, " ", 3, #split)
      
         -- // Custom Cmds \\ --
      
         -- Teleporting Shortcuts --
         if string.sub(msg:lower(), 0, 5) == "bring" then
            local Request = string.sub(msg:lower(), 7)
      
            if (Request == "all" or Request == "everyone") then
               game.Players:Chat(":tp all me")
            elseif (Request == "others") then
               game.Players:Chat(":tp others me")
      
            elseif (Request == "friends") then
               game.Players:Chat(":tp friends me")
      
            elseif (Request == "noadmins") then
               for _,v in pairs(game.Players:GetChildren()) do
                  local HasAdminPad = game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(v.Name .. "'s admin")
                  local HasPerm = CheckForPerm(v.Name)
                  if (not HasAdminPad) then
                     if HasPerm == false then
                        game.Players:Chat(":tp " .. v.Name .. " me")
                     elseif (HasAdminPad) and (not HasPerm) then
                        --
                     end
                  elseif (HasAdminPad) and (not HasPerm) then
                     --
                  end
               end
      
            elseif (Request == "admins") then
               game.Players:Chat(":tp admins me")
      
            elseif GetMatchingPlayerName(Request) then
               local Player = GetMatchingPlayerName(Request)
               game.Players:Chat(":tp " .. Player .. " me")
            else
               return
            end
         end
         if string.sub(msg:lower(), 0, 2) == "to" then
            local Player = string.sub(msg, 4)
            for _, v in pairs(game.Players:GetPlayers()) do
               if v.Name == GetMatchingPlayerName(Player) then
                  LP.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                  break
               end
            end
         end
         -- Protection Shortcuts --
         if string.sub(msg:lower(), 0, #msg) == "shields" then
            game.Players:Chat(":god all")
            game.Players:Chat(":ff all")
         end
         if string.sub(msg:lower(), 0, #msg) == "rshields" then
            game.Players:Chat(":unff all")
            game.Players:Chat(":ungod all")
         end
         -- User Shortcuts --
         if string.sub(msg:lower(), 0, 3) == "ref" then
            local Player = string.sub(msg, 5)
            if Player == "all" then
               game.Players:Chat(":refresh all")
            elseif GetMatchingPlayerName(Player) then
               game.Players:Chat(":refresh " .. GetMatchingPlayerName(Player))
            else
               game.Players:Chat(":refresh " .. User)
            end
         end
      
         -- // Gears \\ --
      
         if string.sub(msg:lower(), 0, 6) == "carpet" then
            local Player = string.sub(msg, 8)
            handleGearAssignment("225921000", Player)
         end
         if string.sub(msg:lower(), 0, 5) == "laser" then
            local Player = string.sub(msg, 7)
            handleGearAssignment("130113146", Player)
         end
         if string.sub(msg:lower(), 0, 3) == "bat" then
            local Player = string.sub(msg, 5)
            handleGearAssignment("55301897", Player)
         end
         if string.sub(msg:lower(), 0, 5) == "money" then
            local Player = string.sub(msg, 7)
            handleGearAssignment("16722267", Player)
         end
         if string.sub(msg:lower(), 0, 8) == "ironfist" then
            local Player = string.sub(msg, 10)
            handleGearAssignment("243790334", Player)
         end
         if string.sub(msg:lower(), 0, 3) == "gun" then
            local Player = string.sub(msg, 5)
            handleGearAssignment("97885508", Player)
         end
         if string.sub(msg:lower(), 0, 7) == "pbucket" then
            local Player = string.sub(msg, 9)
            handleGearAssignment("18474459", Player)
         end
         if string.sub(msg:lower(), 0, 6) == "potato" then
            local Player = string.sub(msg, 8)
            handleGearAssignment("25741198", Player)
         end
         if string.sub(msg:lower(), 0, 2) == "vg" then
            local Player = string.sub(msg, 4)
            handleGearAssignment("94794847", Player)
         end
         if string.sub(msg:lower(), 0, 5) == "taser" then
            local Player = string.sub(msg, 7)
            handleGearAssignment("82357123", Player)
         end
         if string.sub(msg:lower(), 0, 5) == "plane" then
            local Player = string.sub(msg, 7)
            handleGearAssignment("163348575", Player)
         end
         if string.sub(msg:lower(), 0, 5) == "ivory" then
            local Player = string.sub(msg, 7)
            handleGearAssignment("108158379", Player)
         end
         if string.sub(msg:lower(), 0, 7) == "velokit" then
            local Player = string.sub(msg, 9)
            if GetMatchingPlayerName(Player) then
               game.Players:Chat(":gear " .. GetMatchingPlayerName(Player) .. " 119917513")
               game.Players:Chat(":gear " .. GetMatchingPlayerName(Player) .. " 74385399")
               game.Players:Chat(":gear " .. GetMatchingPlayerName(Player) .. " 287426148")
            else
               game.Players:Chat(":gear " .. User .. " 119917513")
               game.Players:Chat(":gear " .. User .. " 74385399")
               game.Players:Chat(":gear " .. User .. " 287426148")
            end
         end
      
         -- // Map Modifications \\ --
      
         -- Music Themes --
         if string.sub(msg:lower(), 0, #msg) == "rock" then
            game.Players:Chat(":fogend 1000")
            game.Players:Chat(":fogcolor 500 0 0")
            game.Players:Chat(":time 1")
            game.Players:Chat(":gear all 99119198")
            game.Players:Chat(":music 1843497734")
         end
         -- Color Themes --
         if string.sub(msg:lower(), 0, #msg) == "blackout" then
            ChangeMapColor("Really black")
            task.wait(0.25)
            game.Players:Chat(":colorshifttop 600 400 0")
            game.Players:Chat(":fogcolor 0 0 0")
            game.Players:Chat(":fogend 20")
            game.Players:Chat(":time 0")
         end
         if string.sub(msg:lower(), 0, #msg) == "pink" then
            game.Players:Chat(":fogcolor 250 0 500")
            game.Players:Chat(":fogend 1000")
            game.Players:Chat(":time 1")
         end
         if string.sub(msg:lower(), 0, #msg) == "blue" then
            game.Players:Chat(":fogcolor 0 0 500")
            game.Players:Chat(":fogend 1000")
            game.Players:Chat(":time 1")
         end
         if string.sub(msg:lower(), 0, #msg) == "red" then
            game.Players:Chat(":fogcolor 500 0 0")
            game.Players:Chat(":fogend 1000")
            game.Players:Chat(":time 1")
         end
         if string.sub(msg:lower(), 0, #msg) == "purple" then
            ChangeMapColor("Mulberry")
            task.wait(0.5)
            game.Players:Chat(":fogcolor 160 32 240")
            game.Players:Chat(":fogend 1000")
            game.Players:Chat(":time 1")
         end
         if string.sub(msg:lower(), 0, #msg) == "green" then
            game.Players:Chat(":fogcolor 0 500 0")
            game.Players:Chat(":fogend 1000")
            game.Players:Chat(":time 1")
         end
         if string.sub(msg:lower(), 0, #msg) == "white" then
            ChangeMapColor("Really white")
            task.wait(0.5)
            game.Players:Chat(":fogend 10000")
            notify("Bender", "☑️", 1)
         end
         -- Heaven / Hell --
         if string.sub(msg:lower(), 0, #msg) == "heaven" then
            game.Players:Chat(":fogend 50")
            game.Players:Chat(":time 1")
            game.Players:Chat(":paint all white")
         end
         if string.sub(msg:lower(), 0, #msg) == "hell" then
            game.Players:Chat(":fogend 500")
            game.Players:Chat(":time 1")
            game.Players:Chat(":fogcolor 500 0 0")
            game.Players:Chat(":gear all 31314931")
            game.Players:Chat(":paint all red")
         end
         -- Friend Inspired Themes
      
         if string.sub(msg:lower(), 0, #msg) == "watermelon" then -- ADRIAN 🍉
            -- Map Effects
            ChangeMapColor("Lime green")
            game.Players:Chat(":time 1")
            game.Players:Chat(":fogend 100")
            game.Players:Chat(":fogcolor 0 500 0")
            game.Players:Chat(":music 1841647093")
            task.wait(0.25)
            -- Avatar Effects
            game.Players:Chat(":char all 34685985")
            game.Players:Chat(":gear all 22787248")
            game.Players:Chat(":gear all 161230469")
            game.Players:Chat(":particle all c")
            -- Extra
            task.wait(0.35)
            game.Players:Chat("house")
            task.wait(0.35)
            game.Players:Chat(":tp all me")
            task.wait(0.15)
            game.Players:Chat("msg 🍉🍉🍉🍉🍉")
         end
         if string.sub(msg:lower(), 0, #msg) == "quiving" then
                     -- Map Effects
                     Quiving()
                     game.Players:Chat(":time 1")
                     game.Players:Chat(":fogend 1000")
                     game.Players:Chat(":fogcolor 0 250 0")
                     game.Players:Chat(":music 9046588312")
                     task.wait(0.25)
                     -- Avatar Effects
                     game.Players:Chat(":char all 25069105")
                     game.Players:Chat(":gear all 215392741")
                     game.Players:Chat(":gear all 292969932")
                     game.Players:Chat(":particle all a")
                     -- Extra
                     task.wait(0.35)
                     game.Players:Chat("house")
                     task.wait(0.35)
                     game.Players:Chat(":tp all me")
                     task.wait(0.15)
                     game.Players:Chat("msg 😺😺😺😺😺")
         end
         -- BrickColor Changer
         if string.sub(msg:lower(), 0, 8) == "mapcolor" then
            local Color = string.sub(msg, 10)
            if not Color then
               notify("Bender", "Please specify a map color.", 1)
               return
            end
            ChangeMapColor(Color)
            notify("Bender", "☑️", 1)
         end
      
         -- // Radio \\ --
      
         if string.sub(msg:lower(), 0, 4) == "play" then
            notify("Bender", "Processing request..", 1)
      
            -- Variables
            local RequestedSong = string.sub(msg, 6)
            local Callback = tostring(game:HttpGet("https://search.roblox.com/catalog/json?CatalogContext=2&AssetTypeID=3&PageNumber=1&limit=500&Category=9&SortType=0&keyword=" .. RequestedSong))
            local SongID = string.match(Callback, "%d+")
            local SongName
      
            if SongID ~= nil or "[]" then -- Checking if there's a SongID
               print(SongID)
               SongName = tostring(game:GetService("MarketplaceService"):GetProductInfo(SongID).Name)
            else
               task.wait(0.6) -- Delay For Notification To Pass
               notify("Bender", " '" .. RequestedSong .. "' does not exist!", 1)
               print(SongName)
               print(SongID)
               return
            end
      
            -- Playing and Announcing Song
            game.Players:Chat(":music " .. SongID)
            game.Players:Chat("msg Now Playing: " .. SongName)
            notify("Bender", "☑️", 1)
         end
      
         if string.sub(msg:lower(), 0, #msg) == "loop" then
            if isLockedAlready == true then
               return
               end;
               -- Checking For Sound
               local SoundPlaying, Error = pcall(function()
               if not game:GetService("Workspace").Terrain["_Game"].Folder.Sound then
                  return
               end
               end)
               if not SoundPlaying then
                  notifyError("Bender", "A sound has to be playing in order to lock sound!", 1)
                  return
               end
      
               if SoundCheck() == true then
                  getgenv().isLockedAlready = true;
                  local SavedSound = tostring(game:GetService("Workspace").Terrain["_Game"].Folder.Sound.SoundId)
                  local SoundID = tostring(string.match(SavedSound, "%d+$"))
                  notify("Bender", "☑️", 1)
                  game.Players:Chat("alert Sound is locked")
                  -- Setting Up Loop
                  LockedSound = true
                  while (LockedSound == true) do
                     -- Preventing Sound Adjustments
                     task.wait()
                     if (SoundCheck() == false) or (game:GetService("Workspace").Terrain["_Game"].Folder.Sound.SoundId ~= SavedSound)
                     or (string.match(SavedSound, "%d+$") == 0) then
                        pcall(function()
                           game.Players:Chat(":music " .. SoundID);
                           game:GetService("Workspace").Terrain["_Game"].Folder.Sound.Playing = true
                           task.wait(1)
                        end)
                     end
                  end
               end
            end
            if string.sub(msg:lower(), 0, #msg) == "unloop" then
               if isLockedAlready == true then
                  local Message = "Sound is Unlocked 📻"
                  LockedSound = false
                  isLockedAlready = false;
                  notify("Bender", "Successfully unlocked song!", 1)
                  game.Players:Chat("alert Sound is unlocked")
               else
                  notifyError("Bender", "A song hasn't been locked yet!", 1);
               end
            end
      
            if string.sub(msg:lower(), 0, 7) == "forward" then
      
               -- Checking For Sound
               local SoundPlaying, Error = pcall(function()
               if not game:GetService("Workspace").Terrain["_Game"].Folder.Sound then
                  return
                  end;
                  end);
                  if not SoundPlaying then
                     notifyError("Bender", "A sound has to be playing in order to fast-forward!", 1);
                     return
                     end;
                     -- Variables
                     local Request = string.sub(msg, 9)
                     local Sound = game:GetService("Workspace").Terrain["_Game"].Folder.Sound
                     -- Ensuring there is a Position
                     if not Request then
                        notifyError("Bender", "Please specify a position.", 1)
                        return
                     end
                     game:GetService("Workspace").Terrain["_Game"].Folder.Sound.TimePosition = game:GetService("Workspace").Terrain["_Game"].Folder.Sound.TimePosition + tonumber(Request); -- Variable didn't work
                     notify("Bender", "☑️", 1);
                  end
                  if string.sub(msg:lower(), 0, 7) == "reverse" then
      
                     -- Checking For Sound
                     local SoundPlaying, Error = pcall(function()
                     if not game:GetService("Workspace").Terrain["_Game"].Folder.Sound then
                        return
                        end;
                        end);
                        if not SoundPlaying then
                           notifyError("Bender", "A sound has to be playing in order to reverse!", 1);
                           return
                           end;
                           -- Variables
                           local Request = string.sub(msg, 9)
                           local Sound = game:GetService("Workspace").Terrain["_Game"].Folder.Sound
                           -- Ensuring there is a Position
                           if not Request then
                              notifyError("Bender", "Please specify a position.", 1)
                              return
                           end
                           game:GetService("Workspace").Terrain["_Game"].Folder.Sound.TimePosition = game:GetService("Workspace").Terrain["_Game"].Folder.Sound.TimePosition - tonumber(Request); -- Variable didn't work
                           notify("Bender", "☑️", 1);
                        end
                        if string.sub(msg:lower(), 0, 7) == "pbspeed" then
      
                           -- Checking For Sound
                           local SoundPlaying, Error = pcall(function()
                           if not game:GetService("Workspace").Terrain["_Game"].Folder.Sound then
                              return
                              end;
                              end);
                              if not SoundPlaying then
                                 notifyError("Bender", "A sound has to be playing in order to adjust speed!", 1);
                                 return
                                 end;
                                 -- Variables
                                 local Request = string.sub(msg, 9)
                                 local Sound = game:GetService("Workspace").Terrain["_Game"].Folder.Sound
                                 -- Ensuring there is a Position
                                 if not Request then
                                    notifyError("Bender", "Please specify a position.", 1)
                                    return
                                 end
                                 game:GetService("Workspace").Terrain["_Game"].Folder.Sound.PlaybackSpeed = tonumber(Request);
                                 notify("Bender", "☑️", 1);
                              end
      
                              if string.sub(msg:lower(), 0, 6) == "volume" then
                                 -- Checking For Sound
                                 local SoundPlaying, Error = pcall(function()
                                 if not game:GetService("Workspace").Terrain["_Game"].Folder.Sound then
                                    return
                                    end;
                                    end);
                                    if not SoundPlaying then
                                       notifyError("Bender", "A sound has to be playing in order to adjust volume!", 1);
                                       return
                                       end;
                                       -- Variables
                                       local Request = string.sub(msg, 8)
                                       local Sound = game:GetService("Workspace").Terrain["_Game"].Folder.Sound
                                       -- Ensuring there is a Position
                                       if not Request then
                                          notifyError("Bender", "Please specify a position.", 1)
                                          return
                                       end
                                       Sound.Volume = tonumber(Request);
                                       notify("Bender", "☑️", 1)
                                    end
                                    if string.sub(msg:lower(), 0, #msg) == "bypassmute" then
                                       -- Checking For Sound
                                       local SoundPlaying, Error = pcall(function()
                                       if not game:GetService("Workspace").Terrain["_Game"].Folder.Sound then
                                          return
                                          end;
                                          end);
                                          if not SoundPlaying then
                                             notifyError("Bender", "A sound must be playing, or muted in order to do this!", 1.5)
                                             return
                                             end;
      
                                             local Sound = game:GetService("Workspace").Terrain["_Game"].Folder.Sound
      
                                             if Sound.Playing == false then
                                                Sound.Playing = true
                                             end
                                             if Sound.Playing == true then
                                                notify("Bender", "☑️", 1);
                                             else
                                                notifyError("Bender", "A sound must be playing, or muted in order to do this!", 1.5)
                                             end
                                          end
      
                                          -- // Fun Commands \\ --
      
                                          if string.sub(msg:lower(), 0, 5) == "break" then
                                             local Request = string.sub(msg, 7)
                                             if Request == "all" or Request == "everyone" then
                                                Break("all")
                                                notify("Bender", "☑️", 1);
                                             elseif Request == "others" then
                                                Break("others")
                                                notify("Bender", "☑️", 1);
                                             elseif Request == "friends" then
                                                Break("friends")
                                                notify("Bender", "☑️", 1);
      
                                             elseif Request == "noadmins" then
                                                local ranOn = {}
                                                for _,v in pairs(game.Players:GetChildren()) do
                                                   if (not table.find(ranOn, v.Name)) then
                                                      local HasAdminPad = game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(v.Name .. "'s admin")
                                                      local HasPerm = CheckForPerm(v.Name)
                                                      if (not HasAdminPad) then
                                                         if HasPerm == false then
                                                            Break(v.Name)
                                                         elseif (HasAdminPad) and (not HasPerm) then
                                                            --
                                                         end
                                                      elseif (HasAdminPad) and (not HasPerm) then
                                                         --
                                                      end
                                                   end
                                                end
                                                notify("Bender", "☑️", 1);
      
                                                -- Additional Player Checks
                                             elseif GetMatchingPlayerName(Request) then
                                                Break(GetMatchingPlayerName(Request))
                                                notify("Bender", "☑️", 1);
                                             else
                                                notifyError("Bender", "Please specify who you would like to break!", 1)
                                             end
                                          end
                                          if string.sub(msg:lower(), 0, 7) == "silence" then
                                             local Request = string.sub(msg:lower(), 9)
      
                                             if string.sub(GetMatchingPlayerName(Request):lower(), 1, 3) ~= "me_" then
      
                                                if (Request == "all") or (Request == "everyone") then
                                                   Punish("all")
                                                   notify("Bender", "☑️", 1);
                                                elseif (Request == "others") then
                                                   Punish("others")
                                                   notify("Bender", "☑️", 1)
                                                elseif (Request == "friends") then
                                                   Punish("friends")
                                                   notify("Bender", "☑️", 1);
      
                                                elseif (Request == "noadmins") then
                                                   local isPunished = {}
                                                   for _,v in pairs(game.Players:GetChildren()) do
                                                      if (not table.find(isPunished, v.Name)) then
                                                         local HasAdminPad = game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(v.Name .. "'s admin")
                                                         local HasPerm = CheckForPerm(v.Name)
                                                         if (not HasAdminPad) then
                                                            if (not HasPerm) then
                                                               Punish(v.Name)
                                                               notify("Bender", "☑️", 1);
                                                            else
                                                               --
                                                            end
                                                         else
                                                            --
                                                         end
                                                      end
                                                   end
      
                                                elseif GetMatchingPlayerName(Request) then
                                                   Punish(GetMatchingPlayerName(Request))
                                                   notify("Bender", "☑️", 1);
                                                end
      
                                             else
                                                Punish("m"); -- Bypassing Me-Names
                                             end
                                          end
                                          if string.sub(msg:lower(), 0, #msg) == "chaos" then
                                             if (Chaos == true) then
                                                notifyError("Bender", "Chaos is already running!", 1)
                                                return
                                             end
                                             Chaos = true
                                             if (Chaos == true) then
                                                notify("Bender", "☑️", 1)
                                             else
                                                notifyError("Bender", "Unexpected error.", 1)
                                             end
                                          end
                                          if string.sub(msg:lower(), 0, #msg) == "rchaos" then

                                          end
      
                                          -- // Name Bypasses \\ --
      
                                          if string.sub(msg:lower(), 0, 6) == "mename" then
                                             local Command = string.sub(msg:lower(), 8)
                                             game.Players:Chat(Command .. " m")
                                          end
                                          if string.sub(msg:lower(), 0, 9) == "othername" then
                                             local Command = string.sub(msg:lower(), 11)
                                             game.Players:Chat(Command .. " other")
                                          end
                                          if string.sub(msg:lower(), 0, 7) == "allname" then
                                             local Command = string.sub(msg:lower(), 9)
                                             game.Players:Chat(Command .. " al")
                                          end
      
                                          -- // Security \\ --
      
                                          if string.sub(msg:lower(), 0, #msg) == "bypass" then
                                             local Old = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
                                             LP.Character:Destroy()
                                             task.wait(game.Players.RespawnTime + 0.4)
                                             LP.Character.HumanoidRootPart.CFrame = Old
                                             notify("Bender", "☑️", 1)
                                          end
      
                                          -- Antis --
      
                                          if string.sub(msg:lower(), 0, #msg) == "antic" then
                                             notify("Bender", "☑️", 1)
                                             Connections[#Connections + 1] = game:GetService("RunService").RenderStepped:Connect(function()
                                                for _, t in pairs(game.Players:GetPlayers()) do
                                                   local function findGear(gearName)
                                                      return t.Character:FindFirstChild(gearName) or t.Backpack:FindFirstChild(gearName)
                                                   end
                                                   if t.Name ~= User then
                                                      if
                                                      findGear("VampireVanquisher") or
                                                      findGear("OrinthianSwordAndShield") then
                                                         local Crasher = t.Name
                                                         game.Players:Chat(":ungear " .. Crasher)
                                                         break
                                                      end
                                                   end
                                                end
                                             end)
                                          end
                                          if string.sub(msg:lower(), 0, #msg) == "antianchor" then
                                             _G.antianchor = true
                                             while _G.antianchor == true do
                                                task.wait()
                                                local Anchor = LP.Character.HumanoidRootPart.Anchored
                                                if Anchor == true then
                                                   Anchor = false
                                                end
                                             end
                                          end
      
                                          -- // Gear Ban \\ --
      
                                          if string.sub(msg:lower(), 0, 7) == "gearban" then
                                             local Player = string.sub(msg, 9)
      
                                             if (game.Players.LocalPlayer.PlayerGui:FindFirstChild(GetMatchingPlayerName(Player))) then
                                                notifyError("Bender", GetMatchingPlayerName(Player) .. " is already Gear-Banned!", 1)
                                                return
                                             end
                                             local storedUser = Instance.new("ScreenGui");
                                             storedUser.Name = GetMatchingPlayerName(Player);
                                             storedUser.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui");
                                             storedUser.ResetOnSpawn = false;
                                             if (game.Players.LocalPlayer.PlayerGui:FindFirstChild(storedUser.Name)) then
                                                notify("Bender", "☑️", 1)
                                             end
                                             while (game.Players.LocalPlayer.PlayerGui:FindFirstChild(storedUser.Name)) do
                                                task.wait()
                                                for _,v in pairs(game.Players:GetChildren()) do
                                                   if (v.Name == GetMatchingPlayerName(Player)) then
                                                      Tool = v.Backpack:FindFirstChildOfClass("Tool")
                                                      EquippedTool = v.Character:FindFirstChildOfClass("Tool")
                                                      if (Tool or EquippedTool) then
                                                         game.Players:Chat("ungear " .. v.Name .. " " .. math.random(1, 100))
                                                         break
                                                      end
                                                   end
                                                end
                                                if not (game.Players.LocalPlayer.PlayerGui:FindFirstChild(storedUser.Name)) then
                                                   break
                                                end
                                             end
                                          end
      
                                          if string.sub(msg:lower(), 0, 9) == "gearunban" then
                                             local Player = string.sub(msg, 11)
                                             local callingPoint = game.Players.LocalPlayer.PlayerGui:FindFirstChild(GetMatchingPlayerName(Player));
                                             if (checkGearBanStatus(GetMatchingPlayerName(Player)) == true) then
                                                callingPoint:Destroy()
                                                local sameCallingPoint = game.Players.LocalPlayer.PlayerGui:FindFirstChild(GetMatchingPlayerName(Player));
                                                if (not sameCallingPoint) then
                                                   notify("Bender", "☑️", 1)
                                                else
                                                   --
                                                end
                                             end
                                          end
      
      
                                          -- // Map Related \\ --
      
                                          -- Admin Pads --
                                          if string.sub(msg:lower(), 0, #msg) == "regen" then
                                             Regen()
                                             notify("Bender", "☑️", 1)
                                          end
                                          if string.sub(msg:lower(), 0, #msg) == "perm" then
                                             Admin()
                                             notify("Bender", "☑️", 1)
                                          end
                                          if string.sub(msg:lower(), 0, #msg) == "unperm" then
                                             Perm = false
                                             game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild("Touch to get admin"):FindFirstChild("Head").Transparency = false
                                             notify("Bender", "☑️", 1)
                                          end
                                          -- Map Objects --
                                          if string.sub(msg:lower(), 0, #msg) == "nok" then
                                             for _, Bricks in pairs(game:GetService("Workspace").Terrain._Game.Workspace.Obby:GetChildren()) do
                                                Bricks.CanTouch = false
                                             end
                                          end
                                          if string.sub(msg:lower(), 0, #msg) == "walls" then
                                             for _, Walls in pairs(game:GetService("Workspace").Terrain._Game.Workspace["Obby Box"]:GetChildren()) do
                                                Walls.CanCollide = false
                                             end
                                          end
                                          if string.sub(msg:lower(), 0, #msg) == "wallnok" then
                                             for _, Walls in pairs(game:GetService("Workspace").Terrain._Game.Workspace["Obby Box"]:GetChildren()) do
                                                Walls.CanCollide = false
                                                for _, Bricks in pairs(game:GetService("Workspace").Terrain._Game.Workspace.Obby:GetChildren()) do
                                                   Bricks.CanTouch = false
                                                end
                                             end
                                          end
                                          -- Map Fixes --
                                          if string.sub(msg:lower(), 0, #msg) == "hardfix" then
                                             HardFix()
                                          end
                                          if string.sub(msg:lower(), 0, #msg) == "paintfix" then
                                             FixMapColors();
                                             task.wait(0.25)
                                             notify("Bender", "☑️", 1)
                                          end
                                          if string.sub(msg:lower(), 0, #msg) == "sweep" then
                                             game.Players:Chat("🧹")
                                             game.Players:Chat(":clean")
                                             game.Players:Chat(":fix")
                                             game.Players:Chat(":ungear all")
                                             game.Players:Chat(":heal all 100")
                                             notify("Bender", "☑️", 1)
                                          end
                                          -- Client Map Fixes
                                          if string.sub(msg:lower(), 0, #msg) == "unvelo" then
                                             local mapFolder = game:GetService("Workspace").Terrain._Game.Workspace
                                             for _,v in pairs(mapFolder:GetDescendants()) do
                                                task.spawn(function()
                                                if v:IsA("Part") then
                                                   v.Velocity = Vector3.new(0, 0, 0)
                                                else
                                                   --
                                                end
                                             end)
                                          end
                                          notify("Bender", "☑️", 1)
                                       end
                                       if string.sub(msg:lower(), 0, #msg) == "unvoid" then
                                          workspace.FallenPartsDestroyHeight = 0 / 0
                                          notify("Bender", "☑️", 1)                        
                                       end
      
                                          -- // Defensive Commands \\ --
                                                                           
                                          if string.sub(msg:lower(), 0, #msg) == "close" then
                                             print("This command is currently being reworked; expect it to work in the future")
                                             return
                                          end
      
                                          if string.sub(msg:lower(), 0, #msg) == "pclose" then
                                             notify("Bender", "...", 0.5)
                                             local HasPersons = CheckForPersons(LP.Name)
                                             local Timer = 1
      
                                             -- Checking For Persons
                                             if HasPersons then
                                                -- Setting Up Crash
                                                notify("Bender", "Attempting to crash..", 1)
                                                game.Players:Chat(":respawn all")
                                                getgenv().Loop = true
                                                while Loop == true do
                                                   -- Server Crash
                                                   task.wait()
                                                   Timer = Timer + 1
                                                   task.spawn(function()
                                                   game.Players:Chat(":rocket/all/all/all")
                                                   game.Players:Chat(":clone all")
                                                   game.Players:Chat("shield/all/all/all")
                                                   end)
                                                   -- Breaking Loop
                                                   if Timer == 150 then
                                                      if CheckForCrash() == true then
                                                         notify("Bender", "Server Crashed, Switching Servers..", 1)
                                                         task.wait(0.25)
                                                         ServerHop()
                                                         break
                                                      else
                                                         notifyError("Bender", "ERROR: HasCrashed = " .. tostring(CheckForCrash()), 5)
                                                         break
                                                      end
                                                   end
                                                end
                                             else
                                                notifyError("Bender", "You need the Person299 gamepass for that!", 1)
                                             end
                                          end
                                          if string.sub(msg:lower(), 0, #msg) == "osclose" then
                                             notify("Bender", "Attempting to crash...", 1)
                                             OSClose()
                                             -- Crash Check
                                             if CheckForCrash() == true then
                                                notify("Bender", "Server Crashed, Switching Servers..", 1)
                                                task.wait(0.25)
                                                ServerHop()
                                             else
                                                notifyError("Bender", "ERROR: HasCrashed = " .. tostring(CheckForCrash()), 5)
                                             end
                                          end
                                          if string.sub(msg:lower(), 0, 7) == "softlag" then
                                             if _G.softLagging == true then
                                                notifyError("Bender", "Softlag is already running!", 1)
                                                return
                                             end
                                             _G.softLagging = true;
      
                                             local Duration = tonumber(string.sub(msg, 9))
                                             notify("Bender", "...", 0.5)
                                             local HasAdminPad = game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(LP.Name .. "'s admin")
                                             local HasPerm = CheckForPerm(LP.Name)
                                             if (HasAdminPad) or (HasPerm == true) then
                                                if (Duration) then
                                                   notify("Bender", "Attempting to lag..", 1)
                                                   task.spawn(function()
                                                   Countdown(Duration)
                                                   end)
                                                   local stopLag = false;
                                                   local finished = false;
                                                   local crashFunc = coroutine.create(function()
                                                   if (stopLag) then
                                                      coroutine.yield()
                                                      return
                                                   end
                                                   local startTime = os.clock()
                                                   local endTime = startTime + Duration
                                                   local randomInteger = math.random(1, 99)
                                                   while (os.clock() < endTime) do
                                                      task.wait()
                                                      task.spawn(function()
                                                      for i = 1, 5 do
                                                         game.Players:Chat(":gear all 253519495")
                                                      end
                                                      end)
                                                   end
                                                   finished = true;
                                                   LostAdmin = false;
                                                   coroutine.yield()
                                                   end)
                                                   coroutine.resume(crashFunc)
      
                                                   task.spawn(function()
                                                   while task.wait(0.5) do
                                                      if HasAdminPad or HasPerm == true then
                                                         LostAdmin = false
                                                      else
                                                         LostAdmin = true
                                                         break
                                                      end
                                                   end
                                                   end)
                                                   repeat task.wait() until (finished == true) or (LostAdmin == true)
                                                      if (LostAdmin == true) then
                                                         notify("Bender", "Lost admin, yielding..")
                                                         return
                                                      end
                                                      notify("Bender", "Recovering.. 🤠", 1)
                                                      for i = 1, 15 do
                                                         task.wait(0.5)
                                                         game.Players:Chat(":respawn all")
                                                         game.Players:Chat(":ungear all")
                                                         game.Players:Chat(":fix")
                                                      end
                                                      notify("Bender", "Lag Finished! ☑️", 1)
                                                      _G.softLagging = false;
                                                   else
                                                      notifyError("Bender", "The second argument must be a number!", 1)
                                                   end
                                                else
                                                   notifyError("Bender", "You must have admin in order to use this command!", 1)
                                                end
                                             end
                                             if string.sub(msg:lower(), 0, 7) == "hardlag" then
                                                if _G.hardLagging == true then
                                                   notifyError("Bender", "Hardlag is already running!", 1)
                                                   return
                                                end
                                                _G.hardLagging = true;
      
                                                local Duration = tonumber(string.sub(msg, 9))
                                                notify("Bender", "...", 0.5)
                                                local HasAdminPad = game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(LP.Name .. "'s admin")
                                                local HasPerm = CheckForPerm(LP.Name)
                                                if (HasAdminPad) or (HasPerm == true) then
                                                   if (Duration) then
                                                      game:GetService("RunService"):Set3dRenderingEnabled(false)
                                                      chatNotify("Your camera is temporarily disabled to prevent client crashes.", 800)
                                                      notify("Bender", "Attempting to lag..", 1)
                                                      task.spawn(function()
                                                      Countdown(Duration)
                                                      end)
                                                      local stopLag = false;
                                                      local finished = false;
                                                      local crashFunc = coroutine.create(function()
                                                      if (stopLag) then
                                                         coroutine.yield()
                                                         return
                                                      end
                                                      local startTime = os.clock()
                                                      local endTime = startTime + Duration
                                                      local randomInteger = math.random(1, 99)
                                                      game.Players:Chat(":respawn all")
                                                      game.Players:Chat(":time 1")
                                                      game.Players:Chat(":fogend 1")
                                                      game.Players:Chat(":fogcolor 0 0 0")
                                                      game.Players:Chat(":jail all")
                                                      task.wait(0.25)
                                                      while (os.clock() < endTime) do
                                                         task.wait()
                                                         task.spawn(function()
                                                         for i = 1, 5 do
                                                            local longChar = "🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠"
                                                            local extendedChar = longChar .. longChar .. longChar .. longChar .. longChar .. longChar
                                                            local Random = math.random(1, 99)
                                                            game.Players:Chat(":smoke all, all, all " .. Random)
                                                            game.Players:Chat(":gear all 253519495")
                                                         end
                                                         end)
                                                      end
                                                      finished = true;
                                                      LostAdmin = false;
                                                      coroutine.yield()
                                                      end)
                                                      coroutine.resume(crashFunc)
      
                                                      task.spawn(function()
                                                      while task.wait(0.5) do
                                                         if HasAdminPad or HasPerm == true then
                                                            LostAdmin = false
                                                         else
                                                            LostAdmin = true
                                                            break
                                                         end
                                                      end
                                                      end)
                                                      repeat task.wait() until (finished == true) or (LostAdmin == true)
                                                         if (LostAdmin == true) then
                                                            notify("Bender", "Lost admin, yielding..")
                                                            FixMapColors()
                                                            game:GetService("RunService"):Set3dRenderingEnabled(true)
                                                            _G.hardLagging = false;
                                                            return
                                                         end
                                                         notify("Bender", "Recovering.. 🤠", 1)
                                                         for i = 1, 15 do
                                                            game.Players:Chat(":respawn all")
                                                            game.Players:Chat(":ungear all")
                                                            game.Players:Chat(":fix")
                                                            game.Players:Chat(":clean")
                                                         end
                                                         notify("Bender", "Lag Finished! ☑️", 1)
                                                         _G.hardLagging = false;
                                                         game:GetService("RunService"):Set3dRenderingEnabled(true)
                                                         FixMapColors()
                                                      else
                                                         notifyError("Bender", "The second argument must be a number!", 1)
                                                         _G.hardLagging = false;
                                                      end
                                                   else
                                                      notifyError("Bender", "You must have admin in order to use this command!", 1)
                                                      _G.hardLagging = false;
                                                   end
                                                end
                                                if string.sub(msg:lower(), 0, #msg) == "vclose" then
                                                   notify("Bender", "Please wait..", 1)

                                                   -- Variables
                                                   local HasAdminPad = game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(LP.Name .. "'s admin")
                                                   local HasPerm = CheckForPerm(LP.Name)
                                                   local HasAdmin = (HasPerm == true) or (HasAdminPad)
                                                   local FinishedCrashAttempt
                                                   -- Admin Check
                                                   if (HasAdmin) then
                                                      notify("Bender", "Attempting to crash..", 1)
                                                      -- Server Crash
                                                      task.spawn(function()
                                                            if (LP.Backpack:FindFirstChildOfClass("Tool")) then
                                                               game.Players:Chat(":ungear " .. User)
                                                            end
                                                            game.Players:Chat("vg")
                                                            repeat task.wait() until LP.Backpack:FindFirstChild("VampireVanquisher")
                                                            EquipTool()
                                                            task.wait(0.5)
                                                            for i = 1, 25 do
                                                               game.Players:Chat("size me .3")
                                                            end
                                                            FinishedCrashAttempt = true
                                                         end)
                                                         -- Crash Check
                                                         repeat task.wait() until (FinishedCrashAttempt == true)
                                                         task.wait(0.25)
                                                         if (CheckForCrash() == true) then
                                                            notify("Bender", "Server Crashed, Switching Servers..", 1)
                                                            ServerHop()
                                                         else
                                                            notifyError("Bender", "ERROR: HasCrashed = " .. tostring(CheckForCrash()), 5)
                                                            return
                                                         end
                                                      else
                                                         notifyError("Bender", "You must have admin in order to use this command!", 1)
                                                         return
                                                      end
                                                   end
      
                                                -- // Other Scripts \\ --
      
                                                if string.sub(msg:lower(), 0, #msg) == "infy" then
                                                   loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
                                                end
                                                if string.sub(msg:lower(), 0, #msg) == "chatlogs" then
                                                   if (openedChatLogs == true) then
                                                      notify("Bender", "ChatLogs has already been opened!", 1)
                                                      return
                                                   end
                                                   notify("Bender", "Please wait..", 1)
                                                   openedChatLogs = true
                                                   loadstring(game:HttpGet("https://raw.githubusercontent.com/traveIing/bender/main/Chat%20Logs.lua"))()
                                                end
                                                if string.sub(msg:lower(), 0, #msg) == "dex" then
                                                   loadstring(game:HttpGet("https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua"))()
                                                end
      
                                                -- // Message Related \\ --
      
                                                if string.sub(msg:lower(), 0, 3) == "msg" then
                                                   local Message = string.sub(msg, 5)
                                                   game.Players:Chat("h \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n " .. Message)
                                                end
                                                if string.sub(msg:lower(), 0, 5) == "alert" then
                                                   local Message = string.sub(msg, 7)
                                                   game.Players:Chat("h \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n " .. Message)
                                                end
                                                if string.sub(msg:lower(), 0, 4) == "spam" then
                                                   local Message = string.sub(msg, 6)
                                                   _G.Spam = true
                                                   while _G.Spam == true do
                                                      task.wait()
                                                      game.Players:Chat(Message)
                                                      task.wait()
                                                   end
                                                end
                                                if string.sub(msg:lower(), 0, 6) == "unspam" then
                                                   _G.Spam = false
                                                end
      
                                                -- // Teleport Locations \\ --
      
                                                if string.sub(msg:lower(), 0, 4) == "pads" then
                                                   LP.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-41, 4, 35))
                                                end
                                                if string.sub(msg:lower(), 0, 6) == "finish" then
                                                   LP.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-41, 4, 35))
                                                end
                                                if string.sub(msg:lower(), 0, 5) == "house" then
                                                   LP.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-23, 8, 73))
                                                end
                                                if string.sub(msg:lower(), 0, 4) == "roof" then
                                                   LP.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-30, 42, 69))
                                                end
      
                                                -- // Information \\ --
      
                                                -- Server Information --
                                                if string.sub(msg:lower(), 0, #msg) == "jobid" then
                                                   setclipboard(jobID)
                                                   task.wait(0.5)
                                                   notify("Bender", "Copied to clipboard!", 1)
                                                end
                                                if string.sub(msg:lower(), 0, #msg) == "placeid" then
                                                   setclipboard(placeID)
                                                   task.wait(0.5)
                                                   notify("Bender", "Copied to clipboard!", 1)
                                                end
                                                if string.sub(msg:lower(), 0, #msg) == "copysound" then
                                                   local Sound = game:GetService("Workspace").Terrain["_Game"].Folder.Sound.SoundId
                                                   if Sound then
                                                      setclipboard(tostring(Sound))
                                                      task.wait(0.5)
                                                      notify("Bender", "Copied to clipboard!", 1)
                                                   else
                                                      notifyError("Bender", "A sound isn't playing right now.", 1)
                                                   end
                                                end
                                                if string.sub(msg:lower(), 0, #msg) == "ping" then
                                                   local Ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(), " "
                                                   notify("Bender", Ping, 1)
                                                end
                                                if (string.sub(msg:lower(), 0, #msg) == "playercount") or (string.sub(msg:lower(), 0, #msg) == "pcount") then
                                                   notify("Bender", "Server contains " .. #game.Players:GetPlayers() .. " players.", 1.5)
                                                end
                                                if string.sub(msg:lower(), 0, #msg) == "crashcheck" then
                                                   local HasCrashed = CheckForCrash()
                                                   if HasCrashed == true then
                                                      notify("Bender", "Server is crashed.", 1.5)
                                                   else
                                                      notify("Bender", "Server is not crashed!", 1.5)
                                                   end
                                                end
                                                if string.sub(msg:lower(), 0, #msg) == "regcheck" then
                                                   local Regen = game:GetService("Workspace").Terrain["_Game"].Admin:FindFirstChild("Regen")
                                                   if Regen then
                                                      notify("Bender", "☑️", 1)
                                                   elseif not Regen then
                                                      notify("Bender", "❌", 1)
                                                   end
                                                end
                                                -- Player Information --
                                                if string.sub(msg:lower(), 0, 8) == "copyuser" then
                                                   local Player = string.sub(msg:lower(), 10)
                                                   setclipboard(GetMatchingPlayerName(Player))
                                                end
                                                if string.sub(msg:lower(), 0, 6) == "copyid" then
                                                   local Player = string.sub(msg:lower(), 8)
                                                   for _, v in pairs(game.Players:GetPlayers()) do
                                                      if v.Name == GetMatchingPlayerName(Player) then
                                                         setclipboard(tostring(v.UserId))
                                                      end
                                                   end
                                                end
                                                if string.sub(msg:lower(), 0, 9) == "permcheck" then
                                                   local Player = string.sub(msg, 11)
                                                   if GetMatchingPlayerName(Player) == "No player found." then
                                                      notifyError("Bender", "'" .. Player .. "' does not exist!", 1)
                                                   elseif GetMatchingPlayerName(Player) == "Multiple players found." then
                                                      notifyError("Bender", "Multiple Players Found.", 1)
                                                   elseif GetMatchingPlayerName(Player) == "Given input is too long." then
                                                      notifyError("Bender", "'" .. Player .. "' does not exist!", 1)
                                                   elseif not GetMatchingPlayerName(Player) then
                                                      notifyError("Bender", "Please specify who you want to check.", 1)
                                                   else
                                                      if CheckForPerm(GetMatchingPlayerName(Player)) == true then
                                                         notify("Bender", "'" .. GetMatchingPlayerName(Player) .. "' has perm!", 1);
                                                      else
                                                         notify("Bender", "'" .. GetMatchingPlayerName(Player) .. "' doesn't have perm!", 1);
                                                      end
                                                   end
                                                end
      
                                                -- // Utilities \\ --
      
                                                -- Advanced
                                                if string.sub(msg:lower(), 0, 3) == "run" then
                                                   local chattedCode = string.sub(msg, 5)
                                                   local Function, codeError = loadstring("return function() " .. chattedCode .. " end")
                                                   if not Function then
                                                      print("Error loading code: " .. codeError)
                                                      return
                                                   end
                                                   local success, errorReason = pcall(Function())
                                                   if not success then
                                                      print("Error executing function: " .. errorReason)
                                                      return
                                                   end
                                                   print("☑️")
                                                end
                                                -- Roblox Utilities
                                                if string.sub(msg:lower(), 0, #msg) == "exit" then
                                                   task.wait(0.2)
                                                   game:Shutdown()
                                                end
                                                if string.sub(msg:lower(), 0, #msg) == "rejoin" or string.sub(msg:lower(), 0, #msg) == "rj" then
                                                   Rejoin()
                                                end
                                                if string.sub(msg:lower(), 0, #msg) == "clearlogs" then
                                                   notify("Bender", "...", 0.5)
                                                   ClearLogs()
                                                   notify("Bender", "☑️", 1)
                                                end
                                                if string.sub(msg:lower(), 0, #msg) == "clearchat" then
                                                   ClearChat()
                                                end
                                                if string.sub(msg:lower(), 0, 6) == "friend" then
                                                   local Player = string.sub(msg, 8)
                                                   if not GetMatchingPlayerName(Player) then
                                                      notifyError("Bender", "Please specify a user you would like to friend.", 1)
                                                      return
                                                   end
                                                   LP:RequestFriendship(game.Players:FindFirstChild(GetMatchingPlayerName(Player)))
                                                   notify("Bender", "☑️", 1)
                                                end
                                                if string.sub(msg:lower(), 0, 8) == "unfriend" then
                                                   local Player = string.sub(msg, 10)
                                                   if not GetMatchingPlayerName(Player) then
                                                      notifyError("Bender", "Please specify a user you would like to unfriend.", 1)
                                                      return
                                                   end
                                                   LP:RevokeFriendship(game.Players:FindFirstChild(GetMatchingPlayerName(Player)))
                                                   notify("Bender", "☑️", 1)
                                                end
                                                -- Game Teleport Utilities
                                                if (string.sub(msg:lower(), 0, #msg) == "hop") or (string.sub(msg:lower(), 0, #msg) == "serverhop") then
                                                   notify("Bender", "Switching servers..", 1)
                                                   task.wait(0.5)
                                                   ServerHop()
                                                end
                                                -- Script Utilities
                                                if string.sub(msg:lower(), 0, #msg) == "closeinstance" then
                                                   for _,Connection in ipairs(Connections) do
                                                      Connection:Disconnect()
                                                      LockedSound = false
                                                      DestroyCommandBar()
                                                      EndWhitelist()
                                                      break
                                                   end
                                                end
                                                -- // API Utilities
                                                if string.lower(string.sub(msg, 1, 6)) == "lookup" then
                                                   local Request = string.sub(msg, 8)
                                                   if string.sub(Request, 1, 5) == "user:" then
                                                      local userToFetch = string.sub(Request, 6)
                                                      notify("Bender", "Fetching user data...", 1)
                                                      promptProfileGUI(userToFetch)
                                                   else
                                                      -- Making sure the username is a real player
                                                      local matchingPlayer = GetMatchingPlayerName(Request)
                                                      if matchingPlayer ~= "Given input is too long." and matchingPlayer ~= "Multiple players found." and matchingPlayer ~= "No player found." then
                                                         notify("Bender", "Fetching user data...", 1)
                                                         promptProfileGUI(matchingPlayer)
                                                      else
                                                         notifyError("Bender", Request .. " is not a valid player!", 1)
                                                      end
                                                   end
                                                end
                                                -- Chat Bars --
                                                if string.sub(msg:lower(), 0, #msg) == "cmdbar" then
                                                   loadstring(game:HttpGet("https://raw.githubusercontent.com/traveIing/bender/main/Command%20Bar.lua"))()
                                                end
                                                if string.sub(msg:lower(), 0, #msg) == "hidecmdbar" then
                                                   DestroyCommandBar()
                                                end
      
                                                -- // Developer Beta \\ --
      
                                                -- Enable Beta
                                                if string.sub(msg:lower(), 0, 4) == "beta" then
                                                   local reqConfig = string.sub(msg, 6)
      
                                                   if (not reqConfig) then
                                                      notifyError("Bender (BETA)", "Please specify a configuration.", 1)
                                                      return
                                                   end
                                                   if (reqConfig == "true") then
                                                      if (EnableDisableBeta(true) == true) then
                                                         notify("Bender (BETA)", "Success!", 1)
                                                         promptBetaInfo()
                                                         warn("ENDVBTPS")
                                                      end
                                                   elseif (reqConfig == "false") then
                                                      if (EnableDisableBeta(false) == true) then
                                                         notify("Bender (BETA)", "Disabled!", 1)
                                                         warn("DSBDVBTPS")
                                                      end
                                                   elseif (not reqConfig == "false" or "true") then
                                                      notifyError("Bender", "Please enter a valid configuration.", 1)
                                                      warn("ENDVBTFS && DSBDVBTFS")
                                                   end
                                                end
      
                                                -- Commands

                                                if split[1] == "rlag" then
                                                   notify("Bender (BETA)", "...", 0.5)
                                                   -- Variables
                                                   local Player = split[2]
                                                   local checkedUser = GetMatchingPlayerName(Player)
                                                   local psUser = checkedUser .. "/"
                                                   local Reason = rest2
                                                   print(Reason)
                                                   local HasAdminPad = game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(LP.Name .. "'s admin")
                                                   local HasPerm = CheckForPerm(LP.Name)
                                                   local HasAdmin = (HasPerm == true) or (HasAdminPad)
                                                   local HasPersons = CheckForPersons(LP.Name)
                                                   -- Admin / Person299 Checks
                                                   if (HasAdmin) or (HasPersons) then
                                                      -- Argument Checks
                                                      if (not Player) then
                                                         notifyError("Bender (BETA)", "Please specify a user.", 1)
                                                         return
                                                      end
                                                      if checkedUser ~= "Given input is too long." and checkedUser ~= "Multiple players found." and checkedUser ~= "No player found." then
                                                         -- Setting Up Lag
                                                         local finishedLagging = false;
                                                         chatNotify("PS: This command will 100% lag the server if it's successful, just reset the person you're lagging to stop it.", 800)
                                                         task.spawn(function()
                                                            game.Players:Chat(":respawn " .. checkedUser)
                                                            game.Players:Chat(":setgrav " .. checkedUser .. " 1500")
                                                            -- Setting Lag Message
                                                            if (Reason) then
                                                               LagMessage = Reason;
                                                            else
                                                               LagMessage = "Unspecified.";
                                                            end
                                                            game.Players:Chat(":blind " .. checkedUser)
                                                            task.wait(0.25)
                                                            game.Players:Chat("pm/" .. checkedUser .. "/ \n\n\n\n\n\n\n You were lagged for the following reason: \n\n\n\n\n\n\n\n\n\n " .. LagMessage)
                                                            task.wait(0.25)
                                                            -- Lagging Player
                                                            for i = 1, 100 do
                                                               game.Players:Chat("rocket/" .. psUser .. psUser .. psUser)
                                                            end
                                                            task.wait(0.5)
                                                            game.Players:Chat(":trip " .. checkedUser)
                                                            game.Players:Chat(":size " .. checkedUser .. " nan")
                                                            task.wait(0.25)
                                                            for i = 1, 5 do
                                                            game.Players:Chat(":clone " .. checkedUser)
                                                            end
                                                            finishedLagging = true;
                                                         end)
                                                         repeat task.wait() until finishedLagging == true;
                                                         notify("Bender (BETA)", "☑️", 1)
                                                      else
                                                         notifyError("Bender (BETA)", "Invalid user.", 1)
                                                      end
                                                   else
                                                      notifyError("Bender (BETA)", "Missing Admin, or Person299.", 1)
                                                      return
                                                   end
                                                end
                                                if string.sub(msg:lower(), 0, #msg) == "overridechecks" then
                                                   function CheckForPerm() 
                                                      return true;
                                                   end
                                                   function CheckForPersons()
                                                      return true;
                                                   end
                                                   notify("Bender (BETA)", "☑️", 1)
                                                end
                                                if string.sub(msg:lower(), 0, 10) == "joinplayer" then
                                                   if not (BetaEnabled == true) then
                                                      return
                                                   end
                                                   local Request = string.sub(msg, 12)
                                                   -- Argument Check
                                                   if (not Request) then
                                                      notifyError("Bender (BETA)", "Please specify a username.", 1)
                                                      return
                                                   end
                                                   notify("Bender (BETA)", "Fetching user data...", 1)
                                                   -- Finding Player's ID
                                                   local infoRequest = HttpRequest({
                                                      Url = "https://api.joinbender.com/roblox/LookupAPI/userinfo.php?username=" .. Request;
                                                   })
                                                   for i, json in pairs(infoRequest) do
                                                      if (type(json) == "string") then
                                                         local ID = json:gsub('.*"id":(.-),.*', '%1')
                                                         _G.SHUserID = ID
                                                      end
                                                   end
                                                   -- ID Validity Check
                                                   if (not _G.SHUserID) then
                                                      notifyError("Bender (BETA)", "Couldn't fetch a valid ID from your request.", 1)
                                                      warn("JSIDFS")
                                                      return
                                                   end
                                                   -- Attempting To Teleport to Player
                                                   notify("Bender (BETA)", "Attempting to join " .. Request .. "...", 1)
                                                   task.wait(1.5)
                                                   JoinPlayer(_G.SHUserID)
                                                end
                                                if (string.sub(msg:lower(), 0, #msg) == "favmap") then
                                                   task.wait(0.5)
                                                   ChangeMapColor("Really blue")
                                                   task.wait(0.25)
                                                   game.Players:Chat(":time -")
                                                   game.Players:Chat(":brightness 0")
                                                   game.Players:Chat("msg :)")
                                                end
                                                if string.sub(msg:lower(), 0, 4) == "void" then
                                                   -- Variables
                                                   local Received, Player, FireLaser
                                                   do
                                                      Received = string.sub(msg, 6)
                                                      Player = GetMatchingPlayerName(Received)
                                                      FireLaser = function(c1, c2, c3)
                                                         local args = {
                                                            [1] = "Click",
                                                            [2] = true,
                                                            [3] = Vector3.new(c1, c2, c3)
                                                         }
                                                         game:GetService("Players").LocalPlayer.Character.HyperlaserGun:WaitForChild("ServerControl"):InvokeServer(unpack(args))
                                                      end
                                                      local PlayerCFrame
                                                      local PlayerExists
                                                   end

                                                   -- Setting Things Up
                                                   for _,v in pairs(game.Players:GetPlayers()) do
                                                      pcall(function()
                                                         if (v.Name == Player) and (v.Character) then
                                                            PlayerExists = true
                                                            PlayerCFrame = v.Character.HumanoidRootPart.CFrame
                                                         end
                                                      end)
                                                   end
                                                   -- Player Checks
                                                   if (Player == User) then
                                                      notify("Bender (BETA)", "You can't void yourself.", 1)
                                                      return
                                                   end
                                                   if (PlayerExists ~= true) then
                                                      print(PlayerExists)
                                                      notify("Bender (BETA)", "Sorry, this person doesn't exist.", 1)
                                                      return
                                                   end
                                                   -- Breaking Player

                                                   game.Players:Chat(":speed " .. Player .. " 0")
                                                   LP.Character.HumanoidRootPart.CFrame = PlayerCFrame * CFrame.new(0,0,7.5)
                                                   task.wait(0.2)
                                                   game.Players:Chat(":gear me 130113146")
                                                   repeat task.wait() until LP.Backpack:FindFirstChild("HyperlaserGun")
                                                   EquipTool()
                                                   task.wait(0.2)
                                                   local x,y,z = getPlayerRootPartPosition(game.Players:FindFirstChild(Player))
                                                   task.spawn(function()
                                                   FireLaser(x, y, z)
                                                   end)
                                                   task.wait(0.55)
                                                   game.Players:Chat(":punish " .. Player)
                                                   task.wait(3.5)
                                                   game.Players:Chat(":respawn " .. Player)
                                                   task.wait(0.9)
                                                   if (Search:FindWorkspaceItem(Player) == false) then
                                                      notify("Bender (BETA)", "☑️", 1)
                                                   else
                                                      notify("Bender (BETA)", "Failed to void " .. Player .. ".", 1)
                                                   end
                                                end

                                                -- // Whitelist System \\ --
      
                                                if string.sub(msg:lower(), 0, 2) == "wl" then
                                                   local Player = string.sub(msg, 4)
                                                   if GetMatchingPlayerName(Player) == "No player found." then
                                                      notifyError("Bender", "'" .. Player .. "' does not exist!", 1)
                                                   elseif GetMatchingPlayerName(Player) == "Multiple players found." then
                                                      notifyError("Bender", "Multiple Players Found, unable to whitelist!", 1)
                                                   elseif GetMatchingPlayerName(Player) == "Given input is too long." then
                                                      notifyError("Bender", "'" .. Player .. "' does not exist!", 1)
                                                   elseif not GetMatchingPlayerName(Player) then
                                                      notifyError("Bender", "Please specify who you would like to whitelist.", 1)
                                                   elseif table.find(Whitelisted, GetMatchingPlayerName(Player)) then
                                                      notifyError("Bender", "Player is already whitelisted!", 1)
                                                   else
                                                      Whitelist(GetMatchingPlayerName(Player))
                                                      notify("Bender", "Whitelisted " ..GetMatchingPlayerName(Player) .. "!", 1)
                                                      game.Players:Chat(":pm " .. GetMatchingPlayerName(Player) .. " You have been whitelisted! Your prefix is '" .. Pref .. "', say '" .. Pref .. "help' for a list of commands.")
                                                   end
                                                end
                                                if string.sub(msg:lower(), 0, 4) == "unwl" then
                                                   local Player = string.sub(msg, 6)
                                                   if GetMatchingPlayerName(Player) == "No player found." then
                                                      notifyError("Bender", "'" .. Player .. "' does not exist!", 1)
                                                   elseif GetMatchingPlayerName(Player) == "Multiple players found." then
                                                      notifyError("Bender", "Multiple Players Found, unable to remove whitelist!", 1)
                                                   elseif GetMatchingPlayerName(Player) == "Given input is too long." then
                                                      notifyError("Bender", "'" .. Player .. "' does not exist!", 1)
                                                   elseif not GetMatchingPlayerName(Player) then
                                                      notifyError("Bender", "Please specify who you would like to unwhitelist.", 1)
                                                   else
                                                      Unwhitelist(GetMatchingPlayerName(Player))
                                                      notify("Bender", "Unwhitelisted " .. GetMatchingPlayerName(Player) .. "!", 1)
                                                      game.Players:Chat(":pm " .. GetMatchingPlayerName(Player) .. " You have been unwhitelisted.")
                                                   end
                                                end
                                                if string.sub(msg:lower(), 0, 4) == "rewl" then -- VERY BROKEN
                                                   local Player = string.sub(msg, 6)
                                                   local NotWhitelisted = {}
                                                   local ReWhitelisted = {}
                                                   if Player == "all" then
                                                      for _, v in pairs(game.Players:GetChildren()) do
                                                         if table.find(Whitelisted, v.Name) then
                                                            task.wait()
                                                            Unwhitelist(v.Name)
                                                            Whitelist(v.Name)
                                                            table.insert(ReWhitelisted, v.Name)
                                                            game.Players:Chat(":pm " .. v.Name .. " You have been whitelisted! Your prefix is '" .. Pref .. "', say '" .. Pref .. "help' for a list of commands!")
                                                         else
                                                            table.insert(NotWhitelisted, v.Name)
                                                         end
                                                      end
                                                      task.wait(0.25)
                                                      if #ReWhitelisted == 1 then
                                                         notify("Bender", "Successfully rewhitelisted " .. #ReWhitelisted .. " player!", 1)
                                                      elseif #ReWhitelisted == 0 then
                                                         notify("Bender", "Couldn't find any whitelisted players.", 1)
                                                      else
                                                         notify("Bender", "Successfully rewhitelisted " .. #ReWhitelisted .. " players!", 1)
                                                      end
                                                   else
                                                      if GetMatchingPlayerName(Player) == "No player found." then
                                                         notifyError("Bender", "'" .. Player .. "' does not exist!", 1)
                                                      elseif GetMatchingPlayerName(Player) == "Multiple players found." then
                                                         notifyError("Bender", "Multiple players found. Unable to rewhitelist!", 1)
                                                      elseif GetMatchingPlayerName(Player) == "Given input is too long." then
                                                         notifyError("Bender", "'" .. Player .. "' does not exist!", 1)
                                                      elseif not table.find(Whitelisted, GetMatchingPlayerName(Player)) then
                                                         notifyError("Bender", "'" .. GetMatchingPlayerName(Player) .. "' has to be whitelisted in order to do that!", 1)
                                                      else
                                                         Unwhitelist(GetMatchingPlayerName(Player))
                                                         Whitelist(GetMatchingPlayerName(Player))
                                                         notify("Bender", "Rewhitelisted '" .. GetMatchingPlayerName(Player) .. "'!", 1)
                                                         game.Players:Chat(":pm " .. GetMatchingPlayerName(Player) .. " You have been whitelisted! Your prefix is '" .. Pref .. "', say '" .. Pref .. "help' for a list of commands!")
                                                      end
                                                   end
                                                end
                                                if string.sub(msg:lower(), 0, 7) == "checkwl" then
                                                   local Player = string.sub(msg, 9)
                                                   if table.find(Whitelisted, GetMatchingPlayerName(Player)) then
                                                      notify("Bender", GetMatchingPlayerName(Player) .. "' is whitelisted!", 1.5)
                                                   elseif not table.find(Whitelisted, GetMatchingPlayerName(Player)) then
                                                      notify("Bender", "'" .. Player .. " is not whitelisted!", 1.5)
                                                   end
                                                end
                                                end)
      
                                                -- // Handlers \\
      
                                                -- Whitelist Handler
                                                Connections[#Connections + 1] = game.Players.PlayerAdded:Connect(function(Player)
                                                if table.find(Whitelisted, Player.Name) then
                                                   game.Players:Chat("msg Whitelisted player '" .. Player.DisplayName .. "' joined!")
                                                   game.Players:Chat("rewl " .. Player.Name)
                                                   game.Players:Chat(":pm " .. Player.Name .. " You have been whitelisted! Your prefix is '" .. Pref .. "', say '" .. Pref .. "help' for a list of commands!")
                                                else
                                                   return
                                                end
                                                end)
      
                                                -- File/Folder Handler
                                                if not isfolder("Bender") then
                                                   makefolder("Bender")
                                                end
                                                if not isfolder("Bender/Whitelisted") then
                                                   makefolder("Bender/Whitelisted")
                                                end
                                                if not isfolder("Bender/Logs") then
                                                   makefolder("Bender/Logs")
                                                end
                                                if not isfolder("Bender/Configs") then
                                                   makefolder("Bender/Configs")
                                                end
                                                if not isfile("Bender/Status.txt") then
                                                   writefile("Bender/Status.txt", "Bender")
                                                end

                                                -- AFK Handler
                                                UserInputService.WindowFocused:Connect(function()
                                                   game.Players:Chat(":unff me")
                                                   game.Players:Chat(":unname me")
                                                end)
                                                UserInputService.WindowFocusReleased:Connect(function()
                                                   game.Players:Chat(":ff me")
                                                   game.Players:Chat(":name me <away();>\n " .. User)
                                                end)

                                                -- // Functions \\ --
      
                                                function HardFix()
                                                   game.Players:Chat(":fix")
                                                   game.Players:Chat(":clear")
                                                   game.Players:Chat(":refresh all")
                                                   game.Players:Chat(":removetools all")
                                                   game.Players:Chat(":unchar all")
                                                   game.Players:Chat(":music")
                                                   FixMapColors();
                                                end
      
                                                function Regen()
                                                   fireclickdetector(game:GetService("Workspace").Terrain["_Game"].Admin:FindFirstChild("Regen").ClickDetector)
                                                end
      
                                                function GetMatchingPlayerName(input)
                                                   local function GetLongestName()
                                                      local tempGreatest = 0
                                                      for i, v in pairs(game.Players:GetPlayers()) do
                                                         if string.len(v.Name) > tempGreatest then
                                                            tempGreatest = string.len(v.Name)
                                                         end
                                                         if string.len(v.DisplayName) > tempGreatest then
                                                            tempGreatest = string.len(v.DisplayName)
                                                         end
                                                      end
                                                      return tempGreatest
                                                   end
                                                   if string.len(input) ~= 0 then
                                                      if string.len(input) <= GetLongestName() then
                                                         local possibleplayers = {}
                                                         input = string.lower(input)
      
                                                         for i, v in pairs(game.Players:GetPlayers()) do
                                                            local plrname = string.lower(v.Name)
                                                            local displayname = string.lower(v.DisplayName)
      
                                                            if string.find(plrname, input) == 1 or string.find(displayname, input) == 1 then
                                                               table.insert(possibleplayers, v.Name)
                                                            end
                                                         end
      
                                                         if #possibleplayers == 0 then
                                                            return "No player found."
                                                         elseif #possibleplayers == 1 then
                                                            return possibleplayers[1]
                                                         elseif #possibleplayers > 1 then
                                                            return "Multiple players found."
                                                         end
                                                      else
                                                         return "Given input is too long."
                                                      end
                                                   end
                                                end
      
                                                function Admin()
                                                   getgenv().Perm = true
                                                   while Perm == true do
                                                      task.wait()
                                                      if not game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(LP.Name .. "'s admin") then
                                                         if game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild("Touch to get admin") then
                                                            local pad = game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild("Touch to get admin"):FindFirstChild("Head")
                                                            local padCFrame = pad.CFrame
                                                            wait(0.125)
                                                            pad.Transparency = 1
                                                            pad.CanCollide = false
                                                            repeat
                                                               task.wait()
                                                            until LP.Character:FindFirstChild("HumanoidRootPart")
                                                            pad.CFrame = LP.Character.HumanoidRootPart.CFrame
                                                            wait(0.125)
                                                            pad.CFrame = padCFrame
                                                            pad.CanCollide = true
                                                         elseif not game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild("Touch to get admin") then
                                                            Regen()
                                                         end
                                                      end
                                                   end
                                                end
      
                                                function ClearLogs()
                                                   for i = 1, 100 do
                                                      task.wait()
                                                      game.Players:Chat(ChatlogsSpamText)
                                                   end
                                                end
      
                                                function DestroyCommandBar()
                                                   local Gui = game.CoreGui:FindFirstChild("CommandBar")
                                                   if Gui then
                                                      Gui:Destroy()
                                                   end
                                                end
      
                                                function Whitelist(Player)
                                                   table.insert(Whitelisted, GetMatchingPlayerName(Player))
                                                   table.insert(WhitelistCount, 1)
                                                   for _, v in pairs(game.Players:GetPlayers()) do
                                                      if table.find(Whitelisted, v.Name) then
                                                         WhitelistConnection[#WhitelistConnection + 1] = v.Chatted:Connect(function(chat)
                                                         local User = v.Name
                                                         if isfile("Bender/Whitelisted/" .. User .. ".txt") then
                                                            local SavedPrefix = readfile("Whitelisted/" .. User .. ".txt")
                                                            Pref = SavedPrefix
                                                         else
                                                            Pref = Pref
                                                         end
                                                         if string.sub(chat:lower(), 0, 1) == Pref then
                                                            local Command = string.sub(chat, 2)
                                                            game.Players:Chat(Command)
                                                         end
                                                         if string.sub(chat:lower(), 0, 5) == Pref .. "help" then
                                                            game.Players:Chat("pm " .. User .. " A list of commands has been whispered to you via chat!")
      
                                                            local function whisper(user, text)
                                                               local Player = user;
                                                               local Text = text;
                                                               local Rep = game:GetService("ReplicatedStorage");
                                                               Rep.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/w ".. Player .." ".. Text, "All")
                                                            end
                                                            whisper(User, "Too lazy to update this list, sorry! 💀")
                                                         end
                                                         if string.sub(chat:lower(), 0, 7) == Pref .. "prefix" then
                                                            local RequestedPrefix = string.sub(chat, 9)
                                                            if isfile("Bender/Whitelisted/" .. User .. ".txt") then
                                                               delfile("Bender/Whitelisted/" .. User .. ".txt")
                                                            else
                                                            end
                                                            Pref = RequestedPrefix
                                                            writefile("Whitelisted/" .. User .. ".txt", RequestedPrefix)
                                                            game.Players:Chat(":pm " .. User .. " Your prefix has been changed to '" .. Pref .. "'")
                                                         end
                                                         end)
                                                      end
                                                   end
                                                end
      
                                                function Unwhitelist(Player)
                                                   for i, v in pairs(Whitelisted) do
                                                      if Player == v then
                                                         table.remove(Whitelisted, i)
                                                         table.remove(WhitelistCount, 1)
                                                         EndWhitelist()
                                                         break
                                                      end
                                                   end
                                                end
      
                                                function Punish(Player)
                                                   -- Playing Silence Command Sound
                                                   game.Players:Chat(":music 821439273")
                                                   -- Punish Command Code
                                                   game.Players:Chat(":explode " .. Player)
                                                   local Random = math.random(1, 1000)
                                                   game.Players:Chat(":unpunish " .. Player .. " " .. Random)
                                                   game.Players:Chat(":invisible " .. Player .. " " .. Random)
                                                   game.Players:Chat(":refresh " .. Player .. " " .. Random)
                                                   game.Players:Chat(":invisible " .. Player .. " " .. Random)
                                                   game.Players:Chat(":kill " .. Player .. " " .. Random)
                                                   game.Players:Chat(":trip " .. Player .. " " .. Random)
                                                   game.Players:Chat(":setgrav " .. Player .. " -1000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
                                                   task.wait(.1)
                                                   game.Players:Chat(":invisible " .. Player .. " " .. Random)
                                                   task.wait(.2)
                                                   game.Players:Chat(":invisible " .. Player .. " " .. Random)
                                                   task.wait(.2)
                                                   game.Players:Chat(":punish " .. Player .. " " .. Random)
                                                   task.wait()
                                                   for i = 1, 11 do
                                                      game.Players:Chat(":punish " .. Player .. " " .. Random)
                                                   end
                                                   task.wait(4)
                                                   game.Players:Chat(":music 0"); -- If no audio is playing
                                                end
      
      
                                                function CheckForCrash()
                                                   local Ping1 = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(), " "
                                                   task.wait(1)
                                                   local Ping2 = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(), " "
      
                                                   if Ping1 == Ping2 then
                                                      return true
                                                   else
                                                      return false
                                                   end
                                                end
      
                                                function CheckForPerm(Player)
                                                   for _,v in pairs(game.Players:GetChildren()) do
                                                      if v.Name == Player then
                                                         local PermNBC = 66254
                                                         local PermBC =  64354
                                                         local UserID = v.UserId
      
                                                         if string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PermNBC), PermNBC)
                                                         or string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PermBC), PermBC) then
                                                            return true
                                                         else
                                                            return false
                                                         end
                                                         break
                                                      end
                                                   end
                                                end
      
                                                function EndWhitelist()
                                                   for _,Connection in ipairs(WhitelistConnection) do
                                                      Connection:Disconnect()
                                                      break
                                                   end
                                                end
                                                function EndWhitelist()
                                                   for _,Connection in ipairs(WhitelistConnection) do
                                                      Connection:Disconnect()
                                                      break
                                                   end
                                                end
      
                                                function ClearChat()
                                                   task.wait(0.5)
                                                   for i = 1, 7 do
                                                      SendMessage(ChatSpamText)
                                                   end
                                                end
      
                                                function SendMessage(Text)
                                                   game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(Text, "All")
                                                end
      
                                                function SoundCheck()
                                                   local Sound, Error = pcall(function()
                                                   if not game:GetService("Workspace").Terrain["_Game"].Folder.Sound then
                                                      return
                                                   end
                                                   end)
                                                   if not Sound then
                                                      return false
                                                   else
                                                      return true
                                                   end
                                                end
      
                                                function CheckForPersons(Player)
                                                   for _,v in pairs(game.Players:GetChildren()) do
                                                      if v.Name == Player then
                                                         local PersonNBC = 35748
                                                         local PersonBC =  37127
                                                         local UserID = v.UserId
      
                                                         if string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PersonNBC), PersonNBC)
                                                         or string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PersonBC), PersonBC) then
                                                            return true
                                                         else
                                                            return false
                                                         end
                                                         break
                                                      end
                                                   end
                                                end
      
                                                function checkGearBanStatus(req)
                                                   local storedUserCallingPoint = game.Players.LocalPlayer.PlayerGui:FindFirstChild(req);
                                                   if (storedUserCallingPoint) then
                                                      return true;
                                                   else
                                                      return false;
                                                   end
                                                end
      
                                                function Break(plr)
                                                   game.Players:Chat(":freeze " .. plr)
                                                   game.Players:Chat(":rainbowify " .. plr)
                                                   game.Players:Chat(":particle " .. plr .. " c")
                                                   game.Players:Chat(":spin " .. plr)
                                                   for i = 1, 350 do
                                                      game.Players:Chat("dog " .. plr)
                                                   end
                                                   task.wait(0.6)
                                                   game.Players:Chat(":thaw " .. plr)
                                                   game.Players:Chat(":explode " .. plr)
                                                   task.wait(0.25)
                                                   game.Players:Chat(":clone " .. plr)
                                                   return true;
                                                end
                                                function EquipTool()
                                                   for _, Item in pairs(LP.Backpack:GetDescendants()) do
                                                      if Item:IsA "Tool" then
                                                         Item.Parent = LP.Character
                                                         break
                                                      end
                                                   end
                                                end
      
                                                function handleNonAdmins(code) -- Beta Function
                                                   local receivedAction = {}
                                                   for _,v in pairs(game.Players:GetChildren()) do
                                                      if (not table.find(receivedAction, v.Name)) then
                                                         local HasAdminPad = game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(v.Name .. "'s admin")
                                                         local HasPerm = CheckForPerm(v.Name)
                                                         if (not HasAdminPad) then
                                                            if HasPerm == false then
                                                               loadstring(code)()
                                                            elseif (HasAdminPad) and (not HasPerm) then
                                                               --
                                                            end
                                                         elseif (HasAdminPad) and (not HasPerm) then
                                                            --
                                                         end
                                                      end
                                                   end
                                                end
      
                                                function EnableDisableBeta(toggle)
                                                   if (toggle == true) then
                                                      writefile("Bender/Configs/DeveloperBeta.txt", "true")
                                                      if readfile("Bender/Configs/DeveloperBeta.txt", "true") then
                                                         BetaEnabled = true;
                                                         return true
                                                      else
                                                         return false
                                                      end
                                                   end
                                                   if (toggle == false) then
                                                      writefile("Bender/Configs/DeveloperBeta.txt", "false")
                                                      if readfile("Bender/Configs/DeveloperBeta.txt", "false") then
                                                         BetaEnabled = false;
                                                         return true
                                                      else
                                                         return false
                                                      end
                                                   end
                                                   if (not toggle) or (toggle ~= true) or (toggle ~= false) then
                                                      return nil
                                                   end
                                                end
                                                function OSClose()
                                                   for i = 1, 2 do
                                                      local VirtualUser = game:GetService("VirtualUser")
                                                      local Backpack = game.Players.LocalPlayer:FindFirstChildOfClass("Backpack")
                                                      LP = game.Players.LocalPlayer
                                                      local Backpack = game.Players.LocalPlayer:FindFirstChildOfClass("Backpack")
      
                                                      game.Players:Chat("god all")
                                                      LP.Character.HumanoidRootPart.Anchored = true;
                                                      game.Players:Chat("name me")
                                                      game.Players:Chat("thaw me")
                                                      for i = 1, 10 do
                                                         game.Players:Chat("gear me 92628079")
                                                      end
                                                      task.wait(0.7)
                                                      for i,v in pairs(game.Players.LocalPlayer:FindFirstChildOfClass("Backpack"):GetChildren()) do
                                                         if v:IsA("Tool") then
                                                            v.Parent = game.Players.LocalPlayer.Character
                                                      end
      
                                                      repeat task.wait() until LP.Character:FindFirstChildOfClass("Tool")
                                                         for _, v in ipairs(Backpack:GetChildren()) do
                                                            v.Parent = game.Players.LocalPlayer.Character
                                                            v:Activate()
                                                         end
                                                         task.wait(0.45)
                                                         VirtualUser:CaptureController()
                                                         VirtualUser:ClickButton1(Vector2.new())
                                                         task.wait(0.75)
                                                         for i = 1, 20 do
                                                            game.Players:Chat(":unsize me")
                                                         end
                                                      end
                                                   end
                                                end
                                                   function UseTools()
                                                      for _,v in pairs(LP.Backpack:GetChildren()) do
                                                         v.Parent = LP.Character
                                                         v:Activate()
                                                      end
                                                   end
                                                   function getPlayerRootPartPosition(player)
                                                      local character = player.Character
                                                      if character and character:FindFirstChild("HumanoidRootPart") then
                                                         local rootPart = character.HumanoidRootPart
                                                         return rootPart.Position.X, rootPart.Position.Y, rootPart.Position.Z
                                                      end
                                                   end
                                                   function Search:IsPlayerPunished(PlayerName)
                                                      local isPunished
                                                      for _,v in pairs(game:GetService("Lighting"):GetChildren()) do
                                                         if (v.Name == PlayerName) then
                                                            isPunished = true
                                                         else
                                                            isPunished = false
                                                         end
                                                      end
                                                      if (isPunished == true) then
                                                         return true
                                                      else
                                                         return false
                                                      end
                                                end
                                                function Search:FindWorkspaceItem(ItemName)
                                                   local foundItem
                                                   for _,v in pairs(workspace:GetDescendants()) do
                                                      if (v.Name == ItemName) then
                                                         foundItem = true
                                                      end
                                                   end
                                                   if (foundItem == true) then
                                                      return true
                                                   else
                                                      return false
                                                   end
                                                end
                                                function destroyExistingBlinds()
                                                   for _,v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
                                                      if (v.Name == "EFFECTGUIBLIND") and (v.Parent ~= nil) then
                                                         v:Destroy()
                                                         break
                                                      end
                                                   end
                                                end
                                                function handleGearAssignment(gearID, user)
                                                   if GetMatchingPlayerName(user) then
                                                      game.Players:Chat(":gear " .. GetMatchingPlayerName(user) .. " " .. gearID)
                                                   else
                                                      game.Players:Chat(":gear " .. User .. " " .. gearID)
                                                   end
                                                   return true
                                                end
