return {
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
  settings = {
    nixd = {
      -- nixpkgs = {
      --   expr = "import <nixpkgs> { }",
      -- },
      -- options = {
      --   nixos = {
      --     expr = '(builtins.getFlake "' .. vim.env.HOME .. '/.config/nixos").nixosConfigurations.mio.options',
      --   },
        -- home_manager = {
        --   expr = '(builtins.getFlake "' .. vim.env.HOME .. '/.config/nixos").homeConfigurations.mio.options',
        -- },
      -- },
    },
  },
}
