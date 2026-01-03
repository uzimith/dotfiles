return {
  name = "git push",
  builder = function()
    return {
      cmd = { "git", "push" },
      components = {
        "default",
      },
    }
  end,
}
