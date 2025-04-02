local function get_current_user()
    local user = os.getenv("USER") or os.getenv("USERNAME")
    return user or "Unknown"
end

local current_user = get_current_user()
require("ccryptor").setup({
    dir_path = '/home/' .. current_user .. '/gitprojects/personal/personal_notes/journal/',
})


--------------------------------------------------------------------------------

-- oil setup
require("oil").setup({
	cleanup_delay_ms = 1000,
	view_options = {
	  show_hidden = true
	}
})
vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

--------------------------------------------------------------------------------

-- glow setup: https://github.com/ellisonleao/glow.nvim?tab=readme-ov-file#setup
--require('glow').setup({
--  width = 80,
--  height = 100,
--  width_ratio = 1, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
--  height_ratio = 1,
--})

--------------------------------------------------------------------------------

-- TELESCOPE FUNCTIONS
-- part of the config
-- Set your fixed file path here
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
-- Set your fixed file path here
local fixed_path = "~/gitprojects/personal/"
function recent_files()
  require('telescope.builtin').find_files({
    prompt_title = "Recent Files",
    cwd = fixed_path,
    find_command = { "sh", "-c", "find " .. fixed_path .. " -type f -not -path '*/\\.git/*' -printf '%T@ %p\n' | sort -n -r | cut -d' ' -f2-" },
  })
end

local custom_actions = {}
custom_actions.insert_path = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  vim.api.nvim_put({ entry.value }, '', false, true)
end

-- telescope config
require('telescope').setup({
  defaults = {
    scroll_strategy = 'limit',
    layout_strategy = 'vertical',
    layout_config = {
      mirror = true,
      prompt_position = 'bottom',
      preview_height = 0.65,
      width = 0.75,
      height = 0.95,
    },
    mappings = {
      i = {
        -- Map Ctrl-i to insert_path in insert mode
        ["<M-i>"] = custom_actions.insert_path
      },
      n = {
        -- Map i to insert_path in normal mode
        ["<M-i>"] = custom_actions.insert_path
      },
    },  
  }
})
require('telescope').load_extension('fzf')

------------------------------------------------------------------------------
-- fzf-vim config
-- local actions = require "fzf-lua.actions"
-- require'fzf-lua'.setup {
--   winopts = {
--     height = 0.95,
--     preview = {
--       layout = 'vertical',
--     },
--   },
-- }

------------------------------------------------------------------------------

-- leap 
-- require('leap').create_default_mappings()


-- add flash configuration
-- TODO: add a setting fix so that flash doesn't override F and f 
require("flash").setup({ modes = { char = { enabled = false }}})
vim.keymap.set("n", "s", function() require("flash").jump({ modes = { char = { enabled = false }}}) end, { desc = "Flash Jump (Normal)" })
vim.keymap.set("v", "s", function() require("flash").jump({ modes = { char = { enabled = false }}}) end, { desc = "Flash Jump (Normal)" })
-- vim.keymap.set("n", "S", function() require("flash").jump({ modes = { char = { enabled = false }}}) end, { desc = "Flash Jump (Normal)" })
vim.keymap.set("i", "<C-s>", function() require("flash").jump({ modes = { char = { enabled = false }}}) end, { desc = "Flash Jump (Insert)" })
vim.keymap.set("i", "<C-s>", function() require("flash").jump({ modes = { char = { enabled = false }}}) end, { desc = "Flash Jump (Insert)" })

-- function() open_flash() 
--   require("flash").
-- end

------------------------------------------------------------------------------

