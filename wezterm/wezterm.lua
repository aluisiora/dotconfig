local wezterm = require("wezterm")
local config = {}

config.color_scheme = "GruvboxDark"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 11.0
config.harfbuzz_features = { "calt = 0", "clig = 0", "liga = 0" }
config.window_close_confirmation = "NeverPrompt"

for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
	if gpu.backend == "Vulkan" and gpu.device_type == "IntegratedGpu" then
		config.webgpu_preferred_adapter = gpu
		config.front_end = "WebGpu"
		break
	end
end

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
	options = { theme = "GruvboxDark" },
	sections = {
		tabline_a = { "mode" },
		tabline_b = { "workspace" },
		tabline_c = { " " },
		tab_active = {
			"index",
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = {},
		tabline_y = {},
		tabline_z = { "domain" },
	},
})
tabline.apply_to_config(config)

return config
