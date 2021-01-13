import Config

alias IO.ANSI.Table.Spec

config :islands_client_summary,
  headers: ["row", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

options = [
  align_specs: [
    right: "row",
    center: 1,
    center: 2,
    center: 3,
    center: 4,
    center: 5,
    center: 6,
    center: 7,
    center: 8,
    center: 9,
    center: 10
  ],
  bell: false,
  count: 10,
  style: :game,
  header_fixes: %{"Row" => ""},
  sort_specs: ["row"],
  sort_symbols: [asc: ""]
]

config :islands_client_summary,
  left_options:
    Keyword.merge(options,
      spec_name: "left",
      margins: [top: 0, bottom: 1, left: 2]
    )

config :islands_client_summary,
  right_options:
    Keyword.merge(options,
      spec_name: "right",
      margins: [top: -12, bottom: 1, left: 35]
    )
