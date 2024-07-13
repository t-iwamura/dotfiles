function toggleApp(appName, key)
  hs.hotkey.bind({"option"}, key, function()
    local app = hs.application.get(appName)
    if app == nil then
      hs.application.launchOrFocus("/Applications/" .. appName .. ".app")
    elseif app:isFrontmost() then
      app:hide()
    else
      hs.application.launchOrFocus("/Applications/" .. appName .. ".app")
    end
  end)
end

toggleApp("Alacritty", "h")
toggleApp("Notion", "j")
toggleApp("Google Chrome", "k")
toggleApp("Visual Studio Code", "l")
