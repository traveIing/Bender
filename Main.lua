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
-- 🛠️ Configurations
   getgenv().Whitelisted = {} getgenv().ChatlogsSpamText = ":ff" getgenv().AntiCrash = false
   getgenv().AntiRocketEnabled = nil getgenv().AntiKillEnabled = nil getgenv().AntiPunishEnabled = nil

-- ⚙️ Instance Variables
   getgenv().WhitelistCount = {} getgenv().Connections = {}  getgenv().WhitelistConnection = {} getgenv().LockedSound = false getgenv().NetLagRunning = false
   getgenv().Search = {}  getgenv().Bender_StoredMessages = {} getgenv().SentCrashRequest = nil getgenv().Bender_SetFunctions = false
   getgenv().IntelligentMonitoring_AntiCrash = nil getgenv().Bender_InstanceEnabled = nil
   -----------------------------------------------------------------------------------------------------------------------------------------------------

   -- Localizing Instance Variables
   local InKohls, ServerConnected, NBCKohlsID, BCKohlsID, PlaceID, JobID, User, Display, LP, opened_chatlogs, alert_error
   do
      InKohls = true
      NBCKohlsID = 112420803
      BCKohlsID = 115670532
      PlaceID = game.PlaceId
      JobID = game.JobId
      User = game.Players.LocalPlayer.Name
      Display = game.Players.LocalPlayer.DisplayName
      LP = game.Players.LocalPlayer
      opened_chatlogs = false
      alert_error = nil
   end

   -- Game Evaluation
   if (game.PlaceId ~= NBCKohlsID) and (game.PlaceId ~= BCKohlsID) then return end
   InKohls = true
   
   -- Execution Evaluation
   if getgenv().Bender_Executed then warn("ACEXFS") return end
   warn("ACEXPS") getgenv().Bender_Executed = true getgenv().Bender_InstanceEnabled = true
   
   -- Initializing Plugins
   local failed_scripts = {}
   
   local function round_int(int)
      return math.floor(int + 0.5)
   end
   local function load_import(link)
      local success, err pcall(function()
         loadstring(game:HttpGet(link))()
      end)
      if (success ~= true) and (err ~= nil) then
         table.insert(failed_scripts, link)
      end
      return true
   end
   local function import_progress_bar()
      load_import("https://raw.githubusercontent.com/traveIing/bender/main/Progress%20Bar.lua")
      repeat task.wait() until (setProgress ~= nil)
   end
   local function flush_settings()
      pcall(function()
         game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("LoadingBar"):Destroy()
      end)
      getgenv().Bender_Executed = false
      getgenv().Bender_InstanceEnabled = false
      ServerConnected = false
   end
   local function calc_segments(count)
      local segments = {} local whole = 100
      if count > 0 then
         local segment_size = whole / count local value = 0
         for i = 1, count do
            table.insert(segments, round_int(value + segment_size)) value = round_int(value + segment_size)
         end
      end
         return segments
     end

     import_progress_bar() setProgress(0, "Connecting to Bender's servers..")

     local connection_established
     local success, error pcall(function()
      load_import("https://communication-1.joinbender.com/server_connection.lua")
      repeat task.wait() until EstablishServerConnection
      local connected, status = EstablishServerConnection()
      if (connected == true) and (status == nil) then connection_established = true
      else connection_established = false end end)

   if (success ~= true) and (error ~= nil) or (connection_established == false) then
      setProgress(0, "Failed to connect to our servers.") task.wait(1) flush_settings()
   else ServerConnected = true end

   if (ServerConnected == true) then task.wait(0.45)

      local script_plugins = {
         ["Command Bar"] = "https://raw.githubusercontent.com/traveIing/bender/main/Command%20Bar.lua",
         ["Notification System"] = "https://raw.githubusercontent.com/traveIing/bender/main/Notification.lua",
         ["Command Processor"] = "https://raw.githubusercontent.com/traveIing/bender/main/Command%20Handler.lua",
         ["Profile GUI"] = "https://raw.githubusercontent.com/traveIing/bender/main/Profile%20GUI.lua",
         ["Countdown GUI"] = "https://raw.githubusercontent.com/traveIing/bender/main/Countdown.lua",
         ["MapColor API"] = "https://raw.githubusercontent.com/traveIing/bender/main/Map%20Changer.lua",
         ["Outfit API"] = "https://raw.githubusercontent.com/traveIing/bender/main/FetchRandomOutfitAPI.lua",
         ["ServerList GUI"] = "https://raw.githubusercontent.com/traveIing/bender/main/ServerListGUI.lua",
         ["GameLeaveAnimation"] = "https://raw.githubusercontent.com/traveIing/bender/main/GameLeaveAnimation.lua",
         ["Ping Tracker"] = "https://raw.githubusercontent.com/traveIing/bender/main/LivePingTracker.lua",
         ["Player List"] = "https://raw.githubusercontent.com/traveIing/bender/main/PlayerList.lua",
         ["External Functions"] = "https://raw.githubusercontent.com/traveIing/bender/main/Functions.lua"
      }

      local item_count = 0

      for _, _ in pairs(script_plugins) do
          item_count = item_count + 1
      end

      local segments = calc_segments(item_count)
      local index = 0

      for script_name, location in pairs(script_plugins) do
          index = index + 1
          local message = "Loading " .. script_name .. "..."
          local placement = segments[index]
          setProgress(placement, message) load_import(location)
      end
      setProgress(100, "Complete! ☑️")

         -- Failed Plugin Manager
         if (#failed_scripts ~= 0) then
            alert_error = true
            warn("----------------------------------------")
            warn("Failed Plugin Manager\n")
            for _,v in pairs(failed_scripts) do
               pcall(function()
                  local script_name = v:match('/main/(.-)$')
                  warn(" Couldn't run | " .. script_name)
               end)
            end
            warn("\nAny features that utilize these modules will not work.")
            warn("Rejoining will most likely fix this issue. However, if it persists, please join our Discord Server, and report it!")
            warn("discord.gg/hQdNKfDf8X")
            warn("----------------------------------------")
         end

         -- User Greeting Manager
         if (not alert_error == true) then
            if (isfile("Bender/Status.xml")) then
               PlaySound("Intro")
               Notify("Bender", "Welcome back, " .. Display .. "!", 2)
            else
               PlaySound("Intro")
               Notify("Bender", "Hello, " .. Display .. "! Thank you for using Bender V1.3!", 3)
            end
         else
            PlaySound("SetupError")
            Notify("Bender", "Bender ran into some issues during initialization. Please press 'F9', or type '/console' for more information.", 15)
         end
      end

   -- // Startup \\ --

   if (InKohls == true) and (ServerConnected == true) then

      -- New Player Manager --
      if not isfile("Bender/Status.xml") then

         function Callback(text)
            PlaySound("CONFIRM_ACTION")
            if (text == "Yes") then
               Notify("Bender", "Press 'F9', or type '/console' to view a list of commands.", 3)
               print("Commands: https://info.joinbender.com/docs") print("Discord: https://discord.gg/UCvJatDRfp")
            end
         end

         local Bind = Instance.new("BindableFunction")
         Bind.OnInvoke = Callback

         game.StarterGui:SetCore(
         "SendNotification",
         {
            Title = "Bender",
            Text = "Hello, ".. Display .."! Thank you for using Bender. It looks like you're new, so would you like to start with list of commands?\n",
            Button1 = "Yes", Button2 = "No",
            Duration = 50, Callback = Bind
         }
         )
      end

   -- Beta User Manager
   local function is_on_beta()
      local success, contents = pcall(function()
      return readfile("Bender/Configs/DeveloperBeta.xml")
      end)
      return success and (contents == "true")
   end

   local success, error = pcall(function()
      if (is_on_beta() == true) then
         warn("DVBTPS") BetaEnabled = true promptBetaInfo()
      else
         BetaEnabled = false warn("DVBTFS")
      end
   end)

   if (not success) then warn("Error occurred:", error) end

   if (InKohls ~= true) and (ServerConnected == false) then return end
end
   ------------------------------------------

   if (ServerConnected ~= true) then return end

   Connections[#Connections + 1] = LP.Chatted:Connect(processCommand)

     -- // Custom Cmds \\ --

     -- Teleporting Shortcuts --
     addCommand({
         Name = "bring",
         Aliases = {},
         Args = 1,
         Function = function(player_type)
            if (type(player_type) == "string") and (Length(player_type) == 0) then
               SelfBring()
            else
               local player_name = GetMatchingPlayerName(player_type)

               local command_types = {
                  ["all"] = "all", ["everyone"] = "all",
                  ["others"] = "others", ["friends"] = "friends",
                  ["admins"] = "admins", ["random"] = "random"
               }
               local istablevalue
               for type, replacement in pairs(command_types) do
                  if (type == player_type) then
                     game.Players:Chat(":tp " .. replacement .. " me")
                     istablevalue = true
                     break
                  end
               end
               if (not istablevalue == true) then
                  if (player_type == "noadmins") then
                     local no_admin = {}
                     for _, v in pairs(game.Players:GetChildren()) do
                        local HasAdminPad = game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(v.Name .. "'s admin")
                        local HasPerm = CheckForPerm(v.Name)
                        if not HasAdminPad then
                           if (HasPerm == false) then
                              table.insert(no_admin, v.Name)
                           end
                        end
                     end
                     for _, player in pairs(no_admin) do
                        game.Players:Chat(":tp " .. player .. " me")
                     end
                  elseif (CheckPlayerExistence(GetMatchingPlayerName(player_type)) == true) then
                     game.Players:Chat(":tp " .. player_name .. " me")
                  end
               end
            end
         end
      })

     addCommand({
         Name = "to",
         Aliases = {},
         Args = 1,
         Function = function(player_type)
            if (type(player_type) == "string") and (Length(player_type) == 0) then
               SelfBring()
            elseif (player_type == "random") then
               local random_players = {}
               for _, v in pairs(game.Players:GetPlayers()) do
                  table.insert(random_players, v.Name)
               end
               local random_user = random_players[math.random(1, #random_players)]
               if (CheckPlayerExistence(random_user) == true) and (UserHasObject(random_user, "HumanoidRootPart")) then
                  LP.Character.HumanoidRootPart.CFrame = game.Players:FindFirstChild(random_user).Character.HumanoidRootPart.CFrame
               end
            elseif (CheckPlayerExistence(GetMatchingPlayerName(player_type)) == true) then
               local full_username = GetMatchingPlayerName(player_type)
               for _, player in pairs(game.Players:GetChildren()) do
                  if (player.Name == full_username) then
                     LP.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                  end
               end
            end
         end
      })

      -- Protection Shortcuts --
      addCommand({
         Name = "shields",
         Aliases = {},
         Args = 0,
         Function = function()
            game.Players:Chat(":god all")
            game.Players:Chat(":ff all")
         end
      })

      addCommand({
         Name = "rshields",
         Aliases = {},
         Args = 0,
         Function = function()
            game.Players:Chat(":unff all")
            game.Players:Chat(":ungod all")
         end
      })

      -- User Shortcuts --
      addCommand({
         Name = "ref",
         Aliases = {},
         Args = 1,
         Function = function(player_type)
            if (type(player_type) == "string") and (Length(player_type) == 0) then
               game.Players:Chat(":refresh me")
            else
               local player_name = GetMatchingPlayerName(player_type)

               local command_types = {
                  ["all"] = "all", ["everyone"] = "all",
                  ["others"] = "others", ["friends"] = "friends",
                  ["admins"] = "admins", ["random"] = "random"
               }
               local istablevalue
               for type, replacement in pairs(command_types) do
                  if (type == player_type) then
                     game.Players:Chat(":refresh " .. replacement .. " me")
                     istablevalue = true
                     break
                  end
               end
               if (not istablevalue == true) then
                  if (player_type == "noadmins") then
                     CommandOnNonAdmins("refresh", false)
                  else
                     if (CheckPlayerExistence(GetMatchingPlayerName(player_type)) == true) then
                        game.Players:Chat(":refresh " .. player_name)
                     end
                  end
               end
            end
         end
      })

   -- // Map Modifications \\ --

   -- Music Themes --
   addCommand({
      Name = "rock",
      Aliases = {},
      Args = 0,
      Function = function()
         game.Players:Chat(":fogend 1000")
         game.Players:Chat(":fogcolor 500 0 0")
         game.Players:Chat(":time 1")
         game.Players:Chat(":gear all 99119198")
         game.Players:Chat(":music 1843497734")
      end
  })

   -- // Radio \\ --

   addCommand({
      Name = "play",
      Aliases = {},
      Args = 1,
      Function = function(request)
         if (request == "string") and (Length(request) == 0) then
            NotifyError("Bender", "Please specify an audio name.", 1)
         else
            Notify("Bender", "Processing request..", 1)
            local callback = tostring(game:HttpGet("https://search.roblox.com/catalog/json?CatalogContext=2&AssetTypeID=3&PageNumber=1&limit=500&Category=9&SortType=0&keyword=" .. request))
            local audio_id = string.match(callback, "%d+")
            local audio_name
            local audio_invalid
            if (audio_id ~= nil) and (audio_id ~= "[]") then
               audio_name = tostring(game:GetService("MarketplaceService"):GetProductInfo(audio_id).Name)
            else
               task.wait(0.6)
               Notify("Bender", " '" .. request .. "' does not exist!", 1)
               audio_invalid = true
            end
            if (audio_invalid ~= true) then
               game.Players:Chat(":music " .. audio_id)
               game.Players:Chat("msg Now Playing: " .. audio_name)
               Notify("Bender", "☑️", 1)
            end
         end
      end
   })

   addCommand({
      Name = "loop",
      Aliases = {},
      Args = 0,
      Function = function()
         local sound_not_playing
         if (getgenv().Bender_LoopIsLocked == true) then
            return true
         end
         local sound_playing, error = pcall(function()
            if not game:GetService("Workspace").Terrain["_Game"].Folder.Sound then
               return
            end
         end)
         if (not sound_playing) then
            NotifyError("Bender", "Sorry, but a sound needs to be playing.", 1)
            sound_not_playing = true
         end
         if (sound_not_playing ~= true) then
            if (SoundCheck() == true) then
               getgenv().Bender_LoopIsLocked = true
               local SavedSound = tostring(game:GetService("Workspace").Terrain["_Game"].Folder.Sound.SoundId)
               local SoundID = tostring(string.match(SavedSound, "%d+$"))
               getgenv().LockedSound = true
               Notify("Bender", "☑️", 1)
               game.Players:Chat("alert Sound is locked")
               while (getgenv().LockedSound == true) do
                  task.wait()
                  if (SoundCheck() == false) or (game:GetService("Workspace").Terrain["_Game"].Folder.Sound.SoundId ~= SavedSound) or (string.match(SavedSound, "%d+$") == 0) or (game:GetService("Workspace").Terrain["_Game"].Folder.Sound.Playing == false) then
                     pcall(function()
                        game.Players:Chat(":music " .. SoundID)
                        game:GetService("Workspace").Terrain["_Game"].Folder.Sound.Playing = true
                        task.wait(1)
                     end)
                  end
               end
            end
         end
      end
   })

   addCommand({
      Name = "unloop",
      Aliases = {},
      Args = 0,
      Function = function()
         if (getgenv().Bender_LoopIsLocked == true) then
            getgenv().Bender_LoopIsLocked = false
            if (getgenv().Bender_LoopIsLocked == false) then
               Notify("Bender", "☑️", 1)
               game.Players:Chat("alert Sound is unlocked")
            else
               NotifyError("Bender", "An unexpected error occured.", 1)
            end
         else
            NotifyError("Bender", "A song hasn't been locked yet!", 1)
         end
      end
   })

   addCommand({
      Name = "forward",
      Aliases = {},
      Args = 1,
      Function = function(position)
         if (type(position) == "string") and (Length(position) == 0) then
            NotifyError("Bender", "Please specify a position.", 1)
         else
            local sound_not_playing
            local sound_playing, error = pcall(function()
               if (not game:GetService("Workspace").Terrain["_Game"].Folder.Sound) then
                  return
               end
            end)
            if (not sound_playing) then
               NotifyError("Bender", "Sorry, but a sound has to be playing.", 1)
               sound_not_playing = true
            end
            if (sound_not_playing ~= true) then
               local success, err pcall(function()
                  local sound = game:GetService("Workspace").Terrain["_Game"].Folder.Sound
                  game:GetService("Workspace").Terrain["_Game"].Folder.Sound.TimePosition = game:GetService("Workspace").Terrain["_Game"].Folder.Sound.TimePosition + tonumber(Request) -- Variable didn't work
               end)
               if (not success) and (err ~= nil) then
                  NotifyError("Bender", "Oops! This shouldn't have happened. Please try again.", 1)
               else
                  Notify("Bender", "☑️", 1)
               end
            end
         end
      end
   })

   addCommand({
      Name = "reverse",
      Aliases = {},
      Args = 1,
      Function = function(position)
         if (type(position) == "string") and (Length(position) == 0) then
            NotifyError("Bender", "Please specify a position.", 1)
         else
            local sound_not_playing
            local sound_playing, error = pcall(function()
               if (not game:GetService("Workspace").Terrain["_Game"].Folder.Sound) then
                  return
               end
            end)
            if (not sound_playing) then
               NotifyError("Bender", "Sorry, but a sound has to be playing.", 1)
               sound_not_playing = true
            end
            if (sound_not_playing ~= true) then
               local success, err pcall(function()
                  local sound = game:GetService("Workspace").Terrain["_Game"].Folder.Sound
                  game:GetService("Workspace").Terrain["_Game"].Folder.Sound.TimePosition = game:GetService("Workspace").Terrain["_Game"].Folder.Sound.TimePosition - tonumber(Request) -- Variable didn't work
               end)
               if (not success) and (err ~= nil) then
                  NotifyError("Bender", "Oops! This shouldn't have happened. Please try again.", 1)
               else
                  Notify("Bender", "☑️", 1)
               end
            end
         end
      end
   })

   addCommand({
      Name = "pbspeed",
      Aliases = {},
      Args = 1,
      Function = function(speed)
         if (type(speed) == "string") and (Length(speed) == 0) then
            NotifyError("Bender", "Please specify a speed.", 1)
         else
            local sound_not_playing
            local sound_playing, error = pcall(function()
               if (not game:GetService("Workspace").Terrain["_Game"].Folder.Sound) then
                  return
               end
            end)
            if (not sound_playing) then
               NotifyError("Bender", "Sorry, but a sound has to be playing.", 1)
               sound_not_playing = true
            end
            if (sound_not_playing ~= true) then
               local success, err pcall(function()
                  local sound = game:GetService("Workspace").Terrain["_Game"].Folder.Sound
                  game:GetService("Workspace").Terrain["_Game"].Folder.Sound.PlaybackSpeed = tonumber(speed)
               end)
               if (not success) and (err ~= nil) then
                  NotifyError("Bender", "Oops! This shouldn't have happened. Please try again.", 1)
               else
                  Notify("Bender", "☑️", 1)
               end
            end
         end
      end
   })

   addCommand({
      Name = "volume",
      Aliases = {},
      Args = 1,
      Function = function(volume)
         if (type(volume) == "string") and (Length(volume) == 0) then
            NotifyError("Bender", "Please specify a volume level.", 1)
         else
            local sound_not_playing
            local sound_playing, error = pcall(function()
               if (not game:GetService("Workspace").Terrain["_Game"].Folder.Sound) then
                  return
               end
            end)
            if (not sound_playing) then
               NotifyError("Bender", "Sorry, but a sound has to be playing.", 1)
               sound_not_playing = true
            end
            if (sound_not_playing ~= true) then
               local success, err pcall(function()
                  local sound = game:GetService("Workspace").Terrain["_Game"].Folder.Sound
                  Sound.Volume = tonumber(volume)
               end)
               if (not success) and (err ~= nil) then
                  NotifyError("Bender", "Oops! This shouldn't have happened. Please try again.", 1)
               else
                  Notify("Bender", "☑️", 1)
               end
            end
         end
      end
   })

   addCommand({
      Name = "bypassmute",
      Aliases = {},
      Args = 0,
      Function = function()
         local success, err pcall(function()
            local sound = game:GetService("Workspace").Terrain["_Game"].Folder.Sound
            if (sound.Playing == false) then
               sound.Playing = true
            end
         end)
         if (not success) and (err ~= nil) then
            NotifyError("Bender", "Oops! This shouldn't have happened. Please try again", 1)
         else
            Notify("Bender", "☑️", 1)
         end
      end
   })

   -- // Fun Commands \\ --

   addCommand({
      Name = "break",
      Aliases = {},
      Args = 1,
      Function = function(player_type)
         if (type(player_type) == "string") and (Length(player_type) == 0) then
            NotifyError("Bender", "Please specify a username.", 1)
         else
            local player_name = GetMatchingPlayerName(player_type)

            local command_types = {
               ["all"] = "all", ["everyone"] = "all",
               ["others"] = "others", ["friends"] = "friends",
               ["admins"] = "admins"
            }
            local istablevalue
            for type, replacement in pairs(command_types) do
               if (type == player_type) then
                  Break(player_type) Notify("Bender", "☑️", 1)
                  istablevalue = true
                  break
               end
            end

            if (not istablevalue == true) then
               if (CheckPlayerExistence(player_name) == true) then
                  Break(player_name) Notify("Bender", "☑️", 1)
               end
            end
         end
      end
   })

   addCommand({
      Name = "silence",
      Aliases = {},
      Args = 1,
      Function = function(player_type)
         if (type(player_type) == "string") and (Length(player_type) == 0) then
            NotifyError("Bender", "Please specify a user.", 1)
         else
            local player_name = GetMatchingPlayerName(player_type)

            local command_types = {
               ["all"] = "all", ["everyone"] = "all",
               ["others"] = "others", ["friends"] = "friends",
               ["admins"] = "admins"
            }
            local istablevalue
            for type, replacement in pairs(command_types) do
               if (type == player_type) then
                  Punish(player_type) Notify("Bender", "☑️", 1)
                  istablevalue = true
                  break
               end
            end
            if (not istablevalue == true) then
               if (player_type == "noadmins") then
                  local already_ran = {}
                  for _,v in pairs(game.Players:GetChildren()) do
                     if (not table.find(already_ran, v.Name)) then
                        local HasAdminPad = game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(v.Name .. "'s admin")
                        local HasPerm = CheckForPerm(v.Name)
                        if (not HasAdminPad) then
                           if (HasPerm == false) then
                              Punish(player_type) Notify("Bender", "☑️", 1)
                           end
                        end
                     end
                  end
               elseif (CheckPlayerExistence(player_name) == true) then
                  Punish(player_type) Notify("Bender", "☑️", 1)
               end
            end
         end
      end
   })

   addCommand({
      Name = "stealoutfit",
      Aliases = {"stealfit"},
      Args = 1,
      Function = function(request)
         if (not request) then
            NotifyError("Bender", "Please specify a user.", 1)
            return
         end
         local player = GetMatchingPlayerName(request)
         if (CheckPlayerExistence(player) ~= true) then
            NotifyError("Bender", "Sorry, that player doesn't exist.", 1)
            return
         end
         Notify("Bender", "Please wait..", 1)
         local uid = game.Players:FindFirstChild(player).UserId
         local outfitrequest = GetRandomOutfitInfo(uid)
         if (outfitrequest == nil) then
            NotifyError("Bender", "Sorry, but we can't fetch an outfit at the moment.", 1)
         else
            local message = 'Fetched outfit "' .. tostring(outfitrequest) .. '" from ' .. player .. "."
            Notify("Bender", message, 3)
            chatNotify(message, Color3.fromRGB(193, 202, 222))
         end
      end
  })

   -- // Name Bypasses \\ --

   addCommand({
      Name = "mename",
      Aliases = {},
      Args = 1,
      Function = function(command)
         game.Players:Chat(command .. " m")
      end
  })

  addCommand({
      Name = "othername",
      Aliases = {},
      Args = 1,
      Function = function(command)
         game.Players:Chat(command .. " other")
      end
   })

   addCommand({
      Name = "allname",
      Aliases = {},
      Args = 1,
      Function = function(command)
         game.Players:Chat(command .. " al")
      end
   })

   -- // Security \\ --

   addCommand({
      Name = "bypass",
      Aliases = {},
      Args = 0,
      Function = function()
          pcall(function()
            local Old = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
            LP.Character:Destroy()
            task.wait(game.Players.RespawnTime + 0.4)
            LP.Character.HumanoidRootPart.CFrame = Old
            Notify("Bender", "☑️", 1)
         end)
      end
   })

   -- Anti Crash
   addCommand({
      Name = "antic",
      Aliases = {},
      Args = 0,
      Function = function()
         if (getgenv().AntiCrash == true) then
            NotifyError("Bender", "AntiCrash is already enabled.", 1)
            return
         end
         getgenv().AntiCrash = true
         if (getgenv().AntiCrash == true) then
            Notify("Bender", "☑️", 1)
         else
            NotifyError("Bender", "Oops! This shouldn't have happened. Please try again.", 1)
         end
      end
   })

   addCommand({
      Name = "noantic",
      Aliases = {},
      Args = 0,
      Function = function()
         if (getgenv().AntiCrash ~= true) then
            NotifyError("Bender", "AntiCrash has not been enabled.", 1)
            return
         end
         getgenv().AntiCrash = false
         if (getgenv().AntiCrash == false) then
            Notify("Bender", "☑️", 1)
         else
            NotifyError("Bender", "Oops! This shouldn't have happened. Please try again.", 1)
         end
      end
   })

   -- AntiPunish
   addCommand({
      Name = "antipunish",
      Aliases = {},
      Args = 0,
      Function = function()
         local already_enabled
         if (getgenv().AntiPunishEnabled == true) then
            NotifyError("Bender", "AntiPunish is already enabled.", 1)
            already_enabled = true
         end
         if (already_enabled ~= true) then
            getgenv().AntiPunishEnabled = true
            if (getgenv().AntiPunishEnabled == true) then
               Notify("Bender", "☑️", 1)
            else
               NotifyError("Bender", "Oops! This shouldn't have happened. Please try again.", 1)
            end
         end
      end
   })

   addCommand({
      Name = "noantipunish",
      Aliases = {},
      Args = 0,
      Function = function()
         local already_disabled
         if (getgenv().AntiPunishEnabled ~= true) then
            NotifyError("Bender", "AntiPunish has not been enabled.", 1)
            already_disabled = true
         end
         if (already_disabled ~= true) then
            getgenv().AntiPunishEnabled = false
            if (getgenv().AntiPunishEnabled == true) then
               Notify("Bender", "☑️", 1)
            else
               NotifyError("Bender", "Oops! This shouldn't have happened. Please try again.", 1)
            end
         end
      end
   })

   -- AntiKill
   addCommand({
      Name = "antikill",
      Aliases = {},
      Args = 0,
      Function = function()
         local already_enabled
         if (getgenv().AntiKillEnabled == true) then
            NotifyError("Bender", "AntiKill is already enabled!", 1)
            already_enabled = true
         end
         if (already_enabled ~= true) then
            getgenv().AntiKillEnabled = true
            if (getgenv().AntiKillEnabled == true) then
               Notify("Bender", "☑️", 1)
            else
               NotifyError("Bender", "Oops! This shouldn't have happened. Please try again.", 1)
            end
         end
      end
   })

   addCommand({
      Name = "noantikill",
      Aliases = {},
      Args = 0,
      Function = function()
         local already_disabled
         if (getgenv().AntiKillEnabled ~= true) then
            NotifyError("Bender", "AntiKill has not been enabled.", 1)
            already_disabled = true
         end
         if (already_disabled ~= true) then
            getgenv().AntiKillEnabled = false
            if (getgenv().AntiKillEnabled == true) then
               Notify("Bender", "☑️", 1)
            else
               NotifyError("Bender", "Oops! This shouldn't have happened. Please try again.", 1)
            end
         end
      end
   })

   -- AntiRocket
   addCommand({
      Name = "antirocket",
      Aliases = {},
      Args = 0,
      Function = function()
         local already_enabled
         if (getgenv().AntiRocketEnabled == true) then
            NotifyError("Bender", "AntiRocket is already enabled!", 1)
            already_enabled = true
         end
         if (already_enabled ~= true) then
            getgenv().AntiRocketEnabled = true
            if (getgenv().AntiRocketEnabled == true) then
               Notify("Bender", "☑️", 1)
            else
               NotifyError("Bender", "Oops! This shouldn't have happened. Please try again.", 1)
            end
         end
      end
   })

   addCommand({
      Name = "noantirocket",
      Aliases = {},
      Args = 0,
      Function = function()
         local already_disabled
         if (getgenv().AntiRocketEnabled ~= true) then
            NotifyError("Bender", "AntiRocket has not been enabled.", 1)
            already_disabled = true
         end
         if (already_disabled ~= true) then
            getgenv().AntiRocketEnabled = false
            if (getgenv().AntiRocketEnabled == true) then
               Notify("Bender", "☑️", 1)
            else
               NotifyError("Bender", "Oops! This shouldn't have happened. Please try again.", 1)
            end
         end
      end
   })

   -- // Gear Ban \\ --

   addCommand({
      Name = "gearban",
      Aliases = {},
      Args = 1,
      Function = function(request)
         local player_already_banned, player_banned, no_player
         local player = GetMatchingPlayerName(request)
         if (not CheckPlayerExistence(player) == true) then
            NotifyError("Bender", "Sorry, that player doesn't exist.", 1)
            no_player = true
         end

         if (no_player ~= true) then
            if (game.Players.LocalPlayer.PlayerGui:FindFirstChild(GetMatchingPlayerName(request))) then
               NotifyError("Bender", player .. " is already Gear Banned.", 1)
               player_already_banned = true
            end
            if (player_already_banned ~= true) then
               local storedUser = Instance.new("ScreenGui")
               storedUser.Name = GetMatchingPlayerName(request)
               storedUser.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
               storedUser.ResetOnSpawn = false
               if (game.Players.LocalPlayer.PlayerGui:FindFirstChild(storedUser.Name)) then
                  player_banned = true
               end
               if (player_banned == true) then
                  Notify("Bender", "☑️", 1)
                  while (game.Players.LocalPlayer.PlayerGui:FindFirstChild(storedUser.Name)) do
                     task.wait()
                     for _,v in pairs(game.Players:GetChildren()) do
                        if (v.Name == player) then
                           Tool = v.Backpack:FindFirstChildOfClass("Tool")
                           EquippedTool = v.Character:FindFirstChildOfClass("Tool")
                           if (Tool or EquippedTool) then
                              game.Players:Chat(":ungear " .. v.Name .. " " .. math.random(1, 100))
                              break
                           end
                        end
                     end
                     if (not game.Players.LocalPlayer.PlayerGui:FindFirstChild(storedUser.Name)) then
                        break
                     end
                  end
               end
            end
         end
      end
   })

   addCommand({
      Name = "gearunban",
      Aliases = {},
      Args = 1,
      Function = function(request)
         local player = GetMatchingPlayerName(request)
         if (CheckPlayerExistence(player) == true) then
            local callingPoint = game.Players.LocalPlayer.PlayerGui:FindFirstChild(player)
            if (CheckGearBanStatus(player) == true) then
               callingPoint:Destroy()
               local sameCallingPoint = game.Players.LocalPlayer.PlayerGui:FindFirstChild(player)
               if (not sameCallingPoint) then
                  Notify("Bender", "☑️", 1)
               else
                  NotifyError("Bender", "Oops! This shouldn't have happened. Please try again.", 1)
               end
            end
         else
            NotifyError("Bender", "Sorry, this player doesn't exist.", 1)
         end
      end
   })

   -- // Map Related \\ --

   -- Admin Pads
   addCommand({
      Name = "regen",
      Aliases = {"regenerate"},
      Args = 0,
      Function = function()
         Regen()
         Notify("Bender", "☑️", 1)
      end
   })

  addCommand({
      Name = "perm",
      Aliases = {},
      Args = 0,
      Function = function()
         Admin()
         Notify("Bender", "☑️", 1)
      end
   })

   addCommand({
      Name = "unperm",
      Aliases = {},
      Args = 0,
      Function = function()
         Perm = false
         game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild("Touch to get admin"):FindFirstChild("Head").Transparency = 0
         Notify("Bender", "☑️", 1)
      end
   })

   -- Map Objects
   addCommand({
      Name = "nok",
      Aliases = {},
      Args = 0,
      Function = function()
         for _, Bricks in pairs(game:GetService("Workspace").Terrain._Game.Workspace.Obby:GetChildren()) do
            Bricks.CanTouch = false
         end
      end
   })

   addCommand({
      Name = "walls",
      Aliases = {},
      Args = 0,
      Function = function()
         for _, Walls in pairs(game:GetService("Workspace").Terrain._Game.Workspace["Obby Box"]:GetChildren()) do
            Walls.CanCollide = false
         end
      end
   })

   addCommand({
      Name = "wallnok",
      Aliases = {},
      Args = 0,
      Function = function()
         for _, Walls in pairs(game:GetService("Workspace").Terrain._Game.Workspace["Obby Box"]:GetChildren()) do
            Walls.CanCollide = false
            for _, Bricks in pairs(game:GetService("Workspace").Terrain._Game.Workspace.Obby:GetChildren()) do
               Bricks.CanTouch = false
            end
         end
      end
   })

   -- Map Fixes
   addCommand({
      Name = "hardfix",
      Aliases = {"hfix"},
      Args = 0,
      Function = function()
         HardFix()
      end
  })

  addCommand({
      Name = "paintfix",
      Aliases = {},
      Args = 0,
      Function = function()
         FixMapColors()
         task.wait(0.25)
         Notify("Bender", "☑️", 1)
      end
   })

   addCommand({
      Name = "sweep",
      Aliases = {},
      Args = 0,
      Function = function()
         game.Players:Chat("🧹")
         game.Players:Chat(":clean")
         game.Players:Chat(":fix")
         game.Players:Chat(":ungear all")
         game.Players:Chat(":heal all 100")
         game.Players:Chat("unrocket/all")
         Notify("Bender", "☑️", 1)
      end
   })

   -- Client Map Fixes
   addCommand({
      Name = "unvelo",
      Aliases = {},
      Args = 0,
      Function = function()
         local mapFolder = game:GetService("Workspace").Terrain._Game.Workspace
         for _,v in pairs(mapFolder:GetDescendants()) do
            task.spawn(function()
               if v:IsA("Part") then
                  v.Velocity = Vector3.new(0, 0, 0)
               end
            end)
         end
         Notify("Bender", "☑️", 1)
      end
  })

  addCommand({
      Name = "unvoid",
      Aliases = {},
      Args = 0,
      Function = function()
         workspace.FallenPartsDestroyHeight = 0 / 0
         Notify("Bender", "☑️", 1)
      end
   })

   -- // Defensive Commands \\ --

   addCommand({
      Name = "pclose",
      Aliases = {},
      Args = 0,
      Function = function()
         local HasPersons = UserHasPersons()

         if (HasPersons) then
            Notify("Bender", "Attempting to crash..", 1)
            game.Players:Chat(":respawn all")
            for i = 1, 100 do
               task.wait()
               task.spawn(function()
                  game.Players:Chat(":rocket/all, all/all, all/all, all")
                  game.Players:Chat(":clone all")
               end)
            end
            if (CheckForCrash() == true) then
               Notify("Bender", "Server Crashed, Switching Servers..", 1)
               task.wait(0.15)
               ServerHop()
            else
               NotifyError("Bender", "It looks like the server crash was unsuccessful.", 5)
            end
         else
            NotifyError("Bender", "This command requires you to have the Person299 gamepass.", 1)
         end
      end
   })
   
   addCommand({
      Name = "osclose",
      Aliases = {"osc"},
      Args = 0,
      Function = function()
         Notify("Bender", "Attempting to crash...", 1)
         OSClose()
         if (CheckForCrash() == true) then
            Notify("Bender", "Server Crashed, Switching Servers..", 1)
            task.wait(0.25)
            ServerHop()
         else
            NotifyError("Bender", "It looks like the server crash was unsuccessful.", 5)
         end
      end
  })

  addCommand({
     Name = "netlag",
     Aliases = {},
     Args = 1,
     Function = function(Duration)
      if (getgenv().NetLagRunning == true) then
         NotifyError("Bender", "netlag is already running!", 1)
         return
      end
      if (type(Duration) == "string") and (Length(Duration) == 0) then
         NotifyError("Please specify a duration.", 1)
      else
         getgenv().NetLagRunning = true
         local HasAdminPad = game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(LP.Name .. "'s admin")
         local HasPerm = UserHasPerm()
         if (HasAdminPad) or (HasPerm == true) then
            if (Duration) then
               Notify("Bender", "Attempting to lag..", 1)
               task.spawn(function()
                  Countdown(Duration)
               end)
               local stopLag = false
               local finished_coroutine = false
               local lost_admin
               local routine = coroutine.create(function()
                  if (stopLag == true) then
                     coroutine.yield()
                     return
                  end
                  local start_time = os.clock()
                  local end_time = start_time + Duration
                  while (os.clock() < end_time) do
                     task.wait()
                     task.spawn(function()
                        for i = 1, 5 do
                           game.Players:Chat(":gear all 253519495")
                        end
                     end)
                  end
                  finished_coroutine = true
                  lost_admin = false
                  coroutine.yield()
               end)
               coroutine.resume(routine)
               task.spawn(function()
                  while task.wait(0.5) do
                     if (HasAdminPad == true) or (HasPerm == true) then
                        lost_admin = false
                     else
                        lost_admin = true
                        break
                     end
                  end
               end)
               repeat task.wait() until (finished_coroutine == true) or (lost_admin == true)
               if (lost_admin == true) then
                     Notify("Bender", "Lost admin, yielding..", 1)
                  else
                     Notify("Bender", "Attempting to recover the server..", 1)
                     for i = 1, 15 do
                        task.wait(0.5)
                        game.Players:Chat(":setgrav all inf")
                        game.Players:Chat(":ungear all")
                     end
                     Notify("Bender", "Lag Finished! ☑️", 1)
                     getgenv().NetLagRunning = false
                  end
               else
                  NotifyError("Bender", "You must have admin in order to use this command!", 1)
               end
            end
         end
      end
   })

   addCommand({
      Name = "vclose",
      Aliases = {"vgc", "vgclose", "vgcrash"},
      Args = 0,
      Function = function()
         Notify("Bender", "Please wait..", 1)
         local HasAdminPad = game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(LP.Name .. "'s admin")
         local HasPerm = UserHasPerm()
         local HasAdmin = (HasPerm == true) or (HasAdminPad)
         local FinishedCrashAttempt
         if (HasAdmin) then
            Notify("Bender", "Attempting to crash..", 1)
            task.spawn(function()
               if (LP.Backpack:FindFirstChildOfClass("Tool")) then
                  game.Players:Chat(":ungear " .. User)
               end
               game.Players:Chat(":gear me 94794847")
               repeat task.wait() until (LP.Backpack:FindFirstChild("VampireVanquisher"))
               EquipTool()
               task.wait(0.5)
               for i = 1, 25 do
                  game.Players:Chat(":unpaint me")
               end
               FinishedCrashAttempt = true
            end)
            repeat task.wait() until (FinishedCrashAttempt == true)
            task.wait(0.25)
            if (CheckForCrash() == true) then
               Notify("Bender", "Server Crashed, Switching Servers..", 1)
               ServerHop()
            else
               NotifyError("Bender", "It looks like the server crash was unsuccessful.", 5)
            end
         else
            NotifyError("Bender", "You must have admin in order to use this command!", 1)
            return
         end
      end
   })

   -- // Plugins \\ --

   addCommand({
      Name = "infy",
      Aliases = {"iy", "infiniteyield"},
      Args = 0,
      Function = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
      end
  })

  addCommand({
      Name = "rspy",
      Aliases = {},
      Args = 0,
      Function = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
      end
   })

   addCommand({
      Name = "chatlogs",
      Aliases = {},
      Args = 0,
      Function = function()
         if (opened_chatlogs == true) then
            NotifyError("Bender", "Try opening command prompt?", 1)
         else
            Notify("Bender", "Please wait..", 1)
            opened_chatlogs = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/traveIing/bender/main/Chat%20Logs.lua"))()
         end
      end
   })

   addCommand({
      Name = "dex",
      Aliases = {},
      Args = 0,
      Function = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua"))()
      end
   })

   -- // Message Related \\ --

   -- Broadcast Messages
   addCommand({
      Name = "msg",
      Aliases = {},
      Args = 1,
      Function = function(message)
         game.Players:Chat("h \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n " .. message)
      end
   })

   addCommand({
      Name = "alert",
      Aliases = {},
      Args = 1,
      Function = function(message)
         game.Players:Chat("h \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n " .. message)
      end
   })

   -- // Information \\ --

-- Server Information --
addCommand({
   Name = "jobid",
   Aliases = {},
   Args = 0,
   Function = function()
      setclipboard(JobID)
      Notify("Bender", "☑️", 1)
   end
})

addCommand({
   Name = "placeid",
   Aliases = {},
   Args = 0,
   Function = function()
      setclipboard(PlaceID)
      Notify("Bender", "☑️", 1)
   end
})

addCommand({
   Name = "copysound",
   Aliases = {},
   Args = 0,
   Function = function()
      local sound_id
      pcall(function()
         sound_id = game:GetService("Workspace").Terrain["_Game"].Folder.Sound.SoundId
      end)
      if (sound_id ~= nil) then
         setclipboard(tostring(sound_id))
         Notify("Bender", "☑️", 1)
      else
         NotifyError("Bender", "A sound isn't playing right now.", 1)
      end
   end
})

addCommand({
   Name = "ping",
   Aliases = {},
   Args = 0,
   Function = function()
      local ping = Round(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
      Notify("Bender", ping, 1)
   end
})

addCommand({
   Name = "playercount",
   Aliases = {"pcount"},
   Args = 0,
   Function = function()
      Notify("Bender", "Server contains " .. #game.Players:GetPlayers() .. " players.", 1.5)
   end
})

addCommand({
   Name = "crashcheck",
   Aliases = {},
   Args = 0,
   Function = function()
      local crash_status = CheckForCrash()
      if (crash_status == true) then
         Notify("Bender", "Server is crashed.", 1.5)
      else
         Notify("Bender", "Server is not crashed!", 1.5)
      end
   end
})

addCommand({
   Name = "regcheck",
   Aliases = {"rcheck"},
   Args = 0,
   Function = function()
      local Regen = game:GetService("Workspace").Terrain["_Game"].Admin:FindFirstChild("Regen")
      if (Regen) then
         Notify("Bender", "☑️", 1)
      else
         Notify("Bender", "❌", 1)
      end
   end
})

-- Player Information --
addCommand({
   Name = "copyuser",
   Aliases = {},
   Args = 1,
   Function = function(user)
      setclipboard(GetMatchingPlayerName(user))
   end
})

addCommand({
   Name = "copyid",
   Aliases = {},
   Args = 1,
   Function = function(username)
      for _, v in pairs(game.Players:GetPlayers()) do
         if (v.Name == GetMatchingPlayerName(username)) then
            setclipboard(tostring(v.UserId))
         end
      end
   end
})

-- // Utilities \\ --

-- Roblox Utilities

addCommand({
   Name = "watch",
   Aliases = {"view"},
   Args = 1,
   Function = function(request)
      local function set_camera(plr)
         local cam = workspace.CurrentCamera
         cam.CameraSubject = game:GetService("Players"):FindFirstChild(plr).Character.Humanoid
         if (plr ~= LP.Name) then
            Notify("Bender", "Watching " .. plr, 1)
         end
      end
      if (Empty(request)) then
         set_camera(LP.Name)
         return
      end
      if (request == "me") or (request == "myself") then
         if (UserHasObject(LP.Name, "HumanoidRootPart")) then
            set_camera(LP.Name)
         end
      elseif (request == "random") then
         local random_players = {}
         for _, v in pairs(game.Players:GetPlayers()) do
            table.insert(random_players, v.Name)
         end
         local random_user = random_players[math.random(1, #random_players)]
         if (CheckPlayerExistence(random_user) == true) and (UserHasObject(random_user, "HumanoidRootPart")) then
            set_camera(random_user)
         end
      else
         local player = GetMatchingPlayerName(request)
         if (CheckPlayerExistence(player) ~= true) then
            NotifyError("Bender", "Sorry, this player doesn't exist.", 1)
            return
         else
            set_camera(player)
         end
      end
   end
})

addCommand({
   Name = "unwatch",
   Aliases = {"unview"},
   Args = 0,
   Function = function()
      if (UserHasObject(LP.Name, "HumanoidRootPart")) then
         local cam = workspace.CurrentCamera
         cam.CameraSubject = LP.Character.Humanoid
      end
   end
})

addCommand({
   Name = "exit",
   Aliases = {},
   Args = 0,
   Function = function()
      task.wait(0.2)
      HandleGameLeave(true, false)
   end
})

addCommand({
   Name = "rejoin",
   Aliases = {"rj"},
   Args = 0,
   Function = function()
      Rejoin()
   end
})

addCommand({
   Name = "clearlogs",
   Aliases = {"cls"},
   Args = 0,
   Function = function()
      Notify("Bender", "Wiping the logs..", 1)
      ClearLogs()
      Notify("Bender", "☑️", 1)
   end
})

addCommand({
   Name = "friend",
   Aliases = {},
   Args = 1,
   Function = function(player)
      if (not GetMatchingPlayerName(player)) then
         NotifyError("Bender", "Please specify a user you would like to friend.", 1)
      else
         if (CheckPlayerExistence(GetMatchingPlayerName(player)) == true) then
            LP:RequestFriendship(game.Players:FindFirstChild(GetMatchingPlayerName(player)))
            Notify("Bender", "☑️", 1)
         else
            NotifyError("Bender", "Sorry, this player doesn't exist.", 1)
         end
      end
   end
})

addCommand({
   Name = "unfriend",
   Aliases = {},
   Args = 1,
   Function = function(player)
      if not GetMatchingPlayerName(player) then
         NotifyError("Bender", "Please specify a user you would like to unfriend.", 1)
      else
         LP:RevokeFriendship(game.Players:FindFirstChild(GetMatchingPlayerName(player)))
         Notify("Bender", "☑️", 1)
      end
   end
})

-- Game Teleport Utilities
addCommand({
   Name = "serverhop",
   Aliases = {"hop"},
   Args = 0,
   Function = function()
      Notify("Bender", "Switching servers..", 1)
      task.wait(0.5)
      ServerHop()
   end
})

-- Script Utilities

addCommand({
   Name = "prefix",
   Aliases = {"pref"},
   Args = 1,
   Function = function(prefix)
      if (not prefix) then
         NotifyError("Bender", "Please specify a prefix.", 1)
         return
      end
      if (getgenv().Bender_Prefix == prefix) then
         NotifyError("Bender", "You already have this prefix!", 1)
         return
      end
      if (not OnlySymbols(prefix) == true) then
         NotifyError("Bender", "Sorry, alphanumeric prefixes aren't supported.", 10)
         return
      end
      getgenv().Bender_Prefix = prefix
      if (getgenv().Bender_Prefix == prefix) then
         if (Length(prefix) == 0) then
            prefix = false
         end
         PlaySound("PREFIX_CHANGE")
         if (prefix == false) then
            chatNotify("Your prefix has been reset", Color3.new(0, 1, 0))
            warn("Your prefix has been reset")
         else
            chatNotify("Your prefix has been changed to " .. prefix, Color3.new(0, 1, 0))
            warn("Your prefix has been changed to " .. prefix)
         end
      else
         NotifyError("Bender", "Oops! This shouldn't have happened. Please try again.", 1)
      end
   end
})

addCommand({
   Name = "closeinstance",
   Aliases = {"clinstance"},
   Args = 0,
   Function = function()
      pcall(function()
         local Socket = getgenv().Bender_WebSocket
         Socket:Close()
      end)
      for _, connection in ipairs(getgenv().Connections) do
         connection:Disconnect()
      end
      getgenv().Bender_Executed = false
      getgenv().Bender_InstanceEnabled = false
      getgenv().LockedSound = false
      getgenv().Bender_Prefix = nil
      DestroyCommandBar()
      RevertPlayerlist()
      EndWhitelist()
      Notify("Bender", "Instance closed.", 1)
      end
   })

-- API Utilities
addCommand({
   Name = "lookup",
   Aliases = {"audit"},
   Args = 2,
   Function = function(user_type, optional_username)
         if (user_type ~= "user:") then
            local username = GetMatchingPlayerName(user_type)
            if (CheckPlayerExistence(username) == true) then
               Notify("Bender", "Fetching user data...", 1)
               promptProfileGUI(username)
            else
               NotifyError("Bender", "This player doesn't exist.", 1)
            end
         else
            if (type(optional_username) == "string") and (Length(optional_username) == 0) then
               NotifyError("Bender", "Please specify a user you would like to lookup.", 1)
            else
               local username = optional_username
               Notify("Bender", "Fetching user data...", 1)
               local success, err = pcall(function()
                  promptProfileGUI(username)
               end)
               if (not success) and (err == nil) then
                  NotifyError("Bender", "Oops! This shouldn't have happened. Please try again.")
               else
                  Notify("Bender", "☑️", 1)
               end
            end
         end
      end
   })

   addCommand({
      Name = "serverlist",
      Aliases = {"portal"},
      Args = 0,
      Function = function()
         Notify("Bender [BETA]", "Loading ServerList..", 1)
         local portion_1 = "Hi! So, it looks like you found an experimental command. Lucky you!\n\n"
         local portion_2 = "Here's the rundown; if you want to remove this GUI, chat 'noserverlist', and it should disappear.\n\n"
         local portion_3 = "If the serverlist does not show up, do not spam it! Please wait for it to appear."
         local psa = portion_1 .. portion_2 .. portion_3
         SendAlert("ServerList Information", psa)
         LoadServerList(true)
         Notify("Bender [BETA]", "☑️", 1)
      end
   })

   addCommand({
      Name = "noserverlist",
      Aliases = {"noportal"},
      Args = 0,
      Function = function()
         Notify("Bender [BETA]", "☑️", 1)
         LoadServerList(false)
      end
   })

   -- Chat Bars
   addCommand({
      Name = "cmdbar",
      Aliases = {},
      Args = 0,
      Function = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/traveIing/bender/main/Command%20Bar.lua"))()
      end
   })

   addCommand({
      Name = "hidecmdbar",
      Aliases = {},
      Args = 0,
      Function = function()
         DestroyCommandBar()
      end
   })

   -- // Developer Beta \\ --

   -- Enable Beta
   addCommand({
      Name = "beta",
      Aliases = {},
      Args = 1,
      Function = function(config_type)
         if (type(config_type) == "string") and (Length(config_type) == 0) then
            NotifyError("Bender (BETA)", "Please specify a configuration.", 1)
         else
            if (config_type == "true") then
               if (EnableDisableBeta(true) == true) then
                  Notify("Bender (BETA)", "Success!", 1)
                  promptBetaInfo()
                  warn("ENDVBTPS")
               end
            elseif (config_type == "false") then
               if (EnableDisableBeta(false) == true) then
                  Notify("Bender (BETA)", "Disabled!", 1)
                  warn("DSBDVBTPS")
               end
            elseif (config_type ~= "false") and (config_type ~= "true") then
               NotifyError("Bender", "Please enter a valid configuration.", 1)
               warn("ENDVBTFS && DSBDVBTFS")
            end
         end
      end
   })
   
   -- Commands
   addCommand({
      Name = "rlag",
      Aliases = {"rkick", "rocketkick"},
      Args = 1,
      Function = function(request)
         if (BetaEnabled == true) then
            if (type(request) == "string") and (Length(request) == 0) then
               NotifyError("Bender [BETA]", "Please specify a user.", 1)
            else
               local player, formatted_player, has_admin_pad, has_perm, has_admin, has_persons
               do
                  player = GetMatchingPlayerName(request)
                  formatted_player = player .. "/"
                  has_admin_pad = game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(LP.Name .. "'s admin")
                  has_perm = UserHasPerm()
                  has_admin = (has_perm == true) or (has_admin_pad)
                  has_persons = UserHasPersons()
               end
               if (has_persons ~= true) or (has_admin ~= true) then
                  if (has_persons ~= true) then
                     NotifyError("Bender", "This command requires you to have the Person299 gamepass.", 1)
                  elseif (has_admin ~= true) then
                     NotifyError("Bender [BETA]", "You need admin, in order to use this command.", 1)
                  end
               else
                  if (CheckPlayerExistence(player) ~= true) then
                     NotifyError("Bender [BETA]", "This player does not exist.", 1)
                  else
                     Notify("Bender", "Lagging..", 1)
                     game.Players:Chat(":respawn " .. player)
                     game.Players:Chat(":fly " .. player)
                     game.Players:Chat(":blind " .. player)
                     getgenv().AntiRocketEnabled = true
                     task.wait(0.25)
                     for i = 1, 1000 do
                        task.wait()
                        pcall(function()
                           game.Players:Chat("rocket/" .. formatted_player .. formatted_player .. player)
                           game.Players:Chat("rocket/me/me/me")
                           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players:FindFirstChild(player).Character.HumanoidRootPart.CFrame * CFrame.new(0,0,2) * CFrame.Angles(0,math.rad(180),0)
                        end)
                     end
                     Notify("Bender (BETA)", "☑️", 1)
                  end
               end
            end
         end
      end
   })

   addCommand({
      Name = "overridechecks",
      Aliases = {},
      Args = 0,
      Function = function()
         if (BetaEnabled == true) then
            function UserHasPerm()
               return true
            end
            function UserHasPersons()
               return true
            end
            Notify("Bender [BETA]", "☑️", 1)
         end
      end
   })

   addCommand({
      Name = "joinplayer",
      Aliases = {},
      Args = 1,
      Function = function(request)
         if (BetaEnabled == true) then
            if (type(request) == "string") and (Length(request) == 0) then
               NotifyError("Bender (BETA)", "Please specify a username.", 1)
            else
               Notify("Bender (BETA)", "Fetching user data...", 1)
               local infoRequest = HttpRequest({
                  Url = "https://api.joinbender.com/roblox/LookupAPI/userinfo.php?username=" .. request
               })
               local SHUserID
               for i, json in pairs(infoRequest) do
                  if (type(json) == "string") then
                     local ID = json:gsub('.*"id":(.-),.*', '%1')
                     SHUserID = ID
                  end
               end
               if (not SHUserID) then
                  NotifyError("Bender (BETA)", "Couldn't fetch a valid ID from your request.", 1)
                  warn("JSIDFS")
               else
                  Notify("Bender (BETA)", "Attempting to join " .. request .. "...", 1)
                  task.wait(1.5)
                  JoinPlayer(SHUserID)
               end
            end
         end
      end
   })

   -- // Whitelist System \\ --

   addCommand({
      Name = "wl",
      Aliases = {},
      Args = 1,
      Function = function(request)
         if (type(request) == "string") and (Length(request) == 0) then
            Notify("Bender", "Please specify a username.", 1)
         else
            local player = GetMatchingPlayerName(request)
            if (not CheckPlayerExistence(player) == true) then
               NotifyError("Bender", "This player doesn't exist.", 1)
            elseif (table.find(Whitelisted, player)) then
               NotifyError("Bender", "This player is already whitelisted.", 1)
            else
               Whitelist(player)
               Notify("Bender", "Whitelisted " .. player .. "! ⭐", 1)
               game.Players:Chat(":pm " .. player .. " You have been granted to use " .. User .. "'s commands.")
            end
         end
      end
   })

   addCommand({
      Name = "unwl",
      Aliases = {},
      Args = 1,
      Function = function(request)
         if (type(request) == "string") and (Length(request) == 0) then
            Notify("Bender", "Please specify a username.", 1)
         else
            local player = GetMatchingPlayerName(request)
            if (not CheckPlayerExistence(player) == true) then
               NotifyError("Bender", "This player doesn't exist.", 1)
            elseif (not table.find(getgenv().Whitelisted, player)) then
               NotifyError("Bender", ' "' .. player .. '" is not whitelisted.', 1)
            else
               Unwhitelist(player)
               Notify("Bender", "Removed " ..GetMatchingPlayerName(player) .. "'s whitelist.", 1)
               game.Players:Chat(":pm " .. GetMatchingPlayerName(player) .. " Your whitelist has been removed.")
            end
         end
      end
   })

   addCommand({
      Name = "checkwl",
      Aliases = {},
      Args = 1,
      Function = function(request)
         local player = GetMatchingPlayerName(request)
         if (table.find(getgenv().Whitelisted, player)) then
            Notify("Bender", player .. "' is whitelisted! ⭐", 1.5)
         else
            Notify("Bender", "'" .. player .. " is not whitelisted.", 1.5)
         end
      end
   })

      -- // Command Extension \\ --

      Connections[#Connections + 1] = LP.Chatted:Connect(function(msg)
         if (getgenv().Bender_InstanceEnabled == true) then
            local Prefix = getgenv().Bender_Prefix
            
            -- // Spam System
            if (string.sub(msg:lower(), 0, 4 + Length(Prefix)) == Prefix  .. "spam") then
               local Message = string.sub(msg, 6)
               getgenv().Bender_SpamEnabled = true
               while (getgenv().Bender_SpamEnabled == true) do
                  task.wait(.000001)
                  game.Players:Chat(Message)
               end
            end
            if (string.sub(msg:lower(), 0, 6 + Length(Prefix)) == Prefix .. "unspam") then
               getgenv().Bender_SpamEnabled = false
            end
            
            -- // Gear System
            local gear_mappings = {
               ["carpet"] = "225921000",   ["laser"] = "130113146",
               ["bat"] = "55301897",     ["money"] = "16722267",
               ["ironfist"] = "243790334", ["gun"] = "97885508", 
               ["pbucket"] = "18474459", ["potato"] = "25741198",
               ["vg"] = "94794847",      ["taser"] = "82357123",
               ["plane"] = "163348575",    ["ivory"] = "108158379",
               ["skateboard"] = "200237939", ["tictactoe"] = "16924676"
            }
            local keyword, player, gear_id
            pcall(function()
               keyword = string.match(msg:lower(), "%a+")
               player = string.sub(msg, #keyword + 2)
               gear_id = gear_mappings[keyword]
            end)
            if (gear_id) then
               HandleGearAssignment(gear_id, player)
            elseif (keyword == "velokit") then
               local target_player = GetMatchingPlayerName(player) or User
               game.Players:Chat(":gear " .. target_player .. " 119917513")
               game.Players:Chat(":gear " .. target_player .. " 74385399")
               game.Players:Chat(":gear " .. target_player .. " 287426148")
            end

            -- // Color System
            local colors = {
               ["blackout"] = {fogcolor = {0, 0, 0}, fogend = 20, time = 0},
               ["pink"] = {fogcolor = {250, 0, 500}, fogend = 1000, time = 1},
               ["blue"] = {fogcolor = {0, 0, 500}, fogend = 1000, time = 1},
               ["red"] = {fogcolor = {500, 0, 0}, fogend = 1000, time = 1},
               ["purple"] = {fogcolor = {160, 32, 240}, fogend = 1000, time = 1},
               ["green"] = {fogcolor = {0, 500, 0}, fogend = 1000, time = 1},
               ["white"] = {fogend = 10000, notify = true},
               ["yellow"] = {fogcolor = {500, 0, 0}, fogend = 1000, time = 1, notify = true}
            }

            if (colors[string.match(msg:lower(), "%a+")]) then
               local settings = colors[string.match(msg:lower(), "%a+")]
               if (settings.fogcolor) then
                  game.Players:Chat(":fogcolor " .. table.concat(settings.fogcolor, " "))
               end
               if (settings.fogend) then
                  game.Players:Chat(":fogend " .. settings.fogend)
               end
               if (settings.time) then
                  game.Players:Chat(":time " .. settings.time)
               end
               if (settings.notify) then
                  Notify("Bender", "☑️", 1)
               end
            end

            -- // Teleport System
            local map_locations = {
               ["pads"] = {position = Vector3.new(-41, 4, 35)},
               ["finish"] = {position = Vector3.new(-41, 4, 35)},
               ["house"] = {position = Vector3.new(-23, 8, 73)},
               ["roof"] = {position = Vector3.new(-30, 42, 69)}
            }
            pcall(function()
               local location_data = map_locations[string.match(msg:lower(), "%a+")]
               if (location_data.position) then
                  LP.Character.HumanoidRootPart.CFrame = CFrame.new(location_data.position)
               end
            end)

            -- // Whitelist System
            if (string.sub(msg:lower(), 0, 4) == "rewl") then -- This command isn't for player usage
               local request, player, not_whitelisted, action_taken
               do
                  request = string.sub(msg, 6)
                  player = GetMatchingPlayerName(Request)
                  not_whitelisted = {}
                  action_taken = {}
               end
               if (player == "all") then
                  for _, v in pairs(game.Players:GetChildren()) do
                     if (table.find(Whitelisted, v.Name)) then
                        Unwhitelist(v.Name)
                        Whitelist(v.Name)
                        table.insert(action_taken, v.Name)
                        game.Players:Chat(":pm " .. v.Name .. " Welcome back! Your whitelist has been reinstated.")
                     else
                        table.insert(not_whitelisted, v.Name)
                     end
                  end
                  if (#action_taken == 1) then
                     Notify("Bender", "Successfully restarted " .. #action_taken .. " player's whitelist.", 1)
                  elseif (#action_taken == 0) then
                     NotifyError("Bender", "Couldn't find any whitelisted players.", 1)
                  else
                     Notify("Bender", "Successfully restarted " .. #action_taken .. " player's whitelist.", 1)
                  end
               else
                  if (CheckPlayerExistence(player) == true) then
                     Unwhitelist(player)
                     Whitelist(player)
                     Notify("Bender", "Restarted '" .. player .. "'s whitelist.", 1)
                     game.Players:Chat(":pm " .. player .. " Welcome back! Your whitelist has been reinstated.")
                  end
               end
            end
            
            -- // Advanced Utilities
            if string.sub(msg:lower(), 0, 3) == "run" then
               local code = string.sub(msg, 5)
               local Function, code_error = loadstring("return function() " .. code .. " end")
               if (not Function) then
                  warn(code_error)
                  return
               end
               local success, errorReason = pcall(Function())
               if (not success) then
                  warn(errorReason)
               end
            end
            
            -- // Uncategorized Commands
            if (string.sub(msg:lower(), 0, #msg) == "!cancel") then
               if (getgenv().IntelligentMonitoring_AntiCrash == true) then
                  getgenv().IntelligentMonitoring_AntiCrash = false
                  game.Players:Chat(":respawn all")
               end
            end
         end
      end)

   -- // Handlers \\ --

   -- Whitelist Handler
   Connections[#Connections + 1] = game.Players.PlayerAdded:Connect(function(Player)
      if (table.find(Whitelisted, Player.Name)) then
         game.Players:Chat("msg Whitelisted player '" .. Player.DisplayName .. "' joined!")
         game.Players:Chat("rewl " .. Player.Name)
         game.Players:Chat(":pm " .. Player.Name .. " Welcome back! Your whitelist has been reinstated.")
      end
   end)

   -- File/Folder Handler
   if (not isfolder("Bender")) then
      makefolder("Bender")
   end
   if (not isfolder("Bender/Whitelisted")) then
      makefolder("Bender/Whitelisted")
   end
   if (not isfolder("Bender/Logs")) then
      makefolder("Bender/Logs")
   end
   if (not isfolder("Bender/Configs")) then
      makefolder("Bender/Configs")
   end
   if (not isfolder("Bender/Logs/IntelligentMonitoring")) then
      makefolder("Bender/Logs/IntelligentMonitoring")
   end
   if (not isfolder("Bender/Logs/IntelligentMonitoring/MessageDataAfterCrash")) then
      makefolder("Bender/Logs/IntelligentMonitoring/MessageDataAfterCrash")
   end
   if (not isfile("Bender/Status.xml")) then
      writefile("Bender/Status.xml", "Bender")
   end

   -- AntiKill Handler
   task.spawn(function()
      while (task.wait()) do
         pcall(function()
            if (LP.Character.Humanoid.Health == 0) and (getgenv().AntiKillEnabled == true) then
               task.wait(.001)
               game.Players:Chat(":reset me")
            end
         end)
      end
   end)

   -- AntiPunish Handler
   game:GetService("Lighting").ChildAdded:Connect(function(child)
      repeat task.wait() until (child)
      if (child.Name == LP.Name) and (getgenv().AntiPunishEnabled == true) then
         task.wait(0.001)
         game.Players:Chat(":unpunish me")
      end
   end)

   -- AntiRocket Handler
   workspace.DescendantAdded:Connect(function(Descendant)
      if (Descendant.Name == "Rocket") and (getgenv().AntiRocketEnabled == true) then
         repeat task.wait(.000001) until (Descendant.Parent)
         Descendant.CanCollide = false
         Descendant.CanTouch = false
      end
   end)

   -- Crashed Server Handler

      -- Intelligent Monitoring --
      task.spawn(function()
         repeat task.wait() until getgenv().Bender_SetFunctions == true
         Connections[#Connections + 1] = game.Players.PlayerAdded:Connect(function(Player)
            local data_address = "Bender/Logs/IntelligentMonitoring/MessageDataAfterCrash/" .. Player.Name .. ".json"
            if isfile(data_address) then
                  local JSON = readfile(data_address) local decoded
                  local success, error = pcall(function() decoded = game:GetService("HttpService"):JSONDecode(JSON) end)
                  if (success == true) and (error == nil) then
                     local stored_messages = {} local similar_messages = 0
                        for _, message_data in pairs(decoded) do
                           if (type(message_data) == "table") then
                              for _, message in pairs(message_data) do
                                 pcall(function()
                                    table.insert(stored_messages, message)
                                    if (table.find(stored_messages, message)) then
                                       similar_messages = similar_messages + 1
                                    end
                                 end)
                              end
                           end
                        end
                        task.wait(0.5)
                        local function exceeds_limit(int)
                           return int > 4
                        end
                        if (similar_messages == 3) then
                           SendCoreNotification(
                              "IntelligentMonitoring",
                              Player.Name .. " may have previously crashed your server. They have been recorded, and will be punished on their next infraction.\n\n",
                              9e9 + 9e9
                           )
                        end
                        if exceeds_limit(similar_messages) then
                           getgenv().IntelligentMonitoring_AntiCrash = true
                           SendCoreNotification(
                              "IntelligentMonitoring",
                              "We have detected " .. Player.Name .. " to be an AutoCrasher, so we are currently protecting the server. To disable this, say '!cancel'.\n\n",
                              9e9 + 9e9
                           )
                        end
                     else
                        warn("It looks like something went wrong with your configuration folder.")
                        warn("Please report this to our Discord server!") warn("discord.gg/hQdNKfDf8X")
                     end
                  end
               end)
            end)

      task.spawn(function()
         local finished_analysis
         while task.wait() do
            if (CheckForCrash() == true) and (not finished_analysis == true) then
               local stored_messages = getgenv().Bender_StoredMessages
               for _, player in pairs(game.Players:GetPlayers()) do
                  if (player ~= LP) then
                     local last_messages = {} local count = 0
                     for i = #stored_messages, 1, -1 do
                        if (stored_messages[i].username == player.Name) then
                           table.insert(last_messages, stored_messages[i].message)
                           count = count + 1
                           if (count == 5) then
                              break
                           end
                        end
                     end
                     local ordered_message_data = {}
                     for i = #last_messages, 1, -1 do
                        table.insert(ordered_message_data, last_messages[i])
                     end
                     pcall(function()
                        local already_stored = {}
                        for i = 1, #ordered_message_data do
                           local message = ordered_message_data[i]
                           if (not table.find(message, already_stored)) then
                              local formatted_message_data = {message = message}
                              table.insert(ordered_message_data, formatted_message_data)
                              table.insert(already_stored, message)
                           end
                        end
                     end)
                     if (#ordered_message_data > 0) then
                        local data_address = "Bender/Logs/IntelligentMonitoring/MessageDataAfterCrash/" .. player.Name .. ".json"
                        local serialized_message_data = game:GetService("HttpService"):JSONEncode(ordered_message_data)
                        if (not isfile(data_address)) then
                           writefile(data_address, serialized_message_data)
                        else
                           local saved_data
                           local success, err = pcall(function() saved_data = readfile(data_address) end)
                           if (success == true) and (err == nil) then
                              local decoded_data
                              local data_decoded, error = pcall(function() decoded_data = game:GetService("HttpService"):JSONDecode(saved_data) end)
                              if (data_decoded == true) and (error == nil) then
                                 local formatted_data = {}
                                 for _, message in pairs(decoded_data) do
                                    pcall(function()
                                       local dataset = {message = message}
                                       table.insert(formatted_data, dataset)                  
                                    end)
                                 end
                                 for _, message in pairs(ordered_message_data) do
                                    pcall(function()
                                       local dataset = {message = message}
                                       table.insert(formatted_data, dataset)
                                    end)
                                 end
                                 if (#formatted_data > 0) then
                                    local updated_data
                                    local data_updated, unexpected = pcall(function() updated_data = game:GetService("HttpService"):JSONEncode(formatted_data) end)
                                    if (data_updated == true) and (unexpected == nil) then
                                       writefile(data_address, updated_data)
                                    else
                                       warn("An unexpected error occured while compiling crash data. This should NEVER happen, so please report it!")
                                       warn("discord.gg/hQdNKfDf8X")
                                    end
                                 end
                              end
                           else
                              writefile(data_address, serialized_message_data)
                           end
                        end
                     end
                  end
               end
               finished_analysis = true
            end
         end
      end)

      -- Crash Detection --
      task.spawn(function()
         while task.wait() do
            local function crash_callback(text)
               PlaySound("CONFIRM_ACTION")
               if (text == "Switch") then
                  Notify("Bender", "Switching servers..", 1)
                  HandleGameLeave(true, true)
               else
                  task.wait(0.9)
                  HandleGameLeave(true, false)
               end
            end
            if (CheckForCrash() == true) and (not getgenv().SentCrashRequest == true) then
               getgenv().SentCrashRequest = true
               PlaySound("CrashDetected")
               local bind = Instance.new("BindableFunction")
               bind.OnInvoke = crash_callback
               game.StarterGui:SetCore("SendNotification", {
                  Title = "Bender",
                  Text = "It looks like your server just crashed. What would you like to do?",
                  Button1 = "Switch",
                  Button2 = "Leave Game",
                  Duration = 9e9 + 9e9,
                  Callback = bind
               })
               task.wait(1)
               SendCoreNotification(
                  "IntelligentMonitoring",
                  "Hey, quick survey. Can you chat the username of the player, who you believe to be responsible for this server crash?\n",
                  9e9 + 9e9,
                  "Thank you!"
               )
               local message = LP.Chatted:Wait()
               local player = GetMatchingPlayerName(message)
               if (CheckPlayerExistence(player) == true) then
                  local player_object, uid, uname, date, guid, title, old_messages_json, data
                  do
                     player_object = game.Players:FindFirstChild(player) uid = player_object.UserId
                     uname = player date = GetTimestamp() guid = GetGUID()
                     title = uid .. "-REPORTEDCRASHER+" .. guid .. ".txt"
                     old_messages_json = GetRecentMessageData(uname)
                     data = "ReportDate:" .. date .. "-Username:" .. uname .. "-UserID:" .. uid .. "Recent-Messages:" .. old_messages_json
                  end
                  CacheData(title, data)
                  Notify("IntelligentMonitoring", "Awesome, that's all we needed to know. Thank you for participating! ⭐", 4)
                  warn("Survey successful")
               else
                  NotifyError("IntelligentMonitoring", "Sorry, we couldn't find that player in your server. This survey has been concluded.", 2)
                  warn("Survey concluded")
               end
            end
         end
      end)

      -- AntiCrash Handler

      -- IntelligentMonitoring AntiCrash --
      task.spawn(function()
         while task.wait() do
            if (getgenv().IntelligentMonitoring_AntiCrash == true) then
               game.Players:Chat(":setgrav all inf")
               game.Players:Chat(":ungear all")
            end
         end
      end)

      -- General AntiCrash --
      task.spawn(function()
         local crash_data = {}
         local function findGear(player, gearNames)
            for _, gearName in pairs(gearNames) do
               if player.Backpack:FindFirstChild(gearName) or player.Character:FindFirstChild(gearName) then
                  return true
               end
            end
            return false
         end
         local function punishPlayer(player)
            game.Players:Chat(":ungear all")
            game.Players:Chat(":setgrav " .. player.Name .. " inf")
         end
         Connections[#Connections + 1] = game:GetService("RunService").RenderStepped:Connect(function()
            if (getgenv().AntiCrash == true) then
               pcall(function()
                  for _, player in pairs(game.Players:GetPlayers()) do
                     if (player.Name ~= User) then
                        local attacker_data = crash_data[player.Name] or { attempts = 0, last_attempt = tick() }
                        local current_time = tick()
                        local blacklisted_gear_names = {"VampireVanquisher", "OrinthianSwordAndShield", "DriveBloxUltimateCar"}
                        if (findGear(player, blacklisted_gear_names)) then
                           punishPlayer(player)
                           attacker_data.attempts = attacker_data.attempts + 1
                           attacker_data.last_attempt = current_time
                           crash_data[player.Name] = attacker_data
                        end
                        if (attacker_data.attempts >= 100) then
                           for i = 1, 55 do
                              game.Players:Chat(":setgrav all inf")
                           end
                           attacker_data.attempts = 0
                           crash_data[player.Name] = attacker_data
                           break
                        end
                     end
                  end
               end)
            end
         end)
      end)

      -- Client/Server Ping Handler
      task.spawn(function()
         if (getgenv().Bender_WebSocket ~= nil) then
            task.wait(2.5)
            local Socket = getgenv().Bender_WebSocket
            while task.wait(1) do
               pcall(function()
                  Socket:Send("ENSURE-CONNECTION")
               end)
            end
         end
      end)

      -- Cache Handler
      task.spawn(function()
         repeat task.wait() until (getgenv().Bender_SetFunctions == true) and (getgenv().Bender_WebSocket ~= nil)
         task.wait(2.5)
         local gamepass_uncached = (GetCacheData(LP.UserId .. "-PERM") == "FILE_NOT_FOUND") and (GetCacheData(LP.UserId .. "-PERSON299") == "FILE_NOT_FOUND")
         if (gamepass_uncached == true) and (gamepass_uncached ~= false) then
            pcall(function()
               local cache_status = "Bender/Configs/GamePassesCached.xml"
               if (isfile(cache_status)) then
                  delfile(cache_status)
               end
            end)
         end
         if (not isfile("Bender/Configs/GamepassesCached.xml")) then
            local gamepass_owner
            if (CheckForPerm(LP.Name) == true) then
               CacheData(LP.UserId .. "-PERM", "HAS_PERM")
               gamepass_owner = true
            elseif (CheckForPerm(LP.Name) == false) then
               CacheData(LP.UserId .. "-PERM", "NO_PERM")
               gamepass_owner = true
            end
            if (CheckForPersons(LP.Name) == true) then
               CacheData(LP.UserId .. "-PERSON299", "HAS_PERSON299")
               gamepass_owner = true
            elseif (CheckForPersons(LP.Name) == false) then
               CacheData(LP.UserId .. "-PERSON299", "NO_PERSON299")
               gamepass_owner = true
            end
            if (gamepass_owner == true) then
               local date = GetTimestamp()
               local cached_file_message = "Your GamePasses were cached by Bender on " .. date .. ".\nFeel free to delete this file if you would like to update any GamePass changes to our servers."
               writefile("Bender/Configs/GamePassesCached.xml", cached_file_message)
            end
         end
      end)

      -- User Command Log Handler
      task.spawn(function()
         repeat task.wait() until (getgenv().Bender_SetFunctions == true)
         local connected_players = {}
         local function store_message_data(username, message)
            pcall(function()
               local storage_format = { username = username, message = message}
               table.insert(getgenv().Bender_StoredMessages, storage_format)
               return true
            end)
         end
         for _,v in pairs(game.Players:GetPlayers()) do
            table.insert(connected_players, v.Name)
            v.Chatted:Connect(function(msg)
               if (Length(msg) > 25) then
                  store_message_data(v.Name, msg)
               end
            end)
         end
         Connections[#Connections + 1] = game.Players.PlayerAdded:Connect(function(newPlayer)
            if (not table.find(connected_players, newPlayer)) then
               table.insert(connected_players, newPlayer.Name)
               newPlayer.Chatted:Connect(function(msg)
                  if (Length(msg) > 25) then
                     store_message_data(newPlayer.Name, msg)
                  end
               end)
            end
         end)
      end)

      -- // Functions \\ --

      function HardFix()
         game.Players:Chat(":fix")
         game.Players:Chat(":clear")
         game.Players:Chat(":refresh all")
         game.Players:Chat(":removetools all")
         game.Players:Chat(":unchar all")
         game.Players:Chat(":music")
         FixMapColors()
      end

      function Regen()
         fireclickdetector(game:GetService("Workspace").Terrain["_Game"].Admin:FindFirstChild("Regen").ClickDetector)
      end

      function GetMatchingPlayerName(input)
         local function GetLongestName()
            local tempGreatest = 0
            for i, v in pairs(game.Players:GetPlayers()) do
               if (string.len(v.Name) > tempGreatest) then
                  tempGreatest = string.len(v.Name)
               end
               if (string.len(v.DisplayName) > tempGreatest) then
                  tempGreatest = string.len(v.DisplayName)
               end
            end
            return tempGreatest
         end
         if string.len(input) ~= 0 then
            if (string.len(input) <= GetLongestName()) then
               local possibleplayers = {}
               input = string.lower(input)

               for i, v in pairs(game.Players:GetPlayers()) do
                  local plrname = string.lower(v.Name)
                  local displayname = string.lower(v.DisplayName)

                  if (string.find(plrname, input) == 1) or (string.find(displayname, input) == 1) then
                     table.insert(possibleplayers, v.Name)
                  end
               end

               if (#possibleplayers == 0) then
                  return "No player found."
               elseif (#possibleplayers == 1) then
                  return possibleplayers[1]
               elseif (#possibleplayers > 1) then
                  return "Multiple players found."
               end
            else
               return "Given input is too long."
            end
         end
      end

      function Admin()
         getgenv().Perm = true
         while (Perm == true) do
            task.wait()
            if (not game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(LP.Name .. "'s admin")) then
               if (game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild("Touch to get admin")) then
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
               elseif (not game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild("Touch to get admin")) then
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
         local Gui = LP.PlayerGui:FindFirstChild("CommandBar")
         if Gui then
            Gui:Destroy()
         end
      end

      function Whitelist(Player)
         table.insert(Whitelisted, GetMatchingPlayerName(Player))
         table.insert(WhitelistCount, 1)
         for _, v in pairs(game.Players:GetPlayers()) do
            if (table.find(Whitelisted, v.Name)) then
               local Prefix
               WhitelistConnection[#WhitelistConnection + 1] = v.Chatted:Connect(function(chat)
                  local User = v.Name
                  if (isfile("Bender/Whitelisted/" .. User .. ".xml")) then
                     local SavedPrefix = readfile("Whitelisted/" .. User .. ".xml")
                     Prefix = SavedPrefix
                  else
                     Prefix = "!"
                  end
                  if (string.sub(chat:lower(), 0, 1) == Pref) then
                     local Command = string.sub(chat, 2)
                     game.Players:Chat(Command)
                  end
                  
                  if (string.sub(chat:lower(), 0, 7) == Pref .. "prefix") then
                     local RequestedPrefix = string.sub(chat, 9)
                     if (isfile("Bender/Whitelisted/" .. User .. ".xml")) then
                        delfile("Bender/Whitelisted/" .. User .. ".xml")
                     end
                     Pref = RequestedPrefix
                     writefile("Whitelisted/" .. User .. ".xml", RequestedPrefix)
                     game.Players:Chat(":pm " .. User .. " Your prefix has been changed to '" .. Pref .. "'")
                  end
               end)
            end
         end
      end

      function Unwhitelist(Player)
         for i, v in pairs(Whitelisted) do
            if (Player == v) then
               table.remove(Whitelisted, i)
               table.remove(WhitelistCount, 1)
               EndWhitelist()
               break
            end
         end
      end

      function Punish(Player)
         game.Players:Chat(":music 821439273")
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
         game.Players:Chat(":music 0")
      end

      function CheckForCrash()
         local Ping1 = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
         task.wait(3.2)
         local Ping2 = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
         if (Ping1 == Ping2) then
            return true
         else
            return false
         end
      end

      function UserHasPerm()
         if (GetCacheData(LP.UserId .. "-PERM") == "FILE_NOT_FOUND") then
            for _,v in pairs(game.Players:GetChildren()) do
               if (v.Name == LP.Name) then
                  local PermNBC = 66254
                  local PermBC = 64354
                  local UserID = v.UserId
                  if string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PermNBC), PermNBC)
                  or string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PermBC), PermBC) then
                     CacheData(LP.UserId .. "-PERM", "HAS_PERM")
                     return true
                  else
                     CacheData(LP.UserId .. "-PERM", "NO_PERM")
                     return false
                  end
                  break
               end
            end
         else
            return true
         end
      end
      function UserHasPersons()
         if (GetCacheData(LP.UserId .. "-PERSON299") == "FILE_NOT_FOUND") then
            for _,v in pairs(game.Players:GetChildren()) do
               if (v.Name == LP.Name) then
                  local PersonNBC = 35748
                  local PersonBC =  37127
                  local UserID = v.UserId
                  if string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PersonNBC), PersonNBC)
                  or string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PersonBC), PersonBC) then
                     CacheData(LP.UserId .. "-PERSON299", "HAS_PERSON299")
                     return true
                  else
                     CacheData(LP.UserId .. "-PERSON299", "NO_PERSON299")
                     return false
                  end
                  break
               end
            end
         else
            return true
         end
      end
      
      function CheckForPerm(Player)
         for _,v in pairs(game.Players:GetChildren()) do
            if (v.Name == Player) then
               local PermNBC = 66254
               local PermBC =  64354
               local UserID = v.UserId
               if string.match(game:HttpGet("https://inventory.roproxy.com/v1/users/" .. UserID .. "/items/GamePass/" .. PermNBC), PermNBC)
               or string.match(game:HttpGet("https://inventory.roproxy.com/v1/users/" .. UserID .. "/items/GamePass/" .. PermBC), PermBC) then
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

      function SendMessage(Text)
         game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(Text, "All")
      end

      function SoundCheck()
         local Sound, Error = pcall(function()
            if (not game:GetService("Workspace").Terrain["_Game"].Folder.Sound) then
               return
            end
         end)
         if (not Sound) then
            return false
         else
            return true
         end
      end

      function CheckForPersons(Player)
         for _,v in pairs(game.Players:GetChildren()) do
               if (v.Name == Player) then
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

      function CheckGearBanStatus(req)
         local storedUserCallingPoint = game.Players.LocalPlayer.PlayerGui:FindFirstChild(req)
         if (storedUserCallingPoint) then
            return true
         else
            return false
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
         return true
      end

      function EquipTool()
         for _, Item in pairs(LP.Backpack:GetDescendants()) do
            if Item:IsA "Tool" then
               Item.Parent = LP.Character
               break
            end
         end
      end

      function CommandOnNonAdmins(command, space_already_added)
         local receivedAction = {}
         for _,v in pairs(game.Players:GetChildren()) do
            if (not table.find(receivedAction, v.Name)) then
               local HasAdminPad = game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild(v.Name .. "'s admin")
               local HasPerm = CheckForPerm(v.Name)
               if (not HasAdminPad) then
                  if (HasPerm == false) then
                     if (space_already_added == true) then
                        game.Players:Chat(command .. v.Name)
                     else
                        game.Players:Chat(command .. " " .. v.Name)
                     end
                     table.insert(receivedAction, v.Name)
                  end
               end
            end
         end
      end

      function EnableDisableBeta(toggle)
         if (toggle == true) then
            writefile("Bender/Configs/DeveloperBeta.xml", "true")
            if (readfile("Bender/Configs/DeveloperBeta.xml", "true")) then
               BetaEnabled = true
               return true
            else
               return false
            end
         end
         if (toggle == false) then
            writefile("Bender/Configs/DeveloperBeta.xml", "false")
            if readfile("Bender/Configs/DeveloperBeta.xml", "false") then
               BetaEnabled = false
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
            LP.Character.HumanoidRootPart.Anchored = true
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

      function HandleGearAssignment(gearID, user)
         if GetMatchingPlayerName(user) then
            game.Players:Chat(":gear " .. GetMatchingPlayerName(user) .. " " .. gearID)
         else
            game.Players:Chat(":gear " .. User .. " " .. gearID)
         end
         return true
      end

      function CheckPlayerExistence(Player)
         local player_exists
         for _,v in pairs(game.Players:GetPlayers()) do
            if (v.Name == Player) then                                    
               player_exists = true                          
            end
         end
         if (player_exists == true) then
            return true
         else
            return false
         end
      end

      function UserHasObject(Player, Object)
         local player_exists
         local player_has_object
         for _,player in pairs(game.Players:GetPlayers()) do
            if (player.Name == Player) then
               player_exists = true
               for _,object in pairs(workspace:GetDescendants()) do
                  if (object.Name == Object) and (object.Parent.Name == player.Name) then
                     player_has_object = true
                  end
               end
            end
         end
         if (not player_exists == true) then
            return nil
         end
         if (not player_has_object == true) then
            return false
         end
         if (player_has_object == true) and (player_exists) then
            return true
         end
      end

      function HandleGameLeave(effectOptional, is_server_hopping)
         if (effectOptional == true) then
            PlaySound("LEAVING_GAME")
            PlayLeavingAnimation(nil)
            task.wait(1.8)
         end
         if (is_server_hopping == true) then
            ServerHop()
         else
            game:Shutdown()
         end
      end

      function CapitalizeString(string)
         if (string == "") then
               return nil
         end
         local firstChar = string:sub(1, 1):upper()
         local restOfString = string:sub(2)
         return firstChar .. restOfString
      end

      function Length(string)
         return string.len(string)
      end

      function SelfBring()
         game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, math.pi, 0))
      end

      function CacheData(filename, filecontents)
         local request_id = GetGUID()
         local socket = getgenv().Bender_WebSocket
         local callback
         socket:Send(request_id .. "|" .. filename .. "|" .. filecontents)
         while task.wait(.00001) do
            local receivedMessage = getgenv().Bender_ReceivedWebSocketMessage
            local received_request_id
            pcall(function()
               received_request_id = receivedMessage:match("([^|]+)")
            end)
            if (received_request_id == request_id) then
               callback = true
               break
            end
         end
         if (callback == true) then
            return true
         else
            return false
         end
      end
      function GetCacheData(filename)
         local request_id = GetGUID()
         local socket = getgenv().Bender_WebSocket
         local callback
         local cache_data

         socket:Send(request_id .. "|" .. filename)

         while task.wait(.00001) do
            local receivedMessage = getgenv().Bender_ReceivedWebSocketMessage
            local received_request_id, data
            pcall(function()
               received_request_id, data = receivedMessage:match("([^|]+)|(.+)")
            end)

            if (received_request_id == request_id) and data then
               callback = true
               cache_data = data
               break
            end
         end

         if (callback == true) then
            return cache_data
         else
            return false
         end
      end
      function Empty(str)
         if (type(str) == "string") and (Length(str) == 0) then
            return true
         else
            return false
         end
      end
      function OnlySymbols(str)
         local pattern = "[%w%d]"
         if not string.find(str, pattern) then
             return true
         else
             return false
         end
     end
     function SendCoreNotification(title, text, duration, type)
      local function setType(input)
         if (input ~= nil) then
            return input
         elseif (input == false) then
            return false
         elseif (input == nil) then
            return "OK"
         end
      end
      game.StarterGui:SetCore("SendNotification", {
         Title = title,
         Text = text,
         Button1 = setType(type),
         Duration = duration
      })
      end
      function GetTimestamp()
         local local_time = DateTime.now():ToLocalTime() 
         local timestamp = local_time.Hour .. ":" .. local_time.Minute
         local date = os.date("%x") .. "-" .. timestamp
         return date
      end
      function GetRecentMessageData(req)
         local function SpaceToString(input)
            local resultString = string.gsub(input, " ", "<>")
            return resultString
        end
         local stored_message_data = ""
         local stored_messages = getgenv().Bender_StoredMessages
         for _, plr in pairs(game.Players:GetPlayers()) do
            if (plr.Name == req) then
               local last_messages = {}
               local count = 0
               for i = #stored_messages, 1, -1 do
                  if (stored_messages[i].username == plr.Name) then
                     table.insert(last_messages, stored_messages[i].message)
                     count = count + 1
                     if (count == 15) then
                        break
                     end
                  end
               end
               local ordered_message_data = {}
               for i = #last_messages, 1, -1 do
                  table.insert(ordered_message_data, last_messages[i])
               end
               local already_stored = {}
               local unique_messages = {}
               for i = 1, #ordered_message_data do
                  local message = ordered_message_data[i]
                  if (not table.find(already_stored, message)) then
                     table.insert(unique_messages, {message = message})
                     table.insert(already_stored, message)
                  end
               end
               if (#unique_messages > 0) then
                  for _, messagedata in pairs(unique_messages) do
                     if (type(messagedata) == "table") then
                        for data_type, data_value in pairs(messagedata) do
                           if (data_type == "message") then
                              if (Length(stored_message_data) == 0) then
                                 stored_message_data = "[" .. SpaceToString(data_value) .. "]"
                              else
                                 stored_message_data = stored_message_data .. "[" .. SpaceToString(data_value) .. "]"
                              end
                           end
                        end
                     end
                  end
               end
            end
            break
         end
         return stored_message_data
      end
      function Round(int)
         return math.floor(int + 0.5)
      end
getgenv().Bender_SetFunctions = true
