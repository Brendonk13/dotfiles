" 1st 3 cmd's allow: all runtime files and packages in ~/.vim will be loaded by Neovim.
" Any customisations you make in your ~/.vimrc will now apply to Neovim as
" well as Vim. ---- from http://vimcasts.org/episodes/meet-neovim/
set runtimepath^=~/.vim runtimepath+=~/.vim/after runtimepath+=~/go/bin
let &packpath=&runtimepath
source ~/.vimrc
"/home/brendonk/.config/nvim

" Note: need syntax off for treesitter to work !!

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {enable = true},
  incremental_selection = {enable = true}
}
require'lspconfig'.pyright.setup{}
-- require'lspconfig'.gopls.setup{}
require'lspconfig'.bashls.setup{}
local saga = require 'lspsaga'
saga.init_lsp_saga()

EOF




" other guide
" https://alpha2phi.medium.com/neovim-lsp-enhanced-a3d313abee65

" From: https://www.getman.io/posts/programming-go-in-neovim/#check-it
lua <<EOF
    local nvim_lsp = require('lspconfig')

    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.completion.completionItem.snippetSupport = true

    local on_attach = function(client, bufnr)
        -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        --  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    --     -- Mappings.
    --     local opts = { noremap=true, silent=true }
    --     buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    --     buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    --     buf_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    --     buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --     buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    --     buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    --     buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    --     buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    --     buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    --     buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    --     buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    --     buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    --     buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    --     buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    --     buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    --     buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    --     -- Set some keybinds conditional on server capabilities
    --     if client.resolved_capabilities.document_formatting then
    --         buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    --     elseif client.resolved_capabilities.document_range_formatting then
    --         buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    --     end

        -- Set autocommands conditional on server_capabilities
        if client.resolved_capabilities.document_highlight then
            vim.api.nvim_exec([[
            hi def link LspReferenceRead  CursorLine
            hi def link LspReferenceWrite CursorLine
            hi def link LspReferenceText  CursorLine
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
            ]], false)
        end
    end

    nvim_lsp.gopls.setup{
        cmd = {'/home/brendon/go/bin/gopls'},
        -- for postfix snippets and analyzers
        capabilities = capabilities,
            settings = {
            gopls = {
                experimentalPostfixCompletions = true,
                analyses = {
                    unusedparams = true,
                    shadow = true,
                },
                staticcheck = true,
                },
            },
        on_attach = on_attach,
    }
EOF


" From: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion

lua << EOF
-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
    ultisnips = true;
  };
}

-- local t = function(str)
--   return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
-- 
-- local check_back_space = function()
--     local col = vim.fn.col('.') - 1
--     if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--         return true
--     else
--         return false
--     end
-- end
-- 
-- -- Use (s-)tab to:
-- --- move to prev/next item in completion menuone
-- --- jump to prev/next snippet's placeholder
-- _G.tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-n>"
--   elseif check_back_space() then
--     return t "<Tab>"
--   else
--     return vim.fn['compe#complete']()
--   end
-- end
-- _G.s_tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-p>"
--   else
--     return t "<S-Tab>"
--   end
-- end
-- 
-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
    return t "<C-R>=UltiSnips#JumpForwards()<CR>"
  elseif vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  elseif vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
    return t "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>"
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
    return t "<C-R>=UltiSnips#JumpBackwards()<CR>"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


-- local t = function(str)
--   return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
-- 
-- local is_prior_char_whitespace = function()
--   local col = vim.fn.col('.') - 1
--   if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--     return true
--   else
--     return false
--   end
-- end
-- 
-- -- Use (shift-)tab to:
-- --- move to prev/next item in completion menu
-- --- jump to the prev/next snippet placeholder
-- --- insert a simple tab
-- --- start the completion menu
-- _G.tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return vim.api.nvim_replace_termcodes("<C-n>", true, true, true)
-- 
--   elseif vim.fn["UltiSnips#CanExpandSnippet"]() == 1 or vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
--     return vim.api.nvim_replace_termcodes("<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>", true, true, true)
-- 
--   elseif is_prior_char_whitespace() then
--     return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
-- 
--   else
--     return vim.fn['compe#complete']()
--   end
-- end
-- 
-- _G.shift_tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return vim.api.nvim_replace_termcodes("<C-p>", true, true, true)
-- 
--   elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
--     return vim.api.nvim_replace_termcodes("<C-R>=UltiSnips#JumpBackwards()<CR>", true, true, true)
-- 
--   else
--     return vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true)
--   end
-- end
-- 
-- -- map{mode = 'i', keys = "<Tab>", to = [[v:lua.tab_completion()]], expression = true, plugins = true}
-- -- map{mode = 's', keys = "<Tab>", to = [[v:lua.tab_completion()]], expression = true, plugins = true}
-- -- map{mode = 'i', keys = "<S-Tab>", to = [[v:lua.shift_tab_completion()]], expression = true, plugins = true}
-- -- map{mode = 's', keys = "<S-Tab>", to = [[v:lua.shift_tab_completion()]], expression = true, plugins = true}
-- 
-- 
-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


EOF

