local hostname = vim.trim(vim.fn.system("hostname"))
local home = vim.env.HOME
local flake = string.format("(builtins.getFlake \"%s/.config/nixos\")", home)

local is_darwin = vim.fn.has("macunix") == 1

local config_key = is_darwin and string.format("darwinConfigurations.%s", hostname)
    or string.format("nixosConfigurations.%s", hostname)

---@type vim.lsp.Config
return {
    cmd = { "nixd" },
    settings = {
        nixd = {
            nixpkgs = {
                expr = "import <nixpkgs> { }",
            },
            formatting = {
                command = { "alejandra" },
            },
            options = {
                nixos = {
                    expr = string.format("%s.%s.options", flake, config_key),
                },
                ["home-manager"] = {
                    expr = string.format(
                        "%s.%s.options.home-manager.users.type.getSubOptions []",
                        flake,
                        config_key
                    ),
                },
            },
        },
    },
}