-- vim keybindings below 
vim.cmd [[
set splitbelow
set splitright

let mapleader = "\<Space>"

colorscheme gruvbox 

" was causing problems if left on with multiple tmux windows, I can manage my own saves
set noswapfile 

" turning mouse off so that I can click in and it won't move my cursor
set mouse=
" set clipboard=unnamedplus
set number relativenumber
set scrolloff=5

set nowrap
nnoremap <Leader>z :set wrap!<CR> 



" toggle side numbers 
nnoremap <Leader>n :call ToggleSidenums()<CR>
function! ToggleSidenums()
  if &relativenumber
    set norelativenumber
  else
    set relativenumber " number " used to use number/nonumber when I was hiding these 
  endif
endfunction

" toggle listchars
nnoremap <Leader>N :call ToggleListchars()<CR>
function! ToggleListchars()
  if &list
    set listchars= nolist
  else
    set list listchars=tab:>␣,trail:~,extends:>,precedes:<,space:·
  endif
endfunction

" rebind J and K to be { and } for jumping whitespace
vnoremap J }
vnoremap K {
nnoremap J }
nnoremap K {

" copy , pasting is handling by going to insert and hitting "ctrl + shift + v" 
vnoremap c "*y
vnoremap <Leader>c "*y
nnoremap <Leader>c "*y
vnoremap y "*y

" pasting just in case 
vnoremap <Leader>v "*p
nnoremap <Leader>v "*p


" cutting
vnoremap <Leader>x "*d
nnoremap <Leader>x "*d

" saving file
nnoremap <Leader>w :wa<CR>
nnoremap <Leader>s :wa<CR>

" closing
nnoremap <Leader>C :close<CR>
nnoremap <Leader>q :wq<CR>
nnoremap <Leader>Q :q!<CR>

" copilot
let g:copilot_filetypes = {
      \ '*': v:true,
      \ }

" tabs and buffers
" tab switching using ctrl + tab
nnoremap <Leader>j :tabprevious<CR>
nnoremap <Leader>k :tabnext<CR>
" tab with just hold 
nnoremap <M-<> :tabprevious<CR>
nnoremap <>->> :tabnext<CR>

" vim-windowswap
let g:windowswap_map_keys = 0
nnoremap <silent> <leader>WW :call WindowSwap#EasyWindowSwap()<CR>


" vim markdown renderer
" let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_toc_autofit = 1
" let g:vim_markdown_follow_anchor = 1
" let g:vim_markdown_no_extensions_in_markdown = 1
" let g:vim_markdown_strikethrough = 1
" let g:vim_markdown_autowrite = 1

" markdown-renderer
" use a custom port to start server or empty for random
let g:mkdp_open_to_the_world = 1
let g:mkdp_port = '3010'
let g:mkdp_open_ip = $MARKDOWN_IP
let g:mkdp_echo_preview_url = 1
let g:mkdp_browser = 'none'
nnoremap <Leader>m :MarkdownPreviewToggle<CR>

nnoremap <Leader>, :tabprevious<CR>
nnoremap <Leader>. :tabnext<CR>

" rebind :bprev and :bnext
nnoremap <Leader>J :bprev<CR>
nnoremap <Leader>K :bnext<CR>
 
" copilot remap autocomplete to ctrl + l when in insert mode 
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Telescope searching
" clear the highlighting from search
nnoremap <Leader><Enter> :nohlsearch<CR> " telescope
" map <Leader>F to search for the current word under the cursor
nnoremap <Leader>W viw"0y<space>:Telescope grep_string<CR><Esc>
"nnoremap <Leader>F :Telescope grep_string<CR><Esc>
"nnoremap <Leader>F :FzfLua grep_visual<CR>

nnoremap <Leader>f :Telescope live_grep<CR>
nnoremap <Leader>F :Telescope live_grep hidden=true no_ignore=true<CR>
nnoremap <Leader>p :Telescope find_files<CR>
inoremap <M-i> <Esc>:Telescope find_files hidden=true<CR>
noremap  <M-i> <Esc>:Telescope find_files hidden=true<CR>
nnoremap <Leader>o :Telescope oldfiles<CR><Esc>
nnoremap <Leader>C :Telescope current_buffer_fuzzy_find<CR>


" reload configuration
nnoremap <Leader>R :source ~/.config/nvim/init.lua<CR>

" Function to scroll approximately 1/3 of the page down
function! ScrollThirdDown()
    let l:height = winheight(0)
    let l:scroll_amount = l:height / 3
    execute "normal! " . l:scroll_amount . "\<C-E>"
endfunction

" Function to scroll approximately 1/3 of the page up
function! ScrollThirdUp()
    let l:height = winheight(0)
    let l:scroll_amount = l:height / 3
    execute "normal! " . l:scroll_amount . "\<C-Y>"
endfunction

" Map <C-D> to scroll down 1/3 of the page
nnoremap <C-D> :call ScrollThirdDown()<CR>

" Map <C-U> to scroll up 1/3 of the page
nnoremap <C-U> :call ScrollThirdUp()<CR>

" lazygit
map <leader>G :LazyGit<CR>

" GitBlame
map <leader>g :GitBlameToggle<CR>jk

" buffer switching like Vimium
nnoremap <Leader>b :Telescope buffers<CR><Esc>
"nnoremap T :Telescope buffers<CR>
nnoremap <Leader>T :Telescope buffers<CR>
nnoremap <Leader>t :Telescope buffers<CR>

" toggle term key bind | toggleterm
"nnoremap <Leader>t :ToggleTerm<CR>i
" binding to open terminal in current dir
" Set a mapping for Normal, Insert, and Terminal mode
nnoremap <C-\> :ToggleTerm dir=%:p:h<CR>i
inoremap <C-\> <Esc>:ToggleTerm dir=%:p:h<CR>i
tnoremap <C-\> <C-\><C-n>:ToggleTerm dir=%:p:h<CR>i


" set a keybind to insert todo list items
inoremap <C-t> - [ ]<Space>
" Insert the text in normal mode when pressing Ctrl + t
nnoremap <C-t> i- [ ] <Esc>a

set ignorecase
set smartcase
" set incsearch, this should remain off
set noincsearch

tnoremap <Esc> <C-\><C-n>

" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
"when indenting with '>', use 2 spaces width
set shiftwidth=2


" expirimental tmux navigator
let g:tmux_navigator_no_mappings = 1
" let  g:tmux_navigator_no_wrap = 1

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
noremap <silent> <C-h> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <C-j> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <C-k> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <C-l> :<C-U>TmuxNavigateRight<cr>
noremap <silent> <C-/> :<C-U>TmuxNavigatePrevious<cr>

" mapping with meta 
nnoremap <M-Left> <C-w>h
nnoremap <M-Down> <C-w>j
nnoremap <M-Up> <C-w>k
nnoremap <M-Right> <C-w>l
noremap <silent> <M-Left>  :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <M-Down>  :<C-U>TmuxNavigateDown<cr>
noremap <silent> <M-Up>    :<C-U>TmuxNavigateUp<cr>
noremap <silent> <M-Right> :<C-U>TmuxNavigateRight<cr>


" limelight colorscheme help https://github.com/junegunn/limelight.vim?tab=readme-ov-file#options
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Function to toggle Limelight
function! ToggleLimelight()
  if exists("g:limelight_active") && g:limelight_active
    Limelight!
    let g:limelight_active = 0
  else
    Limelight
    let g:limelight_active = 1
  endif
endfunction

" Map <Leader>L to toggle Limelight
nnoremap <Leader>L :call ToggleLimelight()<CR>



" also for goyo
" let g:goyo_height='80%'
" let g:goyo_width='80%'




" bind ctrl + shift + d to insert (date +'%y%m%d - %H:%M %p') 
" nnoremap <C-D> i<C-R>=strftime("%y%m%d")<CR>
" do the same but from insert mode
inoremap <C-D> <C-R>=strftime("%y%m%d")<CR>


nnoremap <Leader>U :lcd %:p:h<CR>

" pandoc functions
function! ConvertWithPandoc()
  " Get the current file's full path and extension
  let l:filepath = expand('%:p')
  let l:fileext = expand('%:e')

  " Determine the Pandoc command based on the file extension
  if l:fileext ==# 'md'
    let l:command = 'pandoc -f markdown -t mediawiki ' . shellescape(l:filepath)
  elseif l:fileext ==# 'wiki'
    let l:command = 'pandoc -f mediawiki -t markdown ' . shellescape(l:filepath)
  else
    echo "Unsupported file extension: " . l:fileext
    return
  endif

  " Run the Pandoc command and capture the output
  let l:output = system(l:command)

  " Check for errors during the Pandoc execution
  if v:shell_error != 0
    echo "Pandoc conversion failed!"
    return
  endif

  " Open a new tab and load the output
  execute 'tabnew'
  setlocal buftype=nofile   " Mark as temporary buffer
  setlocal bufhidden=hide   " Do not unload the buffer when abandoned
  setlocal noswapfile       " Do not create a swap file
  call setline(1, split(l:output, "\n"))
  echo "Converted content loaded in a new tab"
endfunction


" Map the function to a command
command! PandocConvert call ConvertWithPandoc()
" Map <Leader>M to run the ConvertWithPandoc function
nnoremap <Leader>M :call ConvertWithPandoc()<CR>



]]

