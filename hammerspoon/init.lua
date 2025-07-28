-- Pre-load some modules
local timer = hs.timer
local alert = hs.alert
local mouse = hs.mouse
local eventtap = hs.eventtap

hs.application.enableSpotlightForNameSearches(true)

function warpPointerToWindow(win)
   local winFrame = win:frame()
   x = winFrame.x + winFrame.w / 2
   y = winFrame.y + winFrame.h / 2
   hs.mouse.absolutePosition({ x = x, y = y })
end

function cycleAppWindows(app)
   local windows = app:allWindows()
   if #windows < 2 then
      return
   end

   -- Get the windows into a deterministic order
   table.sort(windows, function (a, b) return a:id() < b:id() end)

   local currentWin = hs.window.focusedWindow()
   local nextWin = windows[1]
   for i, win in ipairs(windows) do
      if win:id() == currentWin:id() then
         local nextIndex = (i % #windows) + 1
         nextWin = windows[nextIndex]
         break
      end
   end

   nextWin:focus()
   hs.timer.doAfter(0.7, function()
                       warpPointerToWindow(nextWin)
   end)
end

function focusAndWarpPointerToApp(appName)
   -- If it is already the focused application then cycle through its windows
   local currentApp = hs.application.frontmostApplication()
   if currentApp and currentApp:name() == appName then
      cycleAppWindows(currentApp)
      return
   end

   hs.application.launchOrFocus(appName)
   hs.timer.doAfter(0.7, function()
                       hs.alert.show(appName)
                       local app = hs.application.get(appName)
                       local win = app:mainWindow()
                       if win then
                          warpPointerToWindow(win)
                       end
   end)
end

hs.hotkey.bind({}, "padEnter", function ()
      focusAndWarpPointerToApp("Emacs")
end)

hs.hotkey.bind({}, "pad+", function ()
      focusAndWarpPointerToApp("WezTerm")
end)

hs.hotkey.bind({}, "pad3", function ()
      focusAndWarpPointerToApp("Google Chrome")
end)

hs.hotkey.bind({}, "pad2", function ()
      focusAndWarpPointerToApp("Slack")
end)

hs.hotkey.bind({}, "pad0", function ()
      focusAndWarpPointerToApp("Microsoft Teams")
end)

hs.hotkey.bind({}, "pad1", function ()
      focusAndWarpPointerToApp("Microsoft Outlook")
end)
