return {
  "norcalli/nvim-colorizer.lua",
  lazy = false,
  config = function()
    require 'colorizer'.setup({
      '*',
    }, { css = true, css_fn = true })
  end,
}
