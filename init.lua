LIVESHARE_USERNAME = "EchoPrograms"

require("config.lazy")
require("config.remap")
require("config.treesitter")
require("autoclose").setup()

vim.lsp.inlay_hint.enable(true)

-- Folding 
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end,
    fold_virt_text_handler = handler
})

vim.keymap.set('n', '<CR>', function()
  local winid = vim.api.nvim_get_current_win()
  local line = vim.api.nvim_win_get_cursor(winid)[1]
  local foldlevel = vim.fn.foldlevel(line)

  if foldlevel > 0 then
    vim.cmd('normal! za')
  else
    vim.cmd('normal! <CR>')
  end
end, { silent = true })

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- Appearance
vim.diagnostic.config({
  -- Use the default configuration

  -- Alternatively, customize specific options
  -- virtual_lines = {
    -- Only sh ow virtual line diagnostics for the current cursor line
    -- current_line = false,
    -- },
  })

  vim.wo.number = true
  vim.wo.relativenumber = true
  vim.opt.signcolumn = "yes"
  vim.opt.termguicolors = true

  vim.opt.scrolloff = 8;

  vim.cmd("colorscheme habamax")
  vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "#000000" })
  vim.api.nvim_set_hl(0, "LineNr", { bg = "#000000" })
  vim.api.nvim_set_hl(0, "FoldColumn", { bg = "#000000" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000000" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#000000" })

  vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight text on yank",
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
      vim.highlight.on_yank({ timeout = 50 })
    end,
  })

  -- Behavior

  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = 2
  vim.opt.expandtab = true

  vim.opt.smartindent = true

  vim.opt.wrap = false;

  vim.opt.swapfile = false;
  vim.opt.backup = false;
  vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
  vim.opt.undofile = true;

  vim.opt.hlsearch = false;
  vim.opt.incsearch = true;

  vim.opt.updatetime = 50

  vim.opt.isfname:append("@-@")

  vim.opt.splitright = true

  -- Marks
  require('marks').setup({
    -- whether to map keybinds or not. default true
    default_mappings = true,
    -- which builtin marks to show. default {}
    builtin_marks = { ".", "<", ">", "^" },
    -- whether movements cycle back to the beginning/end of buffer. default true
    cyclic = true,
    -- whether the shada file is updated after modifying uppercase marks. default false
    force_write_shada = false,
    -- how often (in ms) to redraw signs/recompute mark positions. 
    -- higher values will have better performance but may cause visual lag, 
    -- while lower values may cause performance penalties. default 150.
    refresh_interval = 250,
    -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
    -- marks, and bookmarks.
    -- can be either a table with all/none of the keys, or a single number, in which case
    -- the priority applies to all marks.
    -- default 10.
    sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
    -- disables mark tracking for specific filetypes. default {}
    excluded_filetypes = {},
    -- disables mark tracking for specific buftypes. default {}
    excluded_buftypes = {},
    -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
    -- sign/virttext. Bookmarks can be used to group together positions and quickly move
    -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
    -- default virt_text is "".
    bookmark_0 = {
      sign = "⚑",
      virt_text = "hello world",
      -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
      -- defaults to false.
      annotate = false,
    },
    mappings = {}
  })


