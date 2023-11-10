vim.g.projectionist_heuristics = {
  artisan = {
    ['*'] = {
      tinker = 'php artisan tinker'
    },
    ['app/*.php'] = {
      type = 'source',
      alternate = {
        'tests/Unit/{}Test.php',
        'tests/Feature/{}Test.php',
      },
    },
    ['app/Http/Controllers/*.php'] = {
      type = 'controller'
    },
    ['app/Models/*.php'] = {
      type = 'model',
    },
    ['routes/*.php'] = {
      type = 'routes'
    },
    ['database/seeders/*.php'] = {
      type = 'seeder'
    },
    ['database/factories/*.php'] = {
      type = 'factory'
    },
    ['database/migrations/*.php'] = {
      type = 'migration'
    },
    ['tests/Unit/*Test.php'] = {
      type = 'test',
      alternate = 'app/{}.php',
    },
    ['tests/Feature/*Test.php'] = {
      type = 'test',
      alternate = 'app/{}.php',
    },
  }
}

vim.keymap.set('n', '<leader>af', '<cmd>A<cr>', {desc = 'Alternate file'})

