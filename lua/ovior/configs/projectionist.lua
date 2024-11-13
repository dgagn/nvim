vim.g.projectionist_heuristics = {
  ['*.c'] = {
    type = 'source',
    alternate = '{}.h'
  },
  ['angular.json'] = {
    ['src/app/*.ts'] = {
      type = 'source',
      alternate = 'src/app/{}.spec.ts',
    },
    ['src/app/*.spec.ts'] = {
      type = 'test',
      alternate = 'src/app/{}.ts',
    },
  },
  ['Cargo.toml'] = {
    ['migrations/*.sql'] = {
      type = 'migration',
    },
    ['src/*.rs'] = {
      type = 'source',
    }
  },
  ['gradlew'] = {
    ['src/main/java/*.java'] = {
      type = 'source',
      alternate = 'src/test/java/{}Test.java',
    },
    ['src/test/java/*Test.java'] = {
      type = 'test',
      alternate = 'src/main/java/{}.java',
    },
  },
  ['pom.xml'] = {
    ['src/main/java/*.java'] = {
      type = 'source',
      alternate = 'src/test/java/{}Test.java',
    },
    ['src/test/java/*Test.java'] = {
      type = 'test',
      alternate = 'src/main/java/{}.java',
    },
  },
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

vim.keymap.set('n', '<leader>a', '<cmd>A<cr>', {desc = 'Alternate file'})
