return {
    "tpope/vim-abolish",
    cmd = { "Abolish", "S" },
    event = { "InsertEnter" },
    enabled = false,
    config = function()
        local abolish = require("core.abolish")
        abolish.reload_mappings()
    end,
}
