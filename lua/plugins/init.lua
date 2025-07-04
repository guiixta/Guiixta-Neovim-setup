-- ~/.config/nvim/lua/plugins/init.lua
-- Este arquivo deve retornar uma tabela de plugins

return { 
  -- Colorscheme (exemplo: Catppuccin)
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      -- Este comando aplica o tema
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  -- Linhas de indentação (substitui IndentLine)
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },

    -- Explorador de arquivos (substitui NerdTree)
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- Para ícones de arquivos
    },
    config = function()
      require("nvim-tree").setup {
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true, -- Já está true para mostrar por padrão
        },
        actions = {
          open_file = {
            quit_on_open = true, -- Fecha nvim-tree ao abrir um arquivo
          },
        },
      }
    end -- Fim do config = function()
  },

  -- lspconfig para analise de errors em linguagens

  {
      'neovim/nvim-lspconfig',
      dependencies = {
          'williamboman/mason.nvim', -- Gerenciador de LSP servers
          'williamboman/mason-lspconfig.nvim', -- Integração Mason com lspconfig
          'hrsh7th/nvim-cmp', -- Já tem
          'hrsh7th/cmp-nvim-lsp', -- Já tem
          'L3MON4D3/LuaSnip', -- Snippets (opcional, mas comum)
          'saadparwaiz1/cmp_luasnip', -- Integração cmp-luasnip (opcional)
      },
      config = function()
          -- Configuração do Mason (gerenciador de LSP servers)
          require('mason').setup()
          require('mason-lspconfig').setup({
              ensure_installed = {
                  "pyright", -- Para Python (se você usa)
                  "intelephense", -- Para PHP (se você usa)
                  "bashls", -- Para Shell
                  "html", -- Para HTML
                  "cssls", -- Para CSS
                  "ts_ls", -- Para JavaScript/TypeScript
                  -- Adicione outros LSPs que você usa aqui
              },
          })

          -- Configuração dos LSP Servers específicos
          local lspconfig = require('lspconfig')
          local capabilities = require('cmp_nvim_lsp').default_capabilities()

          -- Exemplo de configuração para Pyright (Python)
          lspconfig.pyright.setup({
              capabilities = capabilities,
              -- Outras configurações específicas do pyright, se necessário
          })

          -- Exemplo de configuração para Intelephense (PHP)
          lspconfig.intelephense.setup({
              capabilities = capabilities,
              -- Outras configurações específicas do intelephense, se necessário
          })

          -- Exemplo de configuração para Bash Language Server
          lspconfig.bashls.setup({
              capabilities = capabilities,
          })

          -- Exemplo de configuração para HTML/CSS/TS/JS
          lspconfig.html.setup({ capabilities = capabilities })
          lspconfig.cssls.setup({ capabilities = capabilities })
          lspconfig.ts_ls.setup({ capabilities = capabilities })

          -- Mapeamentos de teclas para LSP (exemplo, você pode ajustar)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to Declaration' })
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to References' })
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename Symbol' })
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostic' })
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })
          vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format File' })

          -- Configuração de como os diagnósticos são exibidos
          vim.diagnostic.config({
              virtual_text = true, -- Mostrar erros/avisos ao lado do código
              signs = true, -- Mostrar ícones na coluna de sinais
              update_in_insert = false, -- Não atualizar diagnósticos no modo de inserção
              severity_sort = true, -- Priorizar erros sobre avisos
          })
      end
  },

  -- bufferline
  {
    'akinsho/bufferline.nvim', 
    version = "*", 
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.o.mousemoveevent = true
      local bufferline = require('bufferline')
        
      bufferline.setup({
        options = {
          mode = 'buffers', -- ou 'tabs' para gerenciar tabpages
          numbers = 'ordinal', -- ou 'buffer_id', 'ordinal', 'both'
          hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
          },
          diagnostics = 'nvim_lsp', -- Mostra indicadores de erro/warning do LSP por buffer
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = ' '
            for e, n in pairs(diagnostics_dict) do
              local sym = level:match('error') and " " or (level:match('warn') and " " or " ") -- Pequeno círculo
              s = s .. n .. sym .. ' '
            end
            return s
          end,
          offsets = {
            {
              filetype = "NvimTree", -- Esconde a bufferline quando nvim-tree estiver ativo
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
            }
          },
          separator_style = "slant",
          style_preset = bufferline.style_preset.no_italic,
          always_show_bufferline = true,
          show_close_icon = true,
          show_buffer_close_icons = true,
       
          themable = true,

          indicator = {
            style = 'underline',
          },

         
        },
        highlights = {
          buffer_selected = {      
            bold = true,
          },  
        } 
      })
    end,
  },





  -- Linha de status (substitui Vim-Airline)
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto', -- Ou 'catppuccin'
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          show_modified_status = true,
        },
         sections = {
          lualine_a = {'mode'}, 
          lualine_c = {'diff', 'diagnostics'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
          tabline = {},
          plugins = {
          ['lualine.modules.buffers'] = {
            max_length = vim.o.columns * 2 / 3,
            show_filename_only = true,
            mode = 0,
            file_status = true,
            -- buffers_sep = ' > ', 
            -- padding = { left = 1, right = 1 },
          },
        },
      }
      end
  },
    

  -- Fuzzy finder (substitui Vim-Ctrlp)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = "move_selection_previous",
              ["<C-j>"] = "move_selection_next",
            },
          },
        },
      })
      -- Mapeamentos de teclas para Telescope
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    end
  },

  -- Comentador de código (substitui NerdCommenter)
  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false, -- Carregar este plugin sempre
  },

	
  -- Alpha-Nvim Tela inicial (substitui o vim-startify)
	{
	  'goolord/alpha-nvim',
	  config = function ()
		require'alpha'.setup(require'alpha.themes.dashboard'.config)
	    end
	},


  -- Emmet para HTML/CSS
  { 'mattn/emmet-vim' },

  -- nvim-cmp: framework para autocompletar
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',   -- Fonte de autocompletar para LSP
      'L3MON4D3/LuaSnip',       -- Motor de snippets
      'saadparwaiz1/cmp_luasnip', -- Fonte de autocompletar para Luasnip
      'hrsh7th/cmp-buffer',     -- Fonte de autocompletar para buffer
      'hrsh7th/cmp-path',       -- Fonte de autocompletar para caminhos
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Concluir com Enter
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    end
  },
  -- Nvim-lint: para linters que não são LSP (substitui partes do Vim-ALE)
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        -- Exemplo: 'javascript': { 'eslint' },
        -- 'python': { 'pylint' },
      }
      -- Você pode adicionar um autocmd para rodar o linter ao salvar o arquivo
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end
  }

}