--------------------------------------------------------------------------------

-- these keybinds need to come after the vim bindinds otherwise they don't load until reloading the configuration
vim.api.nvim_set_keymap('n', '<leader>h', ':lua recent_files()<CR>', { noremap = true, silent = true })


require"gitlinker".setup({
  opts ={
    add_current_line_on_normal_mode = false,
    action_callback = require"gitlinker.actions".copy_to_clipboard,
    print_url = true,
  },
  callbacks = {
    ["github.com"] = require"gitlinker.hosts".get_github_type_url,
    ["gitlab.com"] = require"gitlinker.hosts".get_gitlab_type_url,
    ["gitlab.pololu.work"] = require"gitlinker.hosts".get_gitlab_type_url,
    [".pololu.work"] = require"gitlinker.hosts".get_gitlab_type_url,
  },
  mappings = "<leader>gy"
})

--------------------------------------------------------------------------------
local Terminal = require('toggleterm.terminal').Terminal

-- Define the on_close function
local function on_terminal_close(term)
  -- Send the 'exit' command to the terminal
  term:send("exit\n")
end

require("toggleterm").setup({
  -- open_mapping = [[<c-\>]],
  direction = 'float',
  autochdir = false,
  --on_close = on_terminal_close, -- run the on_close function when the terminal closes
  start_in_insert = false,
})


