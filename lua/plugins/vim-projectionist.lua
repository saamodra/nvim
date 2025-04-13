return {
  "tpope/vim-projectionist",
  config = function()
    vim.g.projectionist_heuristics = {
      ["*"] = {
        ["app/*.rb"] = {
          alternate = "spec/{}_spec.rb",
        },
        ["app/*.slim"] = {
          alternate = "spec/{}.slim_spec.rb",
        },
        ["spec/*.slim_spec.rb"] = {
          alternate = "app/{}.slim",
        },
        ["spec/*_spec.rb"] = {
          alternate = "app/{}.rb",
        },
        ["app/javascript/deprecated/*.js"] = {
          alternate = { "spec-webpack/javascripts/{}.test.js" },
        },
        ["spec-webpack/javascripts/*.test.js"] = {
          alternate = { "app/javascript/deprecated/{}.js" },
        },
        ["src/*.ts"] = {
          alternate = { "src/{}.test.ts", "src/{}.test.tsx" },
        },
        ["src/*.tsx"] = {
          alternate = { "src/{}.test.tsx", "src/{}.test.ts" },
        },
        ["src/*.test.ts"] = {
          alternate = { "src/{}.ts", "src/{}.tsx" },
        },
        ["src/*.test.tsx"] = {
          alternate = { "src/{}.tsx", "src/{}.ts" },
        },
      },
    }
  end,
}
