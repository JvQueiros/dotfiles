-- Application bindings.
o.bind("SUPER + RETURN", "Terminal", { omarchy = "terminal" })
o.bind("SUPER + ALT + RETURN", "Tmux", { omarchy = "terminal-tmux" })
o.bind("SUPER + SHIFT + RETURN", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + F", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + ALT + ALT + F", "File manager (cwd)", { omarchy = "nautilus-cwd" })
o.bind("SUPER + SHIFT + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + ALT + B", "Browser (private)", { omarchy = "browser --private" })
o.bind("SUPER + SHIFT + M", "Music", { omarchy = "or-focus spotify" })
o.bind("SUPER + SHIFT + ALT + M", "Music TUI", { tui = "cliamp", focus = true })
o.bind("SUPER + SHIFT + N", "Editor", { omarchy = "editor" })
o.bind("SUPER + SHIFT + D", "Docker", { tui = "lazydocker" })
o.bind("SUPER + SHIFT + O", "Obsidian", { launch = "obsidian", focus = "^obsidian$" })
o.bind("SUPER + SHIFT + T", "Typora", { launch = "typora --enable-wayland-ime" })
o.bind("SUPER + SHIFT + SLASH", "Passwords", { launch = "1password" })
o.bind("SUPER + CTRL + K", "Keybindings", { launch = "~/.local/share/omarchy/bin/omarchy-menu-keybindings" })
o.bind("SUPER + SHIFT + S", "ScreenshotGrim", { launch = 'grim -g "$(slurp)" - | wl-copy' })

-- Web app bindings.
o.bind("SUPER + SHIFT + G", "ChatGPT", { webapp = "https://chatgpt.com" })
o.bind("SUPER + SHIFT + ALT + A", "Grok", { webapp = "https://grok.com" })
o.bind("SUPER + SHIFT + C", "Calendar", { webapp = "https://app.hey.com/calendar/weeks/" })
o.bind("SUPER + SHIFT + E", "Email", { webapp = "https://outlook.com" })
o.bind("SUPER + SHIFT + Y", "YouTube", { webapp = "https://youtube.com/" })
o.bind("SUPER + SHIFT + W", "WhatsApp", { webapp = "https://web.whatsapp.com/", focus = true })
o.bind("SUPER + SHIFT + P", "Google Photos", { webapp = "https://photos.google.com/", focus = true })
o.bind("SUPER + SHIFT + X", "X", { webapp = "https://x.com/" })
o.bind("SUPER + SHIFT + ALT + X", "X Post", { webapp = "https://x.com/compose/post" })

-- Add extra bindings below.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")
o.bind("SUPER + SHIFT + Y", "Yazi", { tui = "yazi" })

-- Overwrite existing bindings with hl.unbind() first if needed.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu")
hl.unbind("SUPER + SHIFT + P", "Google Photos", { webapp = "https://photos.google.com/", focus = true })
o.bind("SUPER + SHIFT + P", "Pavucontrol", { launch = "pavucontrol" })

o.unbind("CTRL + RETURN")
o.bind("ctrl + return", { flags = { "non_consuming" } })

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, { omarchy = "walker -m symbols" })