-- disable git blame by default
vim.g.gitblame_enabled = 0


--------------------------------------------------------------------------------

-- TODO FOR NEOVIM | NVIM TODO 
-- todo for neovim | neovim todo
--
--
--
-- vim-markdown
  -- table of contents on demmand for a markdown file
  -- add something to fold lines 
  -- make vim highlight the links like https:// etc in markdown docs
--
--
-- also make something to hold and then go to the next tab, like ctrl + ta make something to quickly open the new tab
--  mayeb like alt + > or < ? 
--
--  find something to insert the name of a file in the current buffer: (oh for linking files to each other)
--    but I want to search for something in telescope or smething like that
--    or maybe just a way to copy the file name to the clipboard:
-- SOLUTION-: Almost what you're asking for, and it might do: in INSERT mode, Ctrl+R % pulls the current filename into where you are (command prompt, edit buffer, ...). See this Vim Tip for more.
--
--
--
-- VIM centered focus mode? 
-- also make a keybinding or keymap for my dz60 that's going to allow me to use jk or kj to chord escape 
--
-- show the most recently edited files in a dir
--
-- find another markdown renderer or something for easy viewing, maybe something in the broswer would be best?
-- make something for turning on copilot (leave it off by default) i'm thinking <leader>A 
-- 
--
-- add a keybinding for git for vim that copies the git url to the system clipboard? 


-- make a plugin that lets me first highlight some text block and then fuzzy search for things inside of just that highligted block 
--
-- redo the keybind for ctrld to just be the date and then ctrlD to be the date + day like "240719 Friday"

