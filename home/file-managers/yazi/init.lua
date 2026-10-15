require("duckdb"):setup({
  mode = "standard",        -- default: "summarized"
  cache_size = 1000,        -- default: 500
  row_id = true,            -- default: false
  minmax_column_width = 30, -- default: 21
  column_fit_factor = 10.0  -- default: 10.0
})
