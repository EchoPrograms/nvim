return {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
        -- Add any additional settings specific to lua_ls here
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' }, -- Example: Add 'vim' to globals to avoid undefined global warnings
                },
            },
        },
    }
