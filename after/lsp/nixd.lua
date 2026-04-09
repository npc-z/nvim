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
                    expr = '(builtins.getFlake "/home/npc/.config/nixos").nixosConfigurations.ser7-nixos.options',
                },
                home_manager = {
                    expr = '(builtins.getFlake "/home/npc/.config/nixos").homeConfigurations.ser7-nixos.options',
                },
            },
        },
    },
}
