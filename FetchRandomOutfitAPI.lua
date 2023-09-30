function GetRandomOutfitInfo(userID)
    local bodyColor
    local HttpRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    local rand_outfit_name, response
    local rand_outfit_names_ids = {}

    local response_1 = HttpRequest({
        Url = "https://avatar.roblox.com/v1/users/" .. userID .. "/outfits",
        Method = "GET",
        Headers = {["Content-Type"] = "application/json"}
    })
    if (response_1.StatusCode == 429) then
        local response_2 = HttpRequest({
            Url = "https://avatar.roproxy.com/v1/users/" .. userID .. "/outfits",
            Method = "GET",
            Headers = {["Content-Type"] = "application/json"}
        })
        if (response_2.StatusCode == 429) then
            local response_3 = HttpRequest({
                Url = "https://api.joinbender.com/roblox/LookupAPI/outfit_info.php?user_id=" .. userID,
                Method = "GET",
                Headers = {["Content-Type"] = "application/json"}
            })
            if (response_3.StatusCode == 429) then
                response = nil
            else
                response = response_3
            end
        else
            response = response_2
        end
    else
        response = response_1
    end
    if (response) and (response.StatusCode == 200) then
        for i, outfit_get_data in pairs(response) do
            if (i == "Body") then
                local decoded = game:GetService("HttpService"):JSONDecode(outfit_get_data)
                if (decoded.data ~= nil) and (type(decoded.data) == "table") then
                    for _, decoded_value in pairs(decoded.data) do
                        if (type(decoded_value) == "table") then
                            local stored_id
                            local stored_name
                            for outfit_value_type, id_name_value in pairs(decoded_value) do
                                if (type(id_name_value) ~= "boolean") then
                                    if (outfit_value_type == "id") then
                                        stored_id = id_name_value
                                    else
                                        stored_name = id_name_value
                                    end
                                end
                                if (stored_id ~= nil) and (stored_name ~= nil) then
                                    local outfit_info = {
                                        id = stored_id,
                                        name = stored_name
                                    }
                                    table.insert(rand_outfit_names_ids, outfit_info)
                                    stored_id = nil
                                    stored_name = nil
                                end
                            end
                        end
                    end
                end
            end
        end
        if (#rand_outfit_names_ids > 0) then
            local function GetOutfitDetails(outfitID)
                local details_response
                local outfit_response_1 = HttpRequest({
                    Url = "https://avatar.roblox.com/v1/outfits/" .. outfitID .. "/details",
                    Method = "GET",
                    Headers = {["Content-Type"] = "application/json"}
                })
                if (outfit_response_1.StatusCode == 429) then
                    local outfit_response_2 = HttpRequest({
                        Url = "https://avatar.roproxy.com/v1/outfits/" .. outfitID .. "/details",
                        Method = "GET",
                        Headers = {["Content-Type"] = "application/json"}
                    })
                    if (outfit_response_2.StatusCode == 429) then
                        local outfit_response_3 = HttpRequest({
                            Url = "https://api.joinbender.com/roblox/LookupAPI/outfit_details.php?user_id=" .. userID,
                            Method = "GET",
                            Headers = {["Content-Type"] = "application/json"}
                        })
                        if (outfit_response_3.StatusCode == 429) then
                            details_response = nil
                        else
                            details_response = outfit_response_3
                        end
                    else
                        details_response = outfit_response_2
                    end
                else
                    details_response = outfit_response_1
                end
                if (details_response) and (details_response.StatusCode == 200) then
                    local validOutfitData = {}
                    for asset_type, asset_data in pairs(details_response) do
                        if (asset_type == "Body") then
                            local json_decoded_asset_data = game:GetService("HttpService"):JSONDecode(asset_data)
                            for decoded_asset_type, decoded_asset_data in pairs(json_decoded_asset_data) do
                                if (decoded_asset_type == "assets") and (type(decoded_asset_data) == "table") then
                                    for object_index, object_type in pairs(decoded_asset_data) do
                                        local itemInfo = {}
                                        for item_type, item_name in pairs(object_type) do
                                            if (type(item_name) == "table") then
                                                for i, v in pairs(item_name) do
                                                    if (i ~= "id" and type(v) ~= "number") then
                                                        itemInfo["Item Type"] = v
                                                    end
                                                end
                                            else
                                                if (item_type == "name") then
                                                    itemInfo["Item Name"] = item_name
                                                else
                                                    if (string.len(item_name) > 3) and (item_type ~= "currentVersionId") then
                                                        itemInfo["Item ID"] = item_name
                                                    end
                                                end
                                            end
                                        end
                                        table.insert(validOutfitData, itemInfo)
                                    end
                                end
                                if (decoded_asset_type == "bodyColors") and (type(decoded_asset_data) == "table") then
                                    for color_id_type, color_data in pairs(decoded_asset_data) do
                                        if (color_id_type == "headColorId") and (color_data) and (type(color_data) == "number") then
                                            bodyColor = color_data
                                        end
                                    end
                                end
                            end
                        end
                    end
                    return validOutfitData
                else
                    return "Rate Limited from Details API"
                end
            end
            local randomIndex = math.random(1, #rand_outfit_names_ids)
            local randomOutfit = rand_outfit_names_ids[randomIndex]
            rand_outfit_name = randomOutfit.name
            local outfitDetails = GetOutfitDetails(randomOutfit.id)
            if (outfitDetails) and (type(outfitDetails) == "table") then
                if (bodyColor) and (bodyColor ~= nil) then
                    local api_url = "https://api.joinbender.com/roblox/LookupAPI/get_color_by_code.php?code=" .. bodyColor
                    local bodyColor_response = HttpRequest({
                        Url = api_url,
                        Method = "GET",
                        Headers = {["Content-Type"] = "application/json"}
                    })
                    if (bodyColor_response) and (bodyColor_response.StatusCode == 200) then
                        for index, bodycolor_data in pairs(bodyColor_response) do
                            if (type(bodycolor_data) == "string") and (index == "Body") then
                                game.Players:Chat(":paint me " .. bodycolor_data)
                            end
                        end
                    end
                end
                game.Players:Chat(":unshirt me")
                game.Players:Chat(":unpants me")
                game.Players:Chat(":removehats me")
                for _, assetInfo in pairs(outfitDetails) do
                    local assetType = assetInfo["Item Type"]
                    local assetName = assetInfo["Item Name"]
                    local assetID = assetInfo["Item ID"]
                    local function SendMessage(msg)
                        game.Players:Chat(msg)
                    end

                    if (assetType == "Package") then
                        SendMessage(":package me " .. assetID)
                    elseif (assetType == "Hat") then
                        game.Players:Chat(":hat me " .. assetID)
                    elseif (assetType == "Shirt") then
                        game.Players:Chat(":shirt me " .. assetID)
                    elseif (assetType == "Pants") then
                        game.Players:Chat(":pants me " .. assetID)
                    elseif (assetType == "Face") then
                        game.Players:Chat(":face me " .. assetID)
                    elseif (assetType == "Tshirt") then
                        game.Players:Chat(":tshirt me " .. assetID)
                    elseif (assetType == "HairAccessory") then
                        game.Players:Chat(":hat me " .. assetID)
                    end
                end
            end
        end
        return rand_outfit_name
    end
end
