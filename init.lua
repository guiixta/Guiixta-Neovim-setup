require("config.lazy")

-- Ativar sintaxe colorida (geralmente já vem ativado no Neovim, mas bom garantir)
vim.cmd('syntax on') -- Ou vim.o.syntax = 'on'

-- Ativar indentação automática
vim.opt.autoindent = true

-- Ativar indentação inteligente
vim.opt.smartindent = true

-- Histórico de comandos
vim.opt.history = 5000

-- Ativar numeração de linha
vim.opt.number = true
-- Ativar numeração relativa (opcional, mas muito útil no Neovim)
-- vim.opt.relativenumber = true

-- Destaca a linha em que o cursor está posicionado
vim.opt.cursorline = true

-- Ativa o clique do mouse
vim.opt.mouse = 'a'

-- Ativa o compartilhamento de área de transferência (clipboard)
vim.opt.clipboard = 'unnamedplus'

-- Nivel do TAB (Longitura de 2 espaços)
vim.opt.tabstop = 2	
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

-- NerdTreeToggle
-- Mapeamento para nvim-tree.lua (Mantendo o atalho <C-n> do NERDTree)
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })

-- Mapeamentos de navegação entre buffers
vim.keymap.set('n', '<M-Right>', ':bnext<CR>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<M-Left>', ':bprevious<CR>', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<C-x>', ':bp | bd #<CR>', { desc = 'Close Buffer' })

-- atalhos para os botões laterais do mouse
vim.keymap.set('n', '<X2Mouse>', ':bnext<CR>', { desc = 'Próximo Buffer (Mouse)', silent = true })
vim.keymap.set('n', '<X1Mouse>', ':bprevious<CR>', { desc = 'Buffer Anterior (Mouse)', silent = true })

-- Salvar Arquivos (Ctrl + s)
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save File' })
vim.keymap.set('i', '<C-s>', '<C-o>:w<CR>', { desc = 'Save File' }) -- Para modo de Inserção	

-- Salvar e Sair (Ctrl + Alt + s)
vim.keymap.set('n', '<C-M-s>', ':wq<CR>', { desc = 'Save File and Quit'}) -- Para modo normal


-- Usando '0' para copiar (yank) de acordo com sua preferência ergonômica.
-- Lembre-se: 'set clipboard=unnamedplus' já faz 'y' copiar para o clipboard do sistema.
--vim.keymap.set({'n', 'v', 'x'}, '<leader>0', '"+y', { desc = 'Yank Selection to System Clipboard' }) -- Copiar seleção ou objeto no modo normal
--vim.keymap.set('n', '<leader>00', '"+yy', { desc = 'Yank Line to System Clipboard' }) -- Copiar linha inteira no modo normal

-- Copiar (Yank) para a área de transferência do sistema com mensagem (usando <leader>0 e <leader>00)
vim.keymap.set({'n', 'v', 'x'}, '<leader>0', function()
  vim.cmd('normal! "+y') -- Executa o yank para o clipboard do sistema
  vim.cmd('echo "Copiado para o clipboard!"') -- Exibe uma mensagem customizada
end, { desc = 'Yank Selection to System Clipboard' })

vim.keymap.set('n', '<leader>00', function()
  vim.cmd('normal! "+yy') -- Executa o yank da linha para o clipboard do sistema
  vim.cmd('echo "Linha copiada para o clipboard!"') -- Exibe uma mensagem customizada
end, { desc = 'Yank Line to System Clipboard' })

